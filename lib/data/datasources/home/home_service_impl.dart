import 'package:pokemon/core/network/dio_client.dart';
import 'package:pokemon/data/mappers/home/pokemon_mapper.dart';
import 'package:pokemon/data/mappers/home/pokemons_mapper.dart';
import 'package:pokemon/data/models/home/pokemon_model.dart';
import 'package:pokemon/data/models/home/pokemons_model.dart';
import 'package:pokemon/domain/datasources/home_service/home_service.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/domain/entities/home/pokemons_entity.dart';

class HomeServiceImpl extends HomeService {
  final DioClient dioClient;

  HomeServiceImpl(this.dioClient);

  @override
  Future<PokemonsEntity> getPokemons(String next) async {
    PokemonsModel pokemons;
    PokemonsEntity entity;
    try {
      final resp = await dioClient.dio.get(next);
      pokemons = PokemonsModel.fromJson(resp.data);
      entity = PokemonsMapper.pokemons(pokemons);
    } catch (e) {
      throw Exception(e);
    }

    return entity;
  }

  @override
  Future<PokemonEntity> getPokemonInf(String url) async {
    PokemonModel pokemon;
    PokemonEntity entity;

    try {
      final resp = await dioClient.dio.get(url);
      pokemon = PokemonModel.fromJson(resp.data);
      entity = PokemonMapper.getPokemon(pokemon);
    } catch (e) {
      throw Exception(e);
    }
    return entity;
  }

  @override
  Future<PokemonEntity> searchPokemon(String query) async {
    PokemonModel pokemon;
    PokemonEntity entity;

    try {
      final resp = await dioClient.dio.get("/$query");
      pokemon = PokemonModel.fromJson(resp.data);
      entity = PokemonMapper.getPokemon(pokemon);
    } catch (e) {
      throw Exception(e);
    }
    return entity;
  }
}
