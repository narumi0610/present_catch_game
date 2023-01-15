import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:present_catch_game/game/present_catch.dart';
import 'package:present_catch_game/game/util/color_schemes.dart';
import 'package:present_catch_game/game/widgets/game_over_overlay.dart';
import 'package:present_catch_game/game/widgets/game_overlay.dart';
import 'package:present_catch_game/game/widgets/main_menu_overlay.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Present Catch',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Present Catch'),
    );
  }
}

final Game game = PresentCatch();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
              minWidth: 550,
            ),
            child: GameWidget(
              game: game,
              // ウィジェットサブツリーを使用して、ゲームサーフェス上にウィジェットのレイヤーをレンダリングする
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'gameOverlay': (context, game) => GameOverlay(game),
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        },
      )),
    );
  }
}
