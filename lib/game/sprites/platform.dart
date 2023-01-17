import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:present_catch_game/game/present_catch.dart';

abstract class Platform<T> extends SpriteGroupComponent<T>
    with HasGameRef<PresentCatch>, CollisionCallbacks {
  final hitbox = RectangleHitbox();
  bool isMoving = false;

  double direction = 1;
  final Vector2 _velocity = Vector2.zero();
  double speed = 35;

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
