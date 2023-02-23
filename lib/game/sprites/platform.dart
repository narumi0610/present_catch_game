import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:present_catch_game/game/present_catch.dart';
import 'package:present_catch_game/game/sprites/player.dart';

// 落ちてくるオブジェクトを定義
abstract class Platform<T> extends SpriteGroupComponent<T>
    with HasGameRef<PresentCatch>, CollisionCallbacks {
  Platform({
    super.position,
  }) : super(
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(
      RectangleHitbox(
        size: Vector2.all(60),
        position: Vector2(10, 10),
      ),
    );
  }
}

enum FavoriteChocolatePlatformState { only }

class FavoriteChocolatePlatform
    extends Platform<FavoriteChocolatePlatformState> {
  FavoriteChocolatePlatform({super.position});

  double direction = 1; // 方向
  final Vector2 _velocity = Vector2.zero();
  double speed = 120;

  final Map<String, Vector2> spriteOptions = {'star': Vector2.all(80)};

  @override
  Future<void>? onLoad() async {
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    sprites = {
      FavoriteChocolatePlatformState.only:
          await gameRef.loadSprite('$randSprite.png')
    };

    current = FavoriteChocolatePlatformState.only;

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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      // プレイヤーと衝突した場合はプラットフォームを消すようにした
      removeFromParent();
      gameRef.gameManager.increaseScore(); // scoreを増やす

    }
  }

  @override
  set debugMode(bool _debugMode) {
    // TODO: サイズ見れるようにする
    super.debugMode = true;
  }
}

// enum CourtesyChocolatePlatformState { only }

// class CourtesyChocolatePlatform
//     extends Platform<CourtesyChocolatePlatformState> {
//   CourtesyChocolatePlatform({super.position});

//   final Map<String, Vector2> spriteOptions = {
//     'platform_courtesy_chocolate': Vector2(100, 55),
//   };

//   @override
//   Future<void>? onLoad() async {
//     await super.onLoad();

//     sprites = {
//       CourtesyChocolatePlatformState.only:
//           await gameRef.loadSprite('platform_courtesy_chocolate.png')
//     };

//     current = CourtesyChocolatePlatformState.only;

//     size = Vector2(100, 55);
//   }
// }

// enum GarbagePlatformState { only }

// class GarbagePlatform extends Platform<GarbagePlatformState> {
//   GarbagePlatform({super.position});

//   @override
//   Future<void>? onLoad() async {
//     await super.onLoad();

//     sprites = {
//       GarbagePlatformState.only:
//           await gameRef.loadSprite('platform_garbage.png')
//     };

//     current = GarbagePlatformState.only;

//     size = Vector2(110, 83);
//   }
// }
