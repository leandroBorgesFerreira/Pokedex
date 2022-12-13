import 'package:flutter/material.dart';

class ElementInfoText extends StatelessWidget {
  const ElementInfoText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    var _typeFont = const TextStyle(
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Container(
      child: Center(child: Text(text, style: _typeFont)),
      decoration: const BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
