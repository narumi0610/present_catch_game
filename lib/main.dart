import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Present Catch Game',
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var position = 0.0;

  void moveLeft() {
    position += 10;
  }

  void moveRight() {
    position -= 10;
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        setState(() {
          moveLeft();
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        setState(() {
          moveRight();
        });
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: _handleKeyPress,
      debugLabel: 'Button',
      child: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Colors.pink,
            width: 700,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  right: position, // 位置情報
                  bottom: 0, // 位置情報
                  // 動かしたいWidget
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
