import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(mainCharacter: 'Mask Dude');
  late JoystickComponent joyStick;
  bool showJControls = true;
  List<String> levelNames = ['level-01', 'level-02'];
  int currentLvlIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    //load all imaged into cache - if you have heaps maybe you want to load them as you use them
    await images.loadAllImages();

    _loadLevel();

    if (showJControls) {
      addJoyStick();
      add(JumpButton());
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joyStick = JoystickComponent(
        priority: 10,
        knob: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/knob.png'),
          ),
        ),
        background: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/joystick.png'),
          ),
        ),
        margin: const EdgeInsets.only(left: 32, bottom: 32));
    add(joyStick);
  }

  void updateJoystick() {
    switch (joyStick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovment = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovment = 1;
        break;
      default:
        player.horizontalMovment = 0;
        break;
    }
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);
    if (currentLvlIndex < levelNames.length - 1) {
      currentLvlIndex++;
      _loadLevel();
    } else {
      //no more levels
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLvlIndex],
      );

      cam = CameraComponent.withFixedResolution(
          world: world, height: 360, width: 640);
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }
}
