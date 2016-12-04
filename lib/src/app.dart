import 'dart:async';
import 'dart:html' hide KeyboardEvent;

import 'package:stagexl/stagexl.dart';

import 'ships/player.dart';

class SpaceInvaders {
  final CanvasElement _canvas;

  SpaceInvaders(this._canvas);

  Future start() async {
    StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
    StageXL.stageOptions.backgroundColor = Color.Black;
    var stage = new Stage(_canvas, width: 1000, height: 800);
    var renderLoop = new RenderLoop();
    renderLoop.addStage(stage);

    var resourceManager = new ResourceManager();
    resourceManager.addTextureAtlas("sprite",
        "packages/space_invaders/assets/images/sprite.json");
    await resourceManager.load();

    var textureAtlas = resourceManager.getTextureAtlas("sprite");
    var player = new PlayerShip(textureAtlas, stage);
    stage.addChild(player);
    stage.juggler.add(player);

    document.body.onKeyDown.listen((e) {
      switch(e.keyCode) {
        case KeyCode.LEFT:
          player.xDirection = Direction.Left;
          break;
        case KeyCode.RIGHT:
          player.xDirection = Direction.Right;
          break;
        case KeyCode.UP:
          player.yDirection = Direction.Up;
          break;
        case KeyCode.DOWN:
          player.yDirection = Direction.Down;
          break;
        case KeyCode.SPACE:
          player.shoot();
          break;
        default:
      }
    });

    document.body.onKeyUp.listen((e) {
      switch(e.keyCode) {
        case KeyCode.LEFT:
          if (player.xDirection == Direction.Left) {
            player.xDirection = Direction.None;
          }
          break;
        case KeyCode.RIGHT:
          if (player.xDirection == Direction.Right) {
            player.xDirection = Direction.None;
          }
          break;
        case KeyCode.UP:
          if (player.yDirection == Direction.Up) {
            player.yDirection = Direction.None;
          }
          break;
        case KeyCode.DOWN:
          if (player.yDirection == Direction.Down) {
            player.yDirection = Direction.None;
          }
          break;
        default:
      }
    });
  }
}
