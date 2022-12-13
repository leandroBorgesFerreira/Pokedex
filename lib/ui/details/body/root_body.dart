import 'package:flutter/material.dart';

class RootBody extends StatelessWidget {
  const RootBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: 200,
        child: const Center(child: Text("Body Widget!")),
      ),
    );
  }
}
