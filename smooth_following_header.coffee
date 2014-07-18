class window.SmoothFollowingHeader
  constructor: (options) ->
    @$el     = $(window)
    @$header = options.$header
    @height  = @$height.outerHeight()
    @lastTop = @$el.scrollTop()

    @$el.on 'scroll', =>
      if @whenTooUpper()
        @$header.css position: 'fixed', top: 0
      else if @whenTooDowner()
        @$header.css position: 'fixed', top: - @height
      else if @$header.css('position') == 'fixed'
        top = @$header.offset().top
        @$header.css position: 'absolute', top: top

      @updateLastTop()

  updateLastTop: ->
    @lastTop = @$el.scrollTop()

  isShownFully: ->
    @$header.offset().top - @$el.scrollTop() >= 0

  isHiddenFully: ->
    @$header.offset().top - @$el.scrollTop() + 100 <= 0

  isScrollingUp: ->
    @$el.scrollTop() - @lastTop < 0

  isScrllingDown: ->
    not @isScrollingUp()

  whenTooUpper: ->
    @isScrollingUp() and @isShownFully()

  whenTooDowner: ->
    @isScrllingDown() and @isHiddenFully()
