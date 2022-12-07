import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import '../model/post.dart';
import '../widgets/post_item.dart';

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

  final _suggestions = <WordPair>[];
  _suggestions.addAll(generateWordPairs().take(_colors.length));

  return GridView.builder(
    itemBuilder: (BuildContext context, int index) {
      return pokemonTile(
        _colors.elementAt(index % _colors.length),
        _suggestions.elementAt(index % _colors.length).asPascalCase,
        index + 1,
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1.3,
    ),
  );
}

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
    padding: const EdgeInsets.only(left: 16, right: 8, top: 20, bottom: 8),
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
  var _isLastPage = false;
  var _pageNumber = 0;
  var _loading = false;
  final int _numberOfPostsPerRequest = 20;
  late List<Post> _posts;
  final int _nextPageTrigger = 3;

  @override
  Widget build(BuildContext context) {
    return _getPokeGrid();
  }
}
