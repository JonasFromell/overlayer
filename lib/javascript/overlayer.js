(function($) {
  var Overlayer;
  Overlayer = function(element, options) {
    this.$element = $(element);
    return this.isShown = false;
  };
  Overlayer.DEFAULTS = {
    show: true
  };
  Overlayer.prototype.toggle = function(target) {
    return this[(this.isShown ? 'hide' : 'show')](target);
  };
  Overlayer.prototype.show = function(target) {
    var e;
    this.$element.trigger(e = $.Event('show.overlayer', target));
    if (this.isShown || e.isDefaultPrevented()) {
      return;
    }
    this.isShown = true;
    this.$element.on('click.dismiss.overlayer', '[data-dismiss="overlayer"]', $.proxy(this.hide, this));
    return this.$element.addClass('open').trigger('shown.overlayer', target);
  };
  Overlayer.prototype.hide = function(e) {
    if (e) {
      e.preventDefault();
    }
    this.$element.trigger(e = $.Event('hide.overlayer'));
    if (!this.isShown || e.isDefaultPrevented()) {
      return;
    }
    this.isShown = false;
    this.$element.off('click.dismiss.overlayer');
    return this.$element.removeClass('open').trigger('hidden.overlayer');
  };
  $.fn.overlayer = function(option, target) {
    return this.each(function() {
      var $this, data, options;
      $this = $(this);
      data = $this.data('overlayer');
      options = $.extend({}, Overlayer.DEFAULTS, $this.data(), typeof option === "object" && option);
      if (!data) {
        $this.data('overlayer', (data = new Overlayer(this, options)));
      }
      if (typeof option === "string") {
        data[option](target);
      }
      if (options.show) {
        return data.show(target);
      }
    });
  };
  $.fn.overlayer.Constructor = Overlayer;
  $(document).on('click.overlayer.data-api', '[data-toggle="overlayer"]', function(e) {
    var $target, $this, option;
    $this = $(this);
    $target = $($this.attr('data-target'));
    option = $target.data('overlayer') ? 'toggle' : $.extend({}, $target.data(), $this.data());
    if ($this.is('a')) {
      e.preventDefault();
    }
    return $target.overlayer(option, this).one('hide', function() {
      return $this.is(':visible') && $this.focus();
    });
  });
  return $(document).on('show.overlayer', function() {
    return console.log("overlayer shown");
  });
})($);
