$(document).on('turbolinks:load', function() {
  var EventFilterer = {
    $cards: $(".event-card"),
    Filter: {
      bindEvents: function() {
        $('.events-filter__button, .events-filter__link').on('click', function(event) {
          $('.events-filter__list').toggleClass('events-filter__list--opened');
        });

        $('.events-filter__list').on('click', 'a', function(event) {
          $a = $(this);
          $li = $a.closest('.events-filter__item');
          $('.events-filter__item').removeClass('active');
          $li.addClass('active');
        });
      },

      rotate: function() {
        var $items = $('.events-filter__item');
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

    filterEvents: function(event) {
      event.preventDefault();
      var kind = $(event.currentTarget).data("kind");
      this.renderFilter(kind);
      this.updateButton(kind);
    },

    renderFilter: function(kind) {
      var kindFilter = '[data-kind="' + kind + '"]';
      var $picked = this.$cards.filter(kindFilter);
      var $notPicked = this.$cards.not(kindFilter);

      $picked.show();
      $notPicked.hide();
    },

    updateButton: function(kind) {
      var $button = $('.events-filter__button')
      $button.text(kind);
    },

    bindEvents: function() {
      this.Filter.init();
      $('.events-filter__link').on('click', this.filterEvents.bind(this));
    },

    init: function(kind) {
      this.bindEvents();
      if (kind !== "") {
        this.renderFilter(kind);
        this.updateButton(kind);
      }
    }
  }

  EventFilterer.init(filter);
});
