import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import '../present_catch.dart';
export 'package:present_catch_game/game/manegers/game_manager.dart';

enum PlayerState {
  center,
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<PresentCatch>, KeyboardHandler, CollisionCallbacks {
  Player({super.position})
      : super(
          size: Vector2.all(100),
          anchor: Anchor.center,
          priority: 1,
        );
  int _hAxisInput = 0; // プレイヤーの進行方向を保持
  final int movingLeftInput = -1;
  final int movingRightInput = 1;
  Vector2 _velocity = Vector2.zero(); // 速度
  double jumpSpeed = 600;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // スプライトアセットをロード
    await _loadCharacterSprites();
    current = PlayerState.center;
  }

  // handを画面上に配置するロジック。現在の速度と位置を計算。
  @override
  void update(double dt) {
    // プレイヤーが移動してはいけない非プレイアブル状態でないことを確認
    if (gameRef.gameManager.isIntro || gameRef.gameManager.isGameOver) return;

    _velocity.x = _hAxisInput * jumpSpeed;

    final double handHorizontalCenter = size.x / 2;

    if (position.x < handHorizontalCenter) {
      position.x = gameRef.size.x - (handHorizontalCenter);
    }
    if (position.x > gameRef.size.x - (handHorizontalCenter)) {
      position.x = handHorizontalCenter;
    }

    position.y = gameRef.size.y - 50;

    position += _velocity * dt;

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      moveRight();
    }

    return true;
  }

  void moveLeft() {
    _hAxisInput = 0;
    _hAxisInput += movingLeftInput;
  }

  void moveRight() {
    _hAxisInput = 0;
    _hAxisInput += movingRightInput;
  }

  void resetDirection() {
    _hAxisInput = 0;
  }

  void resetPosition() {
    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      (gameRef.size.y - size.y) / 2,
    );
  }

  Future<void> _loadCharacterSprites() async {
    // スプライトアセットのロード
    sprites = <PlayerState, Sprite>{
      PlayerState.center: await gameRef.loadSprite('hand.png')
    };
  }
}
