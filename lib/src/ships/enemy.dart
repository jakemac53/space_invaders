import 'package:stagexl/stagexl.dart';

import '../app.dart';
import 'ship.dart';

class RedEnemyShip extends EnemyShip {
  RedEnemyShip(SpaceInvaders game)
      : super(
            game,
            new FlipBook(game.textureAtlas.getBitmapDatas("enemy_red"), 30)
              ..scaleX = .5
              ..scaleY = .5);
}

class EnemyShip extends Ship {
  EnemyShip(SpaceInvaders game, FlipBook flipBook) : super(game, flipBook) {
    onAddedToStage.listen((_) {
      game.enemies.add(this);
    });
    onRemovedFromStage.listen((_) {
      game.enemies.remove(this);
    });
  }
}
