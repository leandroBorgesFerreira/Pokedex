
import 'package:pokedex/utils/string.dart';

class TypeSlot {

  final int slot;
  final Type type;

  TypeSlot(this.slot, this.type);

  factory TypeSlot.fromJson(Map<String, dynamic> json) {
    var type = json["type"];

    return TypeSlot(
      json["slot"],
      Type.fromSlot(type),
    );
  }
}

class Type {

  final String name;

  Type(this.name);

  factory Type.fromSlot(Map<String, dynamic> json) {
    return Type((json["name"] as String).capitalize());
  }
}
