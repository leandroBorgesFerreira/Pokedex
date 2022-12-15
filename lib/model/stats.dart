
import 'package:pokedex/utils/string.dart';

class BaseStats {

  final int baseStat;
  final Stat stat;

  BaseStats(this.baseStat, this.stat);

  factory BaseStats.fromJson(Map<String, dynamic> json) {
    var stat = json["stat"];

    return BaseStats(
      json["base_stat"],
      Stat.fromSlot(stat),
    );
  }
}

class Stat {

  final String name;

  Stat(this.name);

  factory Stat.fromSlot(Map<String, dynamic> json) {
    return Stat((json["name"] as String).capitalize());
  }
}
