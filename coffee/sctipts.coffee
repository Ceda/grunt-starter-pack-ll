style = [
  featureType: "all"
  stylers: [
    {
      saturation: -80
    }
    {
      gamma: 0.9
    }
  ]
]

$(window).bind "load", ->
  scrollToAnchor = window.location.hash
  if scrollToAnchor
    $("html,body").animate
      scrollTop: $(scrollToAnchor).offset().top - 90
    , 500

$(document).on 'ready page:load', ->  

  if $('a.lightbox').length > 0
    $('a.lightbox').nivoLightbox();

  
  if $("#map").length > 0
    coord = $("#map").data()
    google.maps.event.addDomListener window, "load", LoadDynamicMap(coord.lat, coord.lon)
    
  updateScrollSpy = ->
    $("[data-spy='scroll']").each ->
      $spy = $(this).scrollspy("refresh")

  setHashURL = (url) ->
    newURL = url.substr(url.indexOf("#") + 1)
    # window.history.pushState null, null, newURL
    # window.location.hash = newURL

  $("nav a").click (e) ->
    $("html, body").animate
      scrollTop: $($(this).attr("href")).offset().top - 60
    , 700
    setHashURL $(this).attr("href")

  setTimeout updateScrollSpy, 1000

  $(".navbar-collapse").on "activate.bs.scrollspy", (e) ->
    setHashURL $("nav li.active a").attr("href")
  
  $('.main-slider').bxSlider(
    auto: true,
    autoControls: false,
    pager: false,
    controls: false
  )
  
  realSlider = $("#sliderBigReal ul").bxSlider(
    speed: 1000
    pager: false
    prevText: ""
    nextText: ""
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
    prevText: ""
    nextText: ""
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

LoadDynamicMap = (lat, lon) ->
  gmapdiv = document.createElement("div")
  gmapdiv.id = "gmapid"
  gmapdiv.style.width = "100%"
  gmapdiv.style.height = "500px"
  document.getElementById("map").appendChild gmapdiv
  mapcenter = new google.maps.LatLng(lat, lon)
  mapOptions =
    scrollwheel: false
    zoom: 15
    center: mapcenter
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    styles: style

  mapOptions.mapTypeControl = true
  mapOptions.mapTypeControlOptions = style: google.maps.MapTypeControlStyle.DEFAULT
  mapOptions.zoomControl = true
  mapOptions.zoomControlOptions = style: google.maps.ZoomControlStyle.SMALL
  mapOptions.overviewMapControl = true
  mapOptions.scaleControl = true
  map = new google.maps.Map(document.getElementById("gmapid"), mapOptions)
  image = new google.maps.MarkerImage("/assets/img/pointer-green.png", null, null, null, new google.maps.Size(70, 89))
  marker = new google.maps.Marker( # Set the marker
    position: mapcenter
    icon: image
    map: map
  )
