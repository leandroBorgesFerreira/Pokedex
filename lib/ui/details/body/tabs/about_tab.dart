import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_details.dart';
import 'package:pokedex/ui/details/body/tabs/common/info_index.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({Key? key, required this.pokemonDetails}) : super(key: key);

  final PokemonDetails pokemonDetails;

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    return about(widget.pokemonDetails);
  }

  Widget about(PokemonDetails pokemonDetails) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 20,
      ),
      color: Colors.white,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: InfoIndexList(indexList: ["Height", "Weight", "Abilities"])
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            info("${pokemonDetails.height.toString()} ft"),
            info("${pokemonDetails.weight.toString()} lbs"),
            info(pokemonDetails.displayAbilities()),
          ]),
        ],
      ),
    );
  }

  Widget info(String name) {
    const TextStyle _nameFont = TextStyle(
      color: Colors.black,
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
