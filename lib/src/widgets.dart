import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({required this.buttonText,
      required this.onPressed });
  final String buttonText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) =>
      Padding(
      padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: Text(buttonText),
          onPressed: onPressed,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.grey..shade400.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Colors.grey.shade400.withOpacity(0.12);
                return Colors.grey;
                 // Defer to the widget's default.
              },
            ),
          ),
        ),
      );
}
