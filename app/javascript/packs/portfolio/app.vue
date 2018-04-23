<template>
  <div>
    <ul class="events__list">
      <photoevent v-for="photoevent in photoevents" :photoevent="photoevent"></photoevent>
    </ul>
  </div>
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
        photoevents: photoevents
      }
    },
    components: {
      photoevent
    }
  }
</script>
