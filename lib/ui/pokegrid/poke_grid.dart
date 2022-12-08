import 'package:flutter/material.dart';
import 'package:pokedex/data/api.dart';
import 'package:pokedex/model/pokemon_info.dart';
import 'package:pokedex/ui/common/widget/ElementInfoText.dart';
import 'package:pokedex/ui/details/details.dart';
import 'package:pokedex/utils/color.dart';

StatelessWidget pokemonTile(BuildContext context, Color color,
    PokemonInfo pokemonInfo, int pokemonIndex) {
  const _nameFont =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  const _typeFont =
      TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold);

  var _nameWidget = Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Hero(
      tag: "heroPokeName$pokemonIndex",
      child: Text(pokemonInfo.displayName(), style: _nameFont),
    ),
  );

  var _elementWidget = Row(
    children: [ElementInfoText(text: pokemonInfo.type)],
  );

  var _pokemonInfo = ListView(
    physics: const NeverScrollableScrollPhysics(),
    children: <Widget>[_nameWidget, _elementWidget],
  );

  var _decoImage = OverflowBox(
    maxHeight: 270,
    child: Image.asset(
      "assets/pokeball_grey.png",
      height: 270,
    ),
    alignment: AlignmentDirectional.center,
  );

  var _pictureWidget = Container(
    padding: const EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 4),
    child: Hero(
      tag: "pokeImage$pokemonIndex",
      child: Image.network(
        getPokemonImageUrl(pokemonIndex),
        width: 100,
      ),
    ),
  );

  var tileForeground = Stack(
    children: [_decoImage, _pokemonInfo, _pictureWidget],
    alignment: AlignmentDirectional.bottomEnd,
  );

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PokemonDetails(
                  pokemonInfo: pokemonInfo,
                  color: color,
                  pokemonIndex: pokemonIndex,
                )),
      );
    },
    child: Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(left: 16, right: 0, top: 12, bottom: 0),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: tileForeground,
    ),
  );
}

class PokemonGrid extends StatefulWidget {
  const PokemonGrid({Key? key}) : super(key: key);

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  late int _offset;
  final int _limit = 20;
  late List<PokemonInfo> _pokemonList;
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger) {
        fetchData();
      }
    });

    return getScreen();
  }

  Widget getScreen() {
    if (_pokemonList.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ));
    } else {
      return _getPokeGrid();
    }
  }

  GridView _getPokeGrid() {
    var _colors = getAppColors();

    return GridView.builder(
      controller: _scrollController,
      itemCount: _pokemonList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index >= _pokemonList.length - 1) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          var pokemon = _pokemonList[index];
          return pokemonTile(
            context,
            _colors.elementAt(index % _colors.length) ?? Colors.teal,
            pokemon,
            index + 1,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _offset = 0;
    _pokemonList = [];
    _scrollController = ScrollController();

    fetchData();
  }

  fetchData() async {
    try {
      var pokemonList = await getPokemonInfoList(_limit, _offset);
      _pokemonList.addAll(pokemonList);
      setState(() {
        _offset += _limit;
        _pokemonList = _pokemonList;
      });
    } catch (e) {
      setState(() {});
    }
  }
}
