import 'dart:math';

import 'package:stagexl/stagexl.dart';

import '../app.dart';
import '../direction.dart';

class Ship extends Sprite implements Animatable {
  final SpaceInvaders game;
  final Sprite _shipLayer = new Sprite();
  FlipBook _flipBook;

  Direction xDirection = Direction.None;
  Direction yDirection = Direction.None;

  int velocity = 125;

  @override
  bool advanceTime(num time) {
    switch (xDirection) {
      case Direction.Left:
        x = max(0, x - velocity * time);
        break;
      case Direction.Right:
        x = min(game.gameWidth - width, x + velocity * time);
        break;
      default:
    }

    switch (yDirection) {
      case Direction.Up:
        y = max(0, y - velocity * time);
        break;
      case Direction.Down:
        y = min(game.gameHeight - height, y + velocity * time);
        break;
      default:
    }

    return true;
  }

  Ship(this.game, this._flipBook) {
    addChild(_shipLayer);
    _shipLayer.addChild(_flipBook);
    onAdded.listen((_) {
      _flipBook.playWith(stage.juggler);
    });
    onRemoved.listen((_) => _flipBook.stop());
  }
}
