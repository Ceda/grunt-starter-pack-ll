
$(document).on 'ready page:load', ->  

  $('.main-slider').bxSlider(
    auto: true,
    autoControls: false,
    pager: false,
    controls: false
  )
  
  realSlider = $("#sliderBigReal ul").bxSlider(
    speed: 1000
    pager: false
    prevText: "",
    nextText: "",
    infiniteLoop: false
    hideControlOnEnd: true
    onSlideBefore: ($slideElement, oldIndex, newIndex) ->
      changeRealThumb realThumbSlider, newIndex
  )

  realThumbSlider = $("#sliderThumbReal ul").bxSlider(
    minSlides: 5
    maxSlides: 5
    slideWidth: 156
    slideMargin: 12
    moveSlides: 1
    pager: false
    speed: 1000
    infiniteLoop: false
    hideControlOnEnd: true
    onSlideBefore: ($slideElement, oldIndex, newIndex) ->
  )

  linkRealSliders realSlider, realThumbSlider

  $("#sliderThumbReal .bx-next").hide()  if $("#sliderThumbReal li").length < 6
  
linkRealSliders = (bigS, thumbS) ->
  $("#sliderThumbReal ul").on "click", "a", (event) ->
    event.preventDefault()
    newIndex = $(this).parent().attr("slideIndex")
    bigS.goToSlide newIndex

changeRealThumb = (slider, newIndex) ->
  $thumbS = $("#sliderThumbReal")
  $thumbS.find(".active").removeClass "active"
  $thumbS.find("li[slideIndex=\"" + newIndex + "\"]").addClass "active"
  if slider.getSlideCount() - newIndex >= 5
    slider.goToSlide newIndex
  else
    slider.goToSlide slider.getSlideCount() - 5
