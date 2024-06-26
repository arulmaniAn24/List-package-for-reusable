import 'dart:async';
import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final bool isPlaying;

  const ScrollingText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.isPlaying,
  });

  @override
  _ScrollingTextState createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText> {
  late ScrollController _controller;
  late Timer _timer;
  double _scrollOffset = 0.0;
  double _textWidth = 0.0;
  final double _scrollSpeed = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textWidth = _calculateTextWidth();
      _startScrolling();
    });
  }

  @override
  void didUpdateWidget(covariant ScrollingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _startScrolling();
      } else {
        _timer.cancel();
        _controller.jumpTo(0.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startScrolling() {
    if (widget.isPlaying) {
      _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
        if (_controller.hasClients) {
          _scrollOffset += _scrollSpeed;
          if (_scrollOffset > _textWidth) {
            _scrollOffset = 0.0;
          }
          _controller.jumpTo(_scrollOffset);
        }
      });
    }
  }

  double _calculateTextWidth() {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.width;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          Text(widget.text, style: widget.textStyle),
          SizedBox(width: _textWidth),
        ],
      ),
    );
  }
}
