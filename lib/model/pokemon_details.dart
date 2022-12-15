import 'package:pokedex/model/ability.dart';
import 'package:pokedex/model/stats.dart';
import 'package:pokedex/model/type.dart';

class PokemonDetails {
  final String name;
  final int height;
  final int weight;
  final List<TypeSlot> typeSlotList;
  final List<AbilitySlot> abilitySlotList;
  final List<BaseStats> baseStats;

  PokemonDetails(
    this.name,
    this.height,
    this.weight,
    this.typeSlotList,
    this.abilitySlotList,
    this.baseStats,
  );

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    var abilitiesList = (json["abilities"] as List<dynamic>)
        .map((abilitySlot) => AbilitySlot.fromJson(abilitySlot));

    var typesList = (json["types"] as List<dynamic>)
        .map((typeSlot) => TypeSlot.fromJson(typeSlot));

    var baseStatsList = (json["stats"] as List<dynamic>)
        .map((typeSlot) => BaseStats.fromJson(typeSlot));

    return PokemonDetails(
      json["name"],
      json["height"],
      json["weight"],
      typesList.toList(),
      abilitiesList.toList(),
      baseStatsList.toList(),
    );
  }

  String displayAbilities() {
    return abilitySlotList
        .map((abilitySlot) => abilitySlot.ability.name)
        .join(", ");
  }
}
