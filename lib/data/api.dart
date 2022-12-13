import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/model/pokemon_details.dart';
import 'package:pokedex/model/pokemon_info.dart';

const baseUrl = "https://pokeapi.co/api/v2";

Future<PokemonDetails> getPokemonDetails(int pokemonIndex) async {
  final response = await get(
    Uri.parse(
      "$baseUrl/pokemon/$pokemonIndex",
    ),
  );

  Map<String, dynamic> responseMap = json.decode(response.body);

  return PokemonDetails.fromJson(responseMap);
}

Future<List<PokemonInfo>> getPokemonInfoList(int limit, int offset) async {
  final response = await get(
    Uri.parse(
      "$baseUrl/pokemon?limit=$limit&offset=$offset",
    ),
  );
  Map responseMap = json.decode(response.body);
  List results = responseMap["results"];
  return results.map((data) => PokemonInfo(data["name"] ?? "No name")).toList();
}

String getPokemonImageUrl(int index) {
  return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$index.png";
}
