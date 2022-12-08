import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/model/pokemon_info.dart';

Future<List<PokemonInfo>> getPokemonInfoList(int limit, int offset) async {
  final response = await get(
    Uri.parse(
      "https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset",
    ),
  );
  Map responseList = json.decode(response.body);
  List results = responseList["results"];
  return results.map((data) => PokemonInfo(data["name"] ?? "No name")).toList();
}

String getPokemonImageUrl(int index) {
  return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$index.png";
}
