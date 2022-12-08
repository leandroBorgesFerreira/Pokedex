import 'package:flutter/material.dart';

class RootBody extends StatelessWidget {
  const RootBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      height: 200,
        child: const Center(child: Text("Body Widget!")) ,
    );
  }
}
