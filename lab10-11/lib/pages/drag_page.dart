import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag Widget Test',
      home: DragWidgetPage(),
    );
  }
}

class DragWidgetPage extends StatefulWidget {
  @override
  _DragWidgetPageState createState() => _DragWidgetPageState();
}

class _DragWidgetPageState extends State<DragWidgetPage> {
  Offset _position = Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Widget Test'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              child: Container(
                key: Key('draggable'),
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Drag me!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              feedback: Container(
                width: 100,
                height: 100,
                color: Colors.blue.withOpacity(0.5),
                child: Center(
                  child: Text(
                    'Dragging...',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
