$(document).on("turbolinks:load", function() {
  var Slideshow = {
    $slides: $('#slideshow .slideshow__figure'),
    $thumbnails: $('#thumbnails .thumbnails__item'),
    dynamic: $('#thumbnails').data('dynamic'),
    duration: 1500,
    thumbsToPreview: 10,
    onResizeTimer: null,
    nextSlide: function(e) {
      e.preventDefault();
      var $next = this.cycle(this.$slides, 1);
      this.positionThumbnails($next.index());
      this.highlightThumb($('#thumbnails .thumbnails__item').filter('[data-id=' + $next.attr('data-id') + ']'));
    },
    prevSlide: function(e) {
      e.preventDefault();
      var $prev = this.cycle(this.$slides, -1);
      this.positionThumbnails($prev.index());
      this.highlightThumb(this.$thumbnails.filter('[data-id=' + $prev.attr('data-id') + ']'));
    },
    cycle: function($list, step) {
      $list.stop(true, true);
      var $current = $list.filter(':visible');
      // This will let it wrap around the edges.
      var $next = $list.eq(($current.index() + step) % $list.length);
      $current.fadeOut(this.duration);
      $next.fadeIn(this.duration);
      return $next;
    },
    viewSlide: function(e) {
      e.preventDefault();
      var id = $(e.target).closest('li').attr('data-id');

      this.$slides.filter(':visible').stop(true, true).fadeOut(this.duration);
      this.$slides.filter('[data-id=' + id + ']').stop(true, true).fadeIn(this.duration);

      var index = this.$thumbnails.filter('[data-id=' + id + ']').index();
      this.positionThumbnails(index);
      this.highlightThumb(this.$thumbnails.filter('[data-id=' + id + ']'));
    },
    positionThumbnails: function(offset = 0) {
      if (!this.dynamic) { return; }
      var self = this;
      var widthPx = +$('#thumbnails').width() / this.thumbsToPreview;
      var widthPercent = (100 / this.thumbsToPreview).toString() + '%';
      this.$thumbnails.innerWidth(widthPercent);

      if (this.$thumbnails.length - offset < this.thumbsToPreview) {
        offset = this.$thumbnails.length - this.thumbsToPreview;
      }

      this.$thumbnails.each(function(index) {
        $(this).stop(true, true).animate({
          left: widthPx * (index - offset),
        }, this.duration);
      });
    },
    positionThumbsOnResize: function(e) {
      var self = this;
      clearTimeout(this.onResizeTimer);
      this.onResizeTimer = setTimeout(function() {
        self.positionThumbnails(self.$thumbnails.has('a.current').index());
      }.bind(this), this.duration);
    },
    highlightThumb: function($thumbnail) {
      this.$thumbnails.find('a.current').removeClass('current');
      $thumbnail.find('a').addClass('current');
    },
    bindEvents: function() {
      $('a.next').on('click', this.nextSlide.bind(this));
      $('a.prev').on('click', this.prevSlide.bind(this));
      $('#thumbnails').on('click', 'a', this.viewSlide.bind(this));
      this.positionThumbnails(0);
      this.highlightThumb(this.$thumbnails.eq(0));
      $(window).on('resize', this.positionThumbsOnResize.bind(this));
    },
    init: function() {
      this.bindEvents();
    },
  };

  Slideshow.init();
});
