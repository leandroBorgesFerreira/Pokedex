import 'package:pokedex/model/ability.dart';
import 'package:pokedex/model/type.dart';

class PokemonDetails {
  final String name;
  final int height;
  final int weight;
  final List<TypeSlot> typeSlotList;
  final List<AbilitySlot> abilitySlotList;

  PokemonDetails(
    this.name,
    this.height,
    this.weight,
    this.typeSlotList,
    this.abilitySlotList,
  );

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    var abilitiesList = (json["abilities"] as List<dynamic>)
        .map((abilitySlot) => AbilitySlot.fromJson(abilitySlot));

    var typesList = (json["types"] as List<dynamic>)
        .map((typeSlot) => TypeSlot.fromJson(typeSlot));

    return PokemonDetails(
      json["name"],
      json["height"],
      json["weight"],
      typesList.toList(),
      abilitiesList.toList(),
    );
  }

  String displayAbilities() {
    return abilitySlotList
        .map((abilitySlot) => abilitySlot.ability.name)
        .join(", ");
  }
}
