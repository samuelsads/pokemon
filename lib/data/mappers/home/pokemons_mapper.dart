
import 'package:pokemon/data/mappers/home/pokemon_by_pokemons_mapper.dart';
import 'package:pokemon/data/models/home/pokemons_model.dart';
import 'package:pokemon/domain/entities/home/pokemons_entity.dart';

class PokemonsMapper{
  static PokemonsEntity pokemons(PokemonsModel p)=>PokemonsEntity(next: p.next??"", pokemon: (p.results??[]).map((e) => PokemonByPokemonsMapper.pokemon(e),).toList());
}