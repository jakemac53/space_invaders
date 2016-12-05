import 'dart:async';
import 'dart:html' hide KeyboardEvent;

import 'package:stagexl/stagexl.dart';

import 'direction.dart';
import 'ships/enemy.dart';
import 'ships/player.dart';
import 'ships/ship.dart';
import 'weapons/rocket.dart';

class SpaceInvaders {
  final CanvasElement _canvas;
  final gameWidth;
  final gameHeight;
  TextureAtlas textureAtlas;

  List<Rocket> rockets = <Rocket>[];
  List<EnemyShip> enemies = <EnemyShip>[];
  PlayerShip player;

  SpaceInvaders(this._canvas, {this.gameWidth: 800, this.gameHeight: 600});

  Future start() async {
    StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
    StageXL.stageOptions.backgroundColor = Color.Gray;
    var stage = new Stage(_canvas, width: gameWidth, height: gameHeight);
    stage.backgroundColor = Color.Black;
    var renderLoop = new RenderLoop();
    renderLoop.addStage(stage);

    var resourceManager = new ResourceManager();
    resourceManager.addTextureAtlas("sprite",
        "packages/space_invaders/assets/images/sprite.json");
    await resourceManager.load();

    textureAtlas = resourceManager.getTextureAtlas("sprite");
    player = new PlayerShip(this);
    player.x = gameWidth / 2 - player.width / 2;
    player.y = gameHeight - player.height - 10;
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

    int numEnemiesPerRow = 25;
    int numRows = 7;
    var columnWidth = gameWidth / numEnemiesPerRow;
    var rowHeight = 40;
    for (int i = 0; i < numEnemiesPerRow; i++) {
      for (int j = 0; j < numRows; j++) {
        var enemy = new RedEnemyShip(this);
        var x = (i * columnWidth) + (columnWidth / 2) - (enemy.width / 2);
        enemy.x = x;
        enemy.y = 20 + j * rowHeight;
        stage.addChild(enemy);
        stage.juggler.add(enemy);
      }
    }

    stage.onExitFrame.listen((_) {
      var objectsToRemove = new Set<DisplayObject>();
      for (var rocket in rockets) {
        for (var enemy in enemies) {
          if (rocket.hitTestObject(enemy)) {
            objectsToRemove.add(rocket);
            objectsToRemove.add(enemy);
          }
        }
      }
      objectsToRemove.forEach(stage.removeChild);
    });
  }
}
