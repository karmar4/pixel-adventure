import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/player.dart';

class Level extends World {
  late TiledComponent level;

  Level({required this.levelName, required this.player});
  final String levelName;
  final Player player;

  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    add(level);

    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('spawnpoints');
    if (spawnPointLayer != null) {
      for (var spawnPoint in spawnPointLayer!.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
        }
      }
    }

    final collisionLayer = level.tileMap.getLayer<ObjectGroup>('collisions');
    if (collisionLayer != null) {
      for (var collision in collisionLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            var platform = CollisionBlock(
              size: Vector2(collision.width, collision.height),
              position: Vector2(collision.x, collision.y),
              isPlatform: true,
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            var block = CollisionBlock(
              size: Vector2(collision.width, collision.height),
              position: Vector2(collision.x, collision.y),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }
}
