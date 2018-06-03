
/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import App from './portfolio/app.vue'

document.addEventListener('DOMContentLoaded', () => {
  let appDiv = document.getElementById('app');
  let events = JSON.parse(appDiv.getAttribute('data-events'));
  let eventPath = appDiv.getAttribute('data-event-path');
  const app = new Vue({
    el: '#app',
    render: h => h(App),
    data: {
      events: events,
      eventPath: eventPath
    }
  });
});

