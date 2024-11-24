import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedList Sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedListSample(),
    );
  }
}

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _items = ['Item 1', 'Item 2', 'Item 3'];

  Widget _buildItem(BuildContext context, int index, String title,
      Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
          Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
              .chain(CurveTween(curve: Curves.ease))),
      child: ListTile(
        title: Text(title),
        onTap: () {
          _items.removeAt(index);
          AnimatedList.of(context).removeItem(
              index,
              (BuildContext context, Animation<double> animation) =>
                  _buildItem(context, index, title, animation));
        },
      ),
    );
  }

  void _addItem() {
    setState(() {
      int index = _items.length;
      _items.add('Item ${index + 1}');
      _listKey.currentState?.insertItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList Sample'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return _buildItem(context, index, _items[index], animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}
