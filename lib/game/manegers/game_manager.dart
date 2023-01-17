import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:present_catch_game/game/present_catch.dart';

// ゲーム全体の状態とスコアリングを記録
class GameManager extends Component with HasGameRef<PresentCatch> {
  GameManager();

  Character character = Character.hand;
  ValueNotifier<int> score = ValueNotifier(0);
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  void reset() {
    score.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    score.value++;
  }

  void selectCharacter(Character selectedCharacter) {
    character = selectedCharacter;
  }
}

enum GameState { intro, playing, gameOver }
