import 'package:flutter/material.dart';

class PokemonEntity {
  String name;
  String image;
  int id;
  Color color;
  String type;
  List<Stats> stats;
  int height;
  int weight;

  PokemonEntity(
      {required this.name,
      required this.image,
      required this.id,
      required this.color,
      required this.type,
      required this.stats,
      required this.height,
      required this.weight});
}

class Stats {
  String name;
  int stat;

  Stats({required this.name, required this.stat});
}
