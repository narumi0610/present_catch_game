import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:present_catch_game/game/present_catch.dart';

abstract class Platform<T> extends SpriteGroupComponent<T>
    with HasGameRef<PresentCatch>, CollisionCallbacks {
  final hitbox = RectangleHitbox(); // 他のHitboxを持つオブジェクトとの衝突を検出できる

  Platform({
    super.position,
  }) : super(
          size: Vector2.all(100),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    await add(hitbox);
  }
}

enum NormalPlatformState { only }

class NormalPlatform extends Platform<NormalPlatformState> {
  NormalPlatform({super.position});

  double direction = 1; // 方向
  final Vector2 _velocity = Vector2.zero();
  double speed = 120;

  final Map<String, Vector2> spriteOptions = {
    'platform_favorite_chocolate': Vector2(115, 84),
    'platform_courtesy_chocolate': Vector2(100, 55),
    'platform_garbage': Vector2(110, 83),
  };

  @override
  Future<void>? onLoad() async {
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    sprites = {
      NormalPlatformState.only: await gameRef.loadSprite('$randSprite.png')
    };

    current = NormalPlatformState.only;

    size = spriteOptions[randSprite]!;
    await super.onLoad();
  }

  void _move(double dt) {
    direction = 1;

    _velocity.y = direction * speed;

    position += _velocity * dt;
  }

  @override
  void update(double dt) {
    _move(dt);
    super.update(dt);
  }
}
