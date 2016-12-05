import 'package:stagexl/stagexl.dart';

import '../app.dart';
import '../ships/player.dart';

class Rocket extends Sprite implements Animatable {
  BitmapData _rocketData;
  final _rocketLayer = new Sprite();
  final SpaceInvaders _game;

  int velocity = 250;

  Rocket(this._game, PlayerShip player) {
    _rocketData = _game.textureAtlas.getBitmapData("rocket");
    addChild(_rocketLayer);
    var rocket = new Bitmap(_rocketData)..scaleX = .5 ..scaleY = .5;
    _rocketLayer.addChild(rocket);
    _rocketLayer
      ..x = player.x + player.width / 2 - _rocketData.width / 2
      ..y = player.y - _rocketData.height;

    onAddedToStage.listen((_) {
      _game.rockets.add(this);
    });
    onRemovedFromStage.listen((_) {
      _game.rockets.remove(this);
    });
  }

  @override
  bool advanceTime(num time) {
    _rocketLayer.y -= velocity * time;
    if (_rocketLayer.y < -_rocketData.height) {
      stage?.juggler?.remove(this);
      removeFromParent();
      return false;
    }
    return true;
  }
}
