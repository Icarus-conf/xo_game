import 'package:flutter/material.dart';
import 'package:xo_game/components/text_format.dart';

class KButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final int index;
  final Color? color;
  const KButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.index,
    required this.color,
  });
//
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
          onPressed(index, color);
        },
        child: PoppinsText(
          text: label,
          fontS: 40,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
