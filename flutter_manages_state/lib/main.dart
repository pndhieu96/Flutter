import 'package:flutter/material.dart';

//----------------------------- TapboxA ------------------------------

class TabBoxA extends StatefulWidget {
  TabBoxA({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()  => _TapboxAState();
}

class _TapboxAState extends State<TabBoxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = ! _active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//----------------------------- TapboxB ------------------------------

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParentWidgetState();

}

class _ParentWidgetState extends State<StatefulWidget>{
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }

}

class TapboxB extends StatelessWidget {
  TapboxB({Key? key, this.active: false, required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------
class CParentWidget extends StatefulWidget {
  @override
  _CParentWidgetState createState() => _CParentWidgetState();
}

class _CParentWidgetState extends State<CParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({
    Key? key,
    this.active: false,
    required this.onChanged
  }) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _hightLigt = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _hightLigt = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _hightLigt = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _hightLigt = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 15, color: Colors.white))
        ),
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _hightLigt
            ? Border.all(
                color: Colors.teal[700]!,
                width: 10.0,
              )
            : null,
        ),
      ),
    );
  }

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBoxA(),
            ParentWidget(),
            CParentWidget(),
          ],
        ),
      )
    );
  }
}

void main() {
  runApp(MyApp());
}