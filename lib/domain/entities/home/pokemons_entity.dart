class PokemonsEntity{
  String next;
  List<Pokemon> pokemon;

  PokemonsEntity({ required this.next, required this.pokemon});
}


class Pokemon{
  String name;
  String url;
  Pokemon({required this.name, required this.url});
}