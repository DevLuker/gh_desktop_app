import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  const TextError({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
