import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  final world = Level();

  @override
  FutureOr<void> onLoad() async {
    //load all imaged into cache - if you have heaps maybe you want to load them as you use them
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, height: 360, width: 640);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }
}
