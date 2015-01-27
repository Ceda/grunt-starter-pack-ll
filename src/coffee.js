(function() {
  var changeRealThumb, linkRealSliders;

  $(document).on('ready page:load', function() {
    var realSlider, realThumbSlider;
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

}).call(this);
