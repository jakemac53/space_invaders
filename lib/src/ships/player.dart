import 'package:stagexl/stagexl.dart';

import '../weapons/rocket.dart';

class PlayerShip extends Sprite implements Animatable {
  final Sprite _shipLayer = new Sprite();
  BitmapData _ship;
  final Stage _stage;
  final TextureAtlas _textureAtlas;

  Direction xDirection = Direction.None;
  Direction yDirection = Direction.None;

  int velocity = 125;

  int get x => _shipLayer.x;
  int get y => _shipLayer.y;
  int get width => _ship.width;
  int get height => _ship.height;

  PlayerShip(this._textureAtlas, this._stage) {
    _ship = _textureAtlas.getBitmapData("player");
    addChild(_shipLayer);
    _shipLayer.addChild(new Bitmap(_ship));
  }

  @override
  bool advanceTime(num time) {
    switch (xDirection) {
      case Direction.Left:
        _shipLayer.x -= velocity * time;
        break;
      case Direction.Right:
        _shipLayer.x += velocity * time;
        break;
      default:
    }

    switch (yDirection) {
      case Direction.Up:
        _shipLayer.y -= velocity * time;
        break;
      case Direction.Down:
        _shipLayer.y += velocity * time;
        break;
      default:
    }

    return true;
  }

  void shoot() {
    new Rocket(_textureAtlas, _stage, this);
  }
}

enum Direction { Left, Right, Up, Down, None }
