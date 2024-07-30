import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String padNumber;
  final void Function() onTap;
  final Color? color;

  const CircleButton({super.key, required this.padNumber, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? Colors.deepOrange,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: onTap,
            child: Container(
              height: 80,
              alignment: Alignment.center,
              child: Text(
                padNumber,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}