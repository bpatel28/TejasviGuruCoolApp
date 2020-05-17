import 'package:flutter/cupertino.dart';

class CircularBox extends StatelessWidget {
  final EdgeInsets _padding;
  final Color _color;
  final String _text;
  final Color _textColor;
  final double _fontSize;

  CircularBox(this._text,
      {EdgeInsets padding = EdgeInsets.zero,
      Color color = const Color(0xFF42A5F5),
      Color textColor = const Color(0XFF000000),
      double fontSize = 12.0})
      : _padding = padding,
        _color = color,
        _textColor = textColor,
        _fontSize = fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
      child: Container(
        child: Text(_text, style: TextStyle(color: _textColor, fontSize: _fontSize), textAlign: TextAlign.center,),
      ),
    );
  }
}
