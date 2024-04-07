import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  const FillButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.height = 50});
  final VoidCallback onPressed;
  final double height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          elevation: 1,
          fixedSize: Size.fromHeight(height),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: child,
    );
  }
}

class FilledTonalButton extends StatelessWidget {
  const FilledTonalButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.height = 50});
  final double height;
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          elevation: 1,
          fixedSize: Size.fromHeight(height),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: Text(
        text,
      ),
    );
  }
}
