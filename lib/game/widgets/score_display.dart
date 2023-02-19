import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:present_catch_game/game/present_catch.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key, required this.game, this.isLight = false});

  final Game game;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as PresentCatch).gameManager.score,
      builder: (context, value, child) {
        return Text('Score: $value', style: TextStyle(color: Colors.black));
      },
    );
  }
}
