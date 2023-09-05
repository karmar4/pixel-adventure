import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
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

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
