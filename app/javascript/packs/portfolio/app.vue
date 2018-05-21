<template>
  <section class="events clearfix">
    <div class="row">
      <div class="form__group form__group--3of12"></div>
      <div class="form__group form__group--6of12">
        <h2 class="events__title">
          Events
        </h2>
        <select v-model="kindFilter" @change="applyFilter" class="form__field">
          <option value="">Select an Event Type</option>
          <option v-for="kind in kinds" :value="kind">{{kind}}</option>
        </select>
      </div>
    </div>
    <template v-if="photoevents.length === 0">
      <p>There are no events! Add an event using the link on this page.</p>
    </template>
    <template v-else>
      <ul class="events__list">
        <transition-group name="photoevents" mode="out-in">
          <photoevent v-for="photoevent in filteredEvents" :photoevent="photoevent" :key="photoevent.id"></photoevent>
        </transition-group>
      </ul>
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
      return {
        photoevents: photoevents,
        filteredEvents: photoevents,
        filter: ''
      }
    },
    components: {
      photoevent
    },
    methods: {
      applyFilter: function() {
        if (this.filter === "") {
          this.filteredEvents = this.photoevents;
          return null
        }

        this.filteredEvents = this.photoevents.filter((event) => {
          return event.kind.name === this.filter;
        });
      }
    },
    computed: {
      kinds: function () {
        let allKinds = this.photoevents.reduce((result, currentEvent) => {
          if (!result.includes(currentEvent.kind.name)) {
            result.push(currentEvent.kind.name)
          }
          return result;
        }, []);
        return allKinds;
      },
      kindFilter: {
        get: function() {
          return this.filter;
        },

        set: function(value) {
          this.filter = value;
        }
      }
    }
  }
</script>
