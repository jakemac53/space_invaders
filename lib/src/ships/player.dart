import 'package:stagexl/stagexl.dart';

import '../app.dart';
import '../weapons/rocket.dart';
import 'ship.dart';

class PlayerShip extends Ship {
  PlayerShip(SpaceInvaders game)
      : super(
            game,
            new FlipBook(game.textureAtlas.getBitmapDatas("player"), 30)
              ..scaleX = .5
              ..scaleY = .5);

  void shoot() {
    var rocket = new Rocket(game, this);
    stage.addChild(rocket);
    stage.juggler.add(rocket);
  }
}
