bool checkCollision(player, block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blackHeight = block.height;

  final fixedX = player.scale.x < 0 ? playerX - playerWidth : playerX;

  return (playerY < blockY + blackHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}
