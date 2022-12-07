import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:pokedex/model/pokemon_info.dart';

StatelessWidget pokemonTile(Color? color, String name, int imageIndex) {
  const _nameFont =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  const _typeFont =
      TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold);

  var nameWidget = Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text(name, style: _nameFont),
  );

  var elementWidget = Row(children: [
    Container(
      child: Center(child: Text(name, style: _typeFont)),
      decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    )
  ]);

  var pictureWidget = Image.network(
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$imageIndex.png",
    width: 90,
    // height: 100,
  );

  var pokemonInfo = ListView(children: <Widget>[nameWidget, elementWidget]);

  var tileForeground = Stack(
    children: [pokemonInfo, pictureWidget],
    alignment: AlignmentDirectional.bottomEnd,
  );

  return Container(
    padding: const EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 8),
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    child: tileForeground,
  );
}

class PokemonGrid extends StatefulWidget {
  const PokemonGrid({Key? key}) : super(key: key);

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  late int _offset;
  late bool _loading;
  final int _limit = 20;
  final int _nextPageTrigger = 3;
  late List<PokemonInfo> _pokemonList;
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger) {
        _loading = true;
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
    var _colors = {
      Colors.teal[100],
      Colors.teal[200],
      Colors.teal[300],
      Colors.teal[400],
      Colors.teal[500],
      Colors.teal[600],
      Colors.teal[700],
      Colors.teal[800],
    };

    return GridView.builder(
      controller: _scrollController,
      itemCount: _pokemonList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
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
            _colors.elementAt(index % _colors.length),
            pokemon.name,
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
    _loading = false;
    _pokemonList = [];
    _scrollController = ScrollController();

    fetchData();
  }

  fetchData() async {
    try {
      final response = await get(
        Uri.parse(
          "https://pokeapi.co/api/v2/pokemon?limit=$_limit&offset=$_offset",
        ),
      );
      Map responseList = json.decode(response.body);
      List results = responseList["results"];
      var pokemonList =
          results.map((data) => PokemonInfo(data["name"] ?? "No name"));

      _pokemonList.addAll(pokemonList);
      setState(() {
        _loading = false;
        _offset += _limit;
        _pokemonList = _pokemonList;
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
      });
    }
  }
}
