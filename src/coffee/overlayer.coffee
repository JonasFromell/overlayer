do ($) ->
	Overlayer = (element, options) ->
		@$element = $(element)
		@isShown  = false

	Overlayer.DEFAULTS =
		show: true

	Overlayer.prototype.toggle = (target) ->
		this[(if @isShown then 'hide' else 'show')](target)

	Overlayer.prototype.show = (target) ->
		# Trigger show event
		@$element.trigger(e = $.Event('show.overlayer', target))

		# Return if event is prevented
		return if (@isShown or e.isDefaultPrevented())

		# Set shown to true
		@isShown = true

		# Bind close event
		@$element.on('click.dismiss.overlayer', '[data-dismiss="overlayer"]', $.proxy(@hide, @))

		# Show and trigger shown event
		@$element
			.addClass('open')
			.trigger('shown.overlayer', target)

	Overlayer.prototype.hide = (e) ->
		e.preventDefault() if e

		# Trigger hide event
		@$element.trigger(e = $.Event('hide.overlayer'))

		# Return if event is prevented
		return if (not @isShown or e.isDefaultPrevented())

		# Set shown to false
		@isShown = false

		# Unbind close event
		@$element.off('click.dismiss.overlayer')

		# Hide and trigger hidden event
		@$element
			.removeClass('open')
			.trigger('hidden.overlayer')

	$.fn.overlayer = (option, target) ->
		this.each ->
			$this 	= $(this)
			data  	= $this.data('overlayer')
			options = $.extend({}, Overlayer.DEFAULTS, $this.data(), typeof option is "object" and option)

			$this.data('overlayer', (data = new Overlayer(this, options))) unless data
			data[option](target) if (typeof option is "string")
			data.show(target) if options.show

	$.fn.overlayer.Constructor = Overlayer

	$(document).on('click.overlayer.data-api', '[data-toggle="overlayer"]', (e) ->
		$this 	= $(this)
		$target = $($this.attr('data-target'))
		option  = if $target.data('overlayer') then 'toggle' else $.extend({}, $target.data(), $this.data())

		e.preventDefault() if $this.is('a')

		$target
			.overlayer(option, this)
			.one('hide', ->
				$this.is(':visible') and $this.focus()
			)
	)

	$(document)
		.on('show.overlayer', -> console.log "overlayer shown")