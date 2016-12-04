import 'package:stagexl/stagexl.dart';

import '../ships/player.dart';

class Rocket extends Sprite implements Animatable {
  BitmapData _rocketData;
  final _rocketLayer = new Sprite();
  final Stage _stage;
  final TextureAtlas _textureAtlas;

  int velocity = 250;

  Rocket(this._textureAtlas, this._stage, PlayerShip player) {
    _rocketData = _textureAtlas.getBitmapData("rocket");
    addChild(_rocketLayer);
    var rocket = new Bitmap(_rocketData);
    _rocketLayer.addChild(rocket);
    _rocketLayer
      ..x = player.x + player.width / 2 - _rocketData.width / 2
      ..y = player.y - _rocketData.height;
    _stage.addChild(this);
    _stage.juggler.add(this);
  }

  @override
  bool advanceTime(num time) {
    _rocketLayer.y -= velocity * time;
    if (_rocketLayer.y < -_rocketData.height) {
      _stage.removeChild(this);
      _stage.juggler.remove(this);
      print('Removed $this ${_rocketLayer.y} ${-_rocketData.height}');
    }
    return true;
  }
}
