import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragExample(),
    );
  }
}

class DragExample extends StatefulWidget {
  @override
  _DragExampleState createState() => _DragExampleState();
}

class _DragExampleState extends State<DragExample> {
  double offsetX = 0.0;
  double offsetY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Drag Example'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // X軸のオフセットを変更
            offsetX += details.delta.dx;

            // Y軸のオフセットを制限付きで変更
            double newOffsetY = offsetY + details.delta.dy;
            if (newOffsetY > 0) {
              offsetY = newOffsetY.clamp(0.0, 100.0);
            } else {
              offsetY = newOffsetY.clamp(-100.0, 0.0);
            }
          });
        },
        child: Stack(
          children: [
            Positioned(
              left: offsetX,
              top: offsetY,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Drag me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}