import 'package:flutter/material.dart';

class InfoIndexList extends StatelessWidget {
  const InfoIndexList({Key? key, required this.indexList}) : super(key: key);

  final List<String> indexList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: indexList.map((e) => InfoIndex(infoName: e)).toList(),
    );
  }
}

class InfoIndex extends StatelessWidget {
  const InfoIndex({Key? key, required this.infoName}) : super(key: key);

  final String infoName;

  @override
  Widget build(BuildContext context) {
    return infoIndex(infoName);
  }

  Widget infoIndex(String name) {
    const TextStyle _nameFont = TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.bold,
    );

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          name,
          style: _nameFont,
        ));
  }
}
