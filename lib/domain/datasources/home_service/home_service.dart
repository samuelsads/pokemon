import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/domain/entities/home/pokemons_entity.dart';

abstract class HomeService {
  Future<PokemonsEntity> getPokemons(String next);

  Future<PokemonEntity> getPokemonInf(String url);

  Future<PokemonEntity> searchPokemon(String query);
}
