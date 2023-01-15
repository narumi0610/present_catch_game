import 'dart:io';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:present_catch_game/game/manegers/game_maneger.dart';
import 'package:present_catch_game/game/sprites/player.dart';
import 'package:present_catch_game/game/background.dart';

// ゲームプレイ中に登録したすべてのコンポーネントのレンダリングと更新を行うゲームの中枢神経系
class PresentCatch extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  GameManager gameManager = GameManager();
  final BackGround _backGround = BackGround();
  late Player player;

  @override
  Future<void> onLoad() async {
    await add(_backGround);

    await add(gameManager);

    overlays.add('gameOverlay');

    // await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Losing the game: Add isGameOver check

    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
      return;
    }

    if (gameManager.isPlaying) {
      // checkLevelUp();

      // Core gameplay: Add camera code to follow Dash during game play

      // Losing the game: Add the first loss condition.
      // Game over if Dash falls off screen!
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void initializeGameStart() {
    gameManager.reset();

    // if (children.contains(objectManager)) objectManager.removeFromParent();

    // levelManager.reset();

    // // Core gameplay: Reset player & camera boundaries

    // player.resetPosition();

    // objectManager = ObjectManager(
    //     minVerticalDistanceToNextPlatform: levelManager.minDistance,
    //     maxVerticalDistanceToNextPlatform: levelManager.maxDistance);

    // add(objectManager);

    // objectManager.configure(levelManager.level, levelManager.difficulty);
  }

  void startGame() {
    initializeGameStart();
    gameManager.state = GameState.playing;
    overlays.remove('mainMenuOverlay');
  }

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }
}
