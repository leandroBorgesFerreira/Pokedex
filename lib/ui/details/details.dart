import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_info.dart';
import 'package:pokedex/ui/details/body/root_body.dart';
import 'package:pokedex/ui/details/header/header.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({
    Key? key,
    required this.pokemonInfo,
    required this.color,
    required this.pokemonIndex,
  }) : super(key: key);

  final PokemonInfo pokemonInfo;
  final Color color;
  final int pokemonIndex;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: appBar(context, color),
        body: screenBody(pokemonInfo, pokemonIndex, color),
      ),
    );
  }
}

PreferredSizeWidget appBar(BuildContext context, Color color) {
  return AppBar(
    backgroundColor: color,
    elevation: 0,
    leading: BackButton(
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.heart_broken_outlined, color: Colors.white),
      ),
    ],
  );
}

Widget screenBody(PokemonInfo pokemonInfo, int pokemonIndex, Color color) {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Header(pokemonInfo: pokemonInfo, index: pokemonIndex, color: color),
        RootBody(index: pokemonIndex),
      ],
    ),
  );
}
