import 'package:flutter/material.dart';

class RootBody extends StatelessWidget {
  const RootBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double radiusValue = 30;

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(radiusValue),
          //   topRight: Radius.circular(radiusValue),
          // ),
        ),
        height: 200,
        child: const Center(child: Text("Body Widget!")),
      ),
    );
  }
}
