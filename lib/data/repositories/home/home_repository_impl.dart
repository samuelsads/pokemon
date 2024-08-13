import 'package:pokemon/domain/datasources/home_service/home_service.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/domain/entities/home/pokemons_entity.dart';
import 'package:pokemon/domain/repositories/home/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeService homeService;

  HomeRepositoryImpl({required this.homeService});

  @override
  Future<PokemonsEntity> getPokemons(String next) async =>
      homeService.getPokemons(next);

  @override
  Future<PokemonEntity> getPokemonInf(String url) async =>
      homeService.getPokemonInf(url);

  @override
  Future<PokemonEntity> searchPokemon(String query) async =>
      homeService.searchPokemon(query);
}
