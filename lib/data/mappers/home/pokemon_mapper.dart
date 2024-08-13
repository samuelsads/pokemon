import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon/data/mappers/home/pokemon_stats_mapper.dart';
import 'package:pokemon/data/models/home/pokemon_model.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';

final List<MaterialColor> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.cyan,
  Colors.amber,
  Colors.indigo,
  Colors.pink,
];

class PokemonMapper {
  static PokemonEntity getPokemon(PokemonModel m) => PokemonEntity(
      name: m.name ?? "",
      image: m.sprites?.other?.dreamWorld?.frontDefault ?? "",
      id: m.id,
      type: (((m.types ?? []).isNotEmpty)) ? m.types![0].type?.name ?? "" : "",
      color: colors[Random().nextInt(colors.length)],
      stats: (m.stats ?? [])
          .map(
            (Stat e) => PokemonStatsMapper.stat(e),
          )
          .toList(),
      weight: m.weight ?? 0,
      height: m.height ?? 0);
}
