import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BoardSquare extends StatefulWidget {
  final String value;
  final bool enabled;

  final VoidCallback onTap;

  const BoardSquare(
    this.value, {
    required this.onTap,
    this.enabled = true,
    super.key,
  });

  @override
  State<BoardSquare> createState() => _BoardSquareState();
}

class _BoardSquareState extends State<BoardSquare> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color color = theme.primaryColor;
    if (hover) color = theme.splashColor;
    if (!widget.enabled) color = theme.disabledColor;

    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 95,
          height: 95,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              widget.value,
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void onEnter(PointerEnterEvent event) => setState(() => hover = true);

  void onExit(PointerExitEvent event) => setState(() => hover = false);
}
