import 'dart:async';

import 'package:flame/components.dart';

class JumpButton extends SpriteComponent with HasGameRef {
  JumpButton();

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/jumpbutton.png'));
    position = Vector2(
      // margin 32 and - the width of button = 64
      game.size.x - 32 - 64,
      game.size.y - 32 - 64,
    );
    priority = 10;

    return super.onLoad();
  }
}
