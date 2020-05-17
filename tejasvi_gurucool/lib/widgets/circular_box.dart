import 'package:flutter/cupertino.dart';

class CircularBox extends StatelessWidget {
  final double _padding;
  final Color _color;
  final String _text;

  CircularBox(this._text, {double padding = 0, Color color = const Color(0xFF42A5F5)}) : _padding = padding, _color = color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _color
      ),
      child: Text(_text),
    );
  }
}