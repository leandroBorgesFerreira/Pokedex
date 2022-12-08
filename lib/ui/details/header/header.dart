import 'package:flutter/material.dart';
import 'package:pokedex/data/api.dart';
import 'package:pokedex/model/pokemon_info.dart';
import 'package:pokedex/ui/common/widget/ElementInfoText.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.pokemonInfo,
    required this.index,
    required this.color,
  }) : super(key: key);

  final PokemonInfo pokemonInfo;
  final int index;
  final Color color;

  final TextStyle _nameFont = const TextStyle(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Widget topInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 30),
      child: Column(children: [
        nameInfo(),
        typeInfo(),
      ]),
    );
  }

  Widget nameInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.pokemonInfo.displayName(),
        style: widget._nameFont,
      ),
    );
  }

  Widget typeInfo() {
    return Row(children: [ElementInfoText(text: widget.pokemonInfo.type)]);
  }

  Widget imageWidget() {
    return Center(
      child: Hero(
        tag: "pokeImage${widget.index}",
        child: Image.network(
          getPokemonImageUrl(widget.index),
          height: 230,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Column(children: [
        topInfo(),
        imageWidget(),
      ]),
    );
  }
}
