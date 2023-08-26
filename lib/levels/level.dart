import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('level-01.tmx', Vector2.all(16));
    add(level);

    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (var spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          //make character_name an enum in the future
          final player = Player(
            main_character: 'Pink Man',
            position: Vector2(spawnPoint.x, spawnPoint.y),
          );
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
