<template>
  <li class="event-card">
    <a :href="photoevent.eventPath" class="event-card__link">
      <img :src="photoevent.cover.url" alt="" class="event-card__img">
      <div class="event-card__overlay">
        <ul class="event-card__overlay-content">
          <li class="event-card__time">
            <time :datetime="photoevent.date">{{photoevent.date}}</time>
          </li>
          <li class="event-card__title">
            <h3 class="event-card__title--inner">{{photoevent.title}}</h3>
          </li>
          <li class="event-card__kind">
            <small>{{photoevent.kind.name}}</small>
          </li>
        </ul>
      </div>
    </a>
  </li>
</template>

<script>
  export default {
    data: function() {
      return {

      };
    },
    props: ['photoevent']
  }
</script>

