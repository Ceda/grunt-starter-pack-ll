(function() {
  var LoadDynamicMap, changeRealThumb, linkRealSliders, style;

  style = [
    {
      featureType: "all",
      stylers: [
        {
          saturation: -80
        }, {
          gamma: 0.9
        }
      ]
    }
  ];

  $(window).bind("load", function() {
    var scrollToAnchor;
    scrollToAnchor = window.location.hash;
    if (scrollToAnchor) {
      return $("html,body").animate({
        scrollTop: $(scrollToAnchor).offset().top - 90
      }, 500);
    }
  });

  $(document).on('ready page:load', function() {
    var coord, realSlider, realThumbSlider, setHashURL, updateScrollSpy;
    if ($("#map").length > 0) {
      coord = $("#map").data();
      google.maps.event.addDomListener(window, "load", LoadDynamicMap(coord.lat, coord.lon));
    }
    updateScrollSpy = function() {
      return $("[data-spy='scroll']").each(function() {
        var $spy;
        return $spy = $(this).scrollspy("refresh");
      });
    };
    setHashURL = function(url) {
      var newURL;
      return newURL = url.substr(url.indexOf("#") + 1);
    };
    $("nav a").click(function(e) {
      $("html, body").animate({
        scrollTop: $($(this).attr("href")).offset().top - 60
      }, 700);
      return setHashURL($(this).attr("href"));
    });
    setTimeout(updateScrollSpy, 1000);
    $(".navbar-collapse").on("activate.bs.scrollspy", function(e) {
      return setHashURL($("nav li.active a").attr("href"));
    });
    $('.main-slider').bxSlider({
      auto: true,
      autoControls: false,
      pager: false,
      controls: false
    });
    realSlider = $("#sliderBigReal ul").bxSlider({
      speed: 1000,
      pager: false,
      prevText: "",
      nextText: "",
      infiniteLoop: false,
      hideControlOnEnd: true,
      onSlideBefore: function($slideElement, oldIndex, newIndex) {
        return changeRealThumb(realThumbSlider, newIndex);
      }
    });
    realThumbSlider = $("#sliderThumbReal ul").bxSlider({
      minSlides: 5,
      maxSlides: 5,
      slideWidth: 156,
      slideMargin: 12,
      moveSlides: 1,
      pager: false,
      speed: 1000,
      prevText: "",
      nextText: "",
      infiniteLoop: false,
      hideControlOnEnd: true,
      onSlideBefore: function($slideElement, oldIndex, newIndex) {}
    });
    linkRealSliders(realSlider, realThumbSlider);
    if ($("#sliderThumbReal li").length < 6) {
      return $("#sliderThumbReal .bx-next").hide();
    }
  });

  linkRealSliders = function(bigS, thumbS) {
    return $("#sliderThumbReal ul").on("click", "a", function(event) {
      var newIndex;
      event.preventDefault();
      newIndex = $(this).parent().attr("slideIndex");
      return bigS.goToSlide(newIndex);
    });
  };

  changeRealThumb = function(slider, newIndex) {
    var $thumbS;
    $thumbS = $("#sliderThumbReal");
    $thumbS.find(".active").removeClass("active");
    $thumbS.find("li[slideIndex=\"" + newIndex + "\"]").addClass("active");
    if (slider.getSlideCount() - newIndex >= 5) {
      return slider.goToSlide(newIndex);
    } else {
      return slider.goToSlide(slider.getSlideCount() - 5);
    }
  };

  LoadDynamicMap = function(lat, lon) {
    var gmapdiv, image, map, mapOptions, mapcenter, marker;
    gmapdiv = document.createElement("div");
    gmapdiv.id = "gmapid";
    gmapdiv.style.width = "100%";
    gmapdiv.style.height = "500px";
    document.getElementById("map").appendChild(gmapdiv);
    mapcenter = new google.maps.LatLng(lat, lon);
    mapOptions = {
      scrollwheel: false,
      zoom: 15,
      center: mapcenter,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: style
    };
    mapOptions.mapTypeControl = true;
    mapOptions.mapTypeControlOptions = {
      style: google.maps.MapTypeControlStyle.DEFAULT
    };
    mapOptions.zoomControl = true;
    mapOptions.zoomControlOptions = {
      style: google.maps.ZoomControlStyle.SMALL
    };
    mapOptions.overviewMapControl = true;
    mapOptions.scaleControl = true;
    map = new google.maps.Map(document.getElementById("gmapid"), mapOptions);
    image = new google.maps.MarkerImage("/assets/img/pointer-green.png", null, null, null, new google.maps.Size(70, 89));
    return marker = new google.maps.Marker({
      position: mapcenter,
      icon: image,
      map: map
    });
  };

}).call(this);

