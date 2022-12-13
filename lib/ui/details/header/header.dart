import 'package:flutter/material.dart';
import 'package:pokedex/data/api.dart';
import 'package:pokedex/model/pokemon_info.dart';
import 'package:pokedex/ui/common/widget/ElementInfoText.dart';

import '../../../model/pokemon_details.dart';

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
        TypeInformation(pokemonIndex: widget.index),
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
    return Stack(alignment: Alignment.bottomCenter, children: [
      bottomDecoration(),
      Center(
        child: Hero(
          tag: "pokeImage${widget.index}",
          child: Image.network(
            getPokemonImageUrl(widget.index),
            height: 230,
          ),
        ),
      ),
    ]);
  }

  Widget pokemonNumber() {
    const _typeFont = TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(top: 30, right: 30),
      child: Text("#00${widget.index}", style: _typeFont),
    );
  }

  Widget bottomDecoration() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: const BoxDecoration(
        // color: widget.color,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: widget.color,
        child: Column(children: [
          topInfo(),
          imageWidget(),
        ]),
      ),
      pokemonNumber(),
    ]);
  }
}

class TypeInformation extends StatefulWidget {
  const TypeInformation({Key? key, required this.pokemonIndex})
      : super(key: key);

  final int pokemonIndex;

  @override
  State<TypeInformation> createState() => _TypeInformationState();
}

class _TypeInformationState extends State<TypeInformation> {
  late Future<PokemonDetails> futurePokemonDetails;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetails>(
      future: futurePokemonDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var pokemonDetails = snapshot.data;

          var elementList = pokemonDetails!.typeSlotList
              .map((typeSlot) => ElementInfoText(text: typeSlot.type.name));
          return Row(children: elementList.toList());
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
    futurePokemonDetails = getPokemonDetails(widget.pokemonIndex);
  }
}
