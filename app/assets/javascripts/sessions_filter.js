$(document).on('turbolinks:load', function() {
  var SessionFilterer = {
    Filter: {
      bindEvents: function() {
        $('.sessions-filter__button, .sessions-filter__link').on('click', function(event) {
          $('.sessions-filter__list').toggleClass('sessions-filter__list--opened');
        });

        $('.sessions-filter__list').on('click', 'a', function(event) {
          $a = $(this);
          $li = $a.closest('.sessions-filter__item');
          $('.sessions-filter__item').removeClass('active');
          $li.addClass('active');
        });
      },

      rotate: function() {
        var $items = $('.sessions-filter__item');
        var count = $items.length;
        $items.each(function(index) {
          $(this).css({
            transform: "rotate(" + (-index * 360 / count) + "deg)"
          });
        });
      },

      init: function() {
        this.rotate();
        this.bindEvents();
      }
    },

    filterSessions: function(event) {
      event.preventDefault();
      var kind = $(event.currentTarget).data("kind");
      var $cards = $(".session-card");
      var kindFilter = '[data-kind="' + kind + '"]';
      var $picked = $cards.filter(kindFilter);
      var $notPicked = $cards.not(kindFilter);

      $picked.show();
      $notPicked.hide();
      this.updateButton(kind);
    },

    updateButton: function(kind) {
      var $button = $('.sessions-filter__button')
      $button.text(kind);
    },

    bindEvents: function() {
      this.Filter.init();
      $('.sessions-filter__link').on('click', this.filterSessions.bind(this));
    }
  }

  SessionFilterer.bindEvents();
});
