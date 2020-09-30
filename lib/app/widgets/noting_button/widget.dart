import 'package:flutter/material.dart';

enum NotingButtonType { NORMAL, OUTLINE }

class NotingButton extends StatelessWidget {
  NotingButton(
      {Key key,
      @required this.child,
      this.type = NotingButtonType.NORMAL,
      this.onTap})
      : assert(child != null),
        super(key: key);

  final Widget child;
  final NotingButtonType type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: type == NotingButtonType.NORMAL
                  ? Color(0xFF212121)
                  : Color(0xFF121212),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: type == NotingButtonType.NORMAL
                      ? Color(0xFF212121)
                      : Color(0xFF726A95),
                  width: 1)),
          child: child,
        ),
      );
}
