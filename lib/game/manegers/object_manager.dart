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

  // Add Platforms: Add onMount method

  // Add Platforms: Add update method

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

  // Add platforms: Add _semiRandomPlatform method

  // Losing the game: Add enemy code

  // Powerups: Add Power-Up code
}
