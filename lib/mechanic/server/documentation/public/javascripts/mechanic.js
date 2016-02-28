$(function () {

  var controller = new ScrollMagic.Controller();

  var toolScene = new ScrollMagic.Scene({
    offset: 50,
    duration: 400
  });

  toolScene.setTween(TweenMax.to('#tool', 1, { y: -620 }));

  controller.addScene([toolScene]);

});
