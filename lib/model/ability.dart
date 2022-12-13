import 'package:pokedex/utils/string.dart';

class AbilitySlot {
  final int slot;
  final Ability ability;

  AbilitySlot(this.slot, this.ability);

  factory AbilitySlot.fromJson(Map<String, dynamic> json) {
    var ability = json["ability"];

    return AbilitySlot(
      json["slot"],
      Ability.fromSlot(ability),
    );
  }
}

class Ability {
  final String name;

  Ability(this.name);

  factory Ability.fromSlot(Map<String, dynamic> json) {
    return Ability((json["name"] as String).capitalize());
  }
}
