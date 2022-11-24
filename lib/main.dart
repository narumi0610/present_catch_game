import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Present Catch Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var position = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: GestureDetector(
            // ドラッグのスタートをタップした直後に設定
            dragStartBehavior: DragStartBehavior.down,
            // タップしながら動かしている座標を取得する
            onPanUpdate: (dragUpdateDetails) {
              position = dragUpdateDetails.localPosition;
              setState(() {});
            },
            child: Stack(
              children: [
                Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset('images/present_bag.png'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
