import 'package:pokemon/data/models/home/pokemon_model.dart' as PM;
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';

class PokemonStatsMapper {
  static Stats stat(PM.Stat s) =>
      Stats(name: s.stat?.name ?? "", stat: s.baseStat ?? 0);
}
