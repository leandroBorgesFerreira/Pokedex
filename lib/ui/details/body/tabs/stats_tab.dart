import 'package:flutter/material.dart';

import 'common/info_index.dart';

class StatusTab extends StatefulWidget {
  const StatusTab({Key? key}) : super(key: key);

  @override
  State<StatusTab> createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 20,
      ),
      color: Colors.white,
      child: Row(
        children: const [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: InfoIndexList(indexList: ["Height", "Weight", "Abilities"])
          ),
        ],
      ),
    );
  }
}
