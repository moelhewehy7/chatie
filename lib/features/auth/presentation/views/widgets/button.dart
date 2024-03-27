import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const FillButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          elevation: 1,
          fixedSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: Text(
        text,
      ),
    );
  }
}

class FilledTonalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const FilledTonalButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          elevation: 1,
          fixedSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: Text(
        text,
      ),
    );
  }
}
