import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:present_catch_game/game/present_catch.dart';
import 'package:present_catch_game/game/widgets/main_menu_overlay.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Present Catch Game',
      home: const MyHomeWidget(),
    );
  }
}

final Game game = PresentCatch();

class MyHomeWidget extends StatefulWidget {
  const MyHomeWidget({super.key});

  @override
  State<MyHomeWidget> createState() => _MyHomeWidgetState();
}

class _MyHomeWidgetState extends State<MyHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: GameWidget(
              game: game,
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                // 'gameOverlay': (context, game) => GameOverlay(game),
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                // 'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        },
      )),
    );
  }
}
