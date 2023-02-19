import 'package:present_catch_game/game/present_catch.dart';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackGround extends ParallaxComponent<PresentCatch> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('background.png'),
        // ParallaxImageData('school.png'),
      ],
      fill: LayerFill.width,
      // repeat: ImageRepeat.repeat,
      // baseVelocity: Vector2(0, -5),
      // velocityMultiplierDelta: Vector2(0, 1.2),
    );
  }
}
