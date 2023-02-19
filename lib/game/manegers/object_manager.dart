import 'dart:math';

import 'package:flame/components.dart';
import 'package:present_catch_game/game/manegers/level_manager.dart';
import 'package:present_catch_game/game/sprites/platform.dart';
import 'package:present_catch_game/game/util/num_utils.dart';

import './managers.dart';
import '../present_catch.dart';
import '../sprites/sprites.dart';
import '../util/util.dart';

final Random _rand = Random();

/* ObjectManagerについて
* Componentクラスを継承するとPlatformオブジェクトを生成する
* プラットフォーム座標の生成
* 現在のレベルで有効なプラットフォームの判定
* 古くなったプラットフォームの削除などの処理を行うメソッドを提供
 */
class ObjectManager extends Component with HasGameRef<PresentCatch> {
  ObjectManager({
    this.minVerticalDistanceToNextPlatform = 200,
    this.maxVerticalDistanceToNextPlatform = 300,
  });

  double minVerticalDistanceToNextPlatform;
  double maxVerticalDistanceToNextPlatform;
  final probGen = ProbabilityGenerator();
  final double _tallestPlatformHeight = 50;
  final List<Platform> _platforms = [];

  @override
  void onMount() {
    super.onMount();

    var currentX = (gameRef.size.x.floor() / 2).toDouble() - 50;

    var currentY =
        gameRef.size.y - (_rand.nextInt(gameRef.size.y.floor()) / 3) - 50;

    for (var i = 0; i < 9; i++) {
      if (i != 0) {
        currentX = _generateNextX(100);
        currentY = _generateNextY();
      }

      // ゲームが最初に実行されたとき、_semiRandomPlatformメソッドがスタートプラットフォームを生成し、ゲームに追加するようにする
      _platforms.add(
        _semiRandomPlatform(
          Vector2(
            currentX,
            currentY,
          ),
        ),
      );

      add(_platforms[i]);
    }
  }

  @override
  void update(double dt) {
    final topOfLowestPlatform =
        _platforms.first.position.y + _tallestPlatformHeight;

    final screenBottom = gameRef.player.position.y +
        (gameRef.size.x / 2) +
        gameRef.screenBufferSpace;

    if (topOfLowestPlatform > screenBottom) {
      var newPlatY = _generateNextY();
      var newPlatX = _generateNextX(100);
      final nextPlat =
          _semiRandomPlatform(Vector2(newPlatX, newPlatY)); // platformを生成する
      add(nextPlat);

      _platforms.add(nextPlat); // 生成したplatformをゲームに追加(onMountメソッドでも同じことを行う)

      _cleanupPlatforms();
      // Losing the game: Add call to _maybeAddEnemy()
      // Powerups: Add call to _maybeAddPowerup();
    }

    super.update(dt);
  }

  final Map<String, bool> specialPlatforms = {
    'spring': true, // level 1
    'broken': false, // level 2
    'noogler': false, // level 3
    'rocket': false, // level 4
    'enemy': false, // level 5
  };

  void _cleanupPlatforms() {
    final lowestPlat = _platforms.removeAt(0);

    lowestPlat.removeFromParent();
  }

  void enableSpecialty(String specialty) {
    specialPlatforms[specialty] = true;
  }

  void enableLevelSpecialty(int level) {
    // More on Platforms: Add switch statement to enable SpringBoard for
    // level 1 and BrokenPlatform for level 2
  }

  void resetSpecialties() {
    for (var key in specialPlatforms.keys) {
      specialPlatforms[key] = false;
    }
  }

  void configure(int nextLevel, Difficulty config) {
    minVerticalDistanceToNextPlatform = gameRef.levelManager.minDistance;
    maxVerticalDistanceToNextPlatform = gameRef.levelManager.maxDistance;

    for (int i = 1; i <= nextLevel; i++) {
      enableLevelSpecialty(i);
    }
  }

  double _generateNextX(int platformWidth) {
    final previousPlatformXRange = Range(
      _platforms.last.position.x,
      _platforms.last.position.x + platformWidth,
    );

    double nextPlatformAnchorX;

    do {
      nextPlatformAnchorX =
          _rand.nextInt(gameRef.size.x.floor() - platformWidth).toDouble();
    } while (previousPlatformXRange.overlaps(
        Range(nextPlatformAnchorX, nextPlatformAnchorX + platformWidth)));

    return nextPlatformAnchorX;
  }

  double _generateNextY() {
    final currentHighestPlatformY =
        _platforms.last.center.y + _tallestPlatformHeight;

    final distanceToNextY = minVerticalDistanceToNextPlatform.toInt() +
        _rand
            .nextInt((maxVerticalDistanceToNextPlatform -
                    minVerticalDistanceToNextPlatform)
                .floor())
            .toDouble();

    return currentHighestPlatformY - distanceToNextY;
  }

  // Platformを生成する
  Platform _semiRandomPlatform(Vector2 position) {
    // TODO FavoriteChocolatePlatformのみ返すようにする。後でさまざまな種類のプラットフォームを返すようにする。
    return FavoriteChocolatePlatform(position: position);
  }
}
