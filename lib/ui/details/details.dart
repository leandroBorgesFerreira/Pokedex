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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
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
        ),
        body: screenBody(pokemonInfo, pokemonIndex, color),
      ),
    );
  }
}

Widget screenBody(PokemonInfo pokemonInfo, int pokemonIndex, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Header(pokemonInfo: pokemonInfo, index: pokemonIndex, color: color),
      const RootBody(key: Key(""))
    ],
  );
}
