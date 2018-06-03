<template>
  <section class="events clearfix">
    <div class="row">
      <div class="form__group form__group--3of12"></div>
      <div class="form__group form__group--6of12">
        <h2 class="events__title">
          Events
        </h2>
        <select v-model="kindFilter" class="form__field">
          <option value="">Select an Event Type</option>
          <option v-for="kind in kinds" :value="kind">{{kind}}</option>
        </select>
      </div>
    </div>
    <template v-if="photoevents.length === 0">
      <p>There are no events! Add an event using the link on this page.</p>
    </template>
    <template v-else>
      <transition-group tag="ul" name="photoevent" class="events__list">
        <photoevent v-for="photoevent in filteredEvents" :photoevent="photoevent" :key="photoevent.id" class="photoevent"></photoevent>
      </transition-group>
    </template>
  </section>
</template>

<script>
  import photoevent from './components/photoevent'
  import Photoevent from './models/photoevent'

  export default {
    data: function () {
      let photoevents;
      let parent = this.$parent;
      if (this.$parent.events) {
        photoevents = parent.events.map(function(photoevent) {
          let newPhotoevent = Photoevent.loadFromJSON(photoevent);
          newPhotoevent["eventPath"] = parent.eventPath.replace('$ID', newPhotoevent.id);
          return newPhotoevent;
        });
      }

      let allKinds = photoevents.reduce((result, currentEvent) => {
        if (!result.includes(currentEvent.kind.name)) {
          result.push(currentEvent.kind.name);
        }
        return result;
      }, []);

      return {
        photoevents: photoevents,
        kindFilter: '',
        kinds: allKinds
      }
    },
    components: {
      photoevent
    },
    methods: {
    },
    computed: {
      filteredEvents() {
        if (this.kindFilter === "") {
          return this.photoevents;
        }

        return this.photoevents.filter(event => {
          return event.kind.name === this.kindFilter;
        });
      }
    }
  }
</script>
