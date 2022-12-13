import 'package:pokedex/utils/string.dart';

class PokemonInfo {
  final String name;
  final String type;

  PokemonInfo(this.name, [this.type = "Unkown"]);

  String displayName() {
    return name.capitalize();
  }
}
