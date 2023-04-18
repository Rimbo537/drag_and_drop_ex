import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MainWidget()));
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Main Screen")),
      ),
      body: Center(
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyDraggableApp()));
              },
              child: const Text(
                'Go to Drag&Drop screen',
                style: TextStyle(fontSize: 20),
              )),
        ),
      ),
    );
  }
}

class MyDraggableApp extends StatefulWidget {
  @override
  _MyDraggableAppState createState() => _MyDraggableAppState();
}

class _MyDraggableAppState extends State<MyDraggableApp> {
  Color colorOne = Colors.black;
  Color colorTwo = Colors.black;

  String textOne = 'One';
  String textTwo = 'Two';

  int draggableOneLabel = 1;
  int draggableTwoLabel = 2;

  @override
  Widget build(BuildContext context) {
    final dragOne = colorOne == Colors.black;
    final dragTwo = colorTwo == Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Draggable and DragTarget"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DragTargetWidget(
                  color: colorOne,
                  draggableLabel: draggableOneLabel,
                  onAccept: (_) => setState(() {
                    colorOne = Colors.purple;
                    textOne = '1';
                  }),
                  text: textOne,
                ),
                _DragTargetWidget(
                  color: colorTwo,
                  draggableLabel: draggableTwoLabel,
                  onAccept: (_) => setState(() {
                    colorTwo = Colors.pink;
                    textTwo = '2';
                  }),
                  text: textTwo,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IgnorePointer(
                  ignoring: !dragOne,
                  child: Opacity(
                    opacity: dragOne ? 1 : 0,
                    child: _DraggableWidget(
                      dataValue: draggableOneLabel,
                      text: '1',
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoring: !dragTwo,
                  child: Opacity(
                    opacity: dragTwo ? 1 : 0,
                    child: _DraggableWidget(
                      dataValue: draggableTwoLabel,
                      text: '2',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DraggableWidget extends StatelessWidget {
  final String text;
  final int dataValue;

  const _DraggableWidget({required this.text, required this.dataValue});

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: dataValue,
      feedback: Container(
        width: 100,
        height: 100,
        color: Colors.orange,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class _DragTargetWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Function(Object?) onAccept;
  final int draggableLabel;

  _DragTargetWidget({
    required this.text,
    required this.color,
    required this.onAccept,
    required this.draggableLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, _, __) {
        return Container(
          width: 100,
          height: 100,
          color: color,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          )),
        );
      },
      onWillAccept: (data) => data == draggableLabel,
      onAccept: onAccept,
    );
  }
}
