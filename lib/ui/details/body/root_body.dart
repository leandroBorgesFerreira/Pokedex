import 'package:flutter/material.dart';
import 'package:pokedex/data/api.dart';

import '../../../model/pokemon_details.dart';

class RootBody extends StatefulWidget {
  const RootBody({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {
  late Future<PokemonDetails> futurePokemonDetails;

  _RootBodyState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetails>(
      future: futurePokemonDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var pokemonDetails = snapshot.data;
          return about();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    futurePokemonDetails = getPokemonDetails(widget.index);
  }

  Widget about() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 20,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Column(children: [
            infoIndex("Height"),
            infoIndex("Weight"),
            infoIndex("Abilities"),
          ])
        ],
      ),
    );
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
