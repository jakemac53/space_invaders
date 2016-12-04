
import 'dart:html';

import 'package:space_invaders/space_invaders.dart';

void main() {
  new SpaceInvaders(document.body.querySelector('#stage')).start();
}
