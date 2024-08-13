import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/domain/entities/home/pokemons_entity.dart';
import 'package:pokemon/domain/repositories/home/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(const HomeState()) {
    on<GetPokemonsEvent>((event, emit) => emit(state.copyWith(
        pokemons: event.pokemons,
        status: event.status,
        pokemonList: event.pokemonList,
        pokemonListBackup: event.pokemonListBackup)));

    on<SearchPokemonEvent>(
      (event, emit) => emit(state.copyWith(
          statusSearch: event.statusSearch, search: event.search)),
    );
  }

  Future<void> searchPokemon(String query) async {
    add(const GetPokemonsEvent(status: PokemonsStatus.loading));
    try {
      final data = await _repository.searchPokemon(query);
      List<PokemonEntity> list = [data];
      add(GetPokemonsEvent(
          status: PokemonsStatus.success,
          pokemonList: list,
          pokemonListBackup: [...state.pokemonList ?? []]));
    } catch (e) {
      add(const GetPokemonsEvent(status: PokemonsStatus.error));
    }
  }

  Future<bool> getPokemons() async {
    if ((state.pokemonList ?? []).isEmpty) {
      add(const GetPokemonsEvent(status: PokemonsStatus.loading));
    }
    final limit = state.limit ?? 20;
    final offset = state.offset ?? 0;
    final next = state.pokemons?.next ?? "?offset=$offset&limit=$limit";
    List<PokemonEntity> pok = [];
    try {
      final data = await _repository.getPokemons(next);
      if (data.pokemon.isNotEmpty) {
        for (var pokemon in data.pokemon) {
          final pokemonInf = await _repository.getPokemonInf(pokemon.url);
          pok.add(pokemonInf);
        }
        if ((state.pokemonList ?? []).isEmpty) {
          add(GetPokemonsEvent(
              status: PokemonsStatus.success,
              pokemons: data,
              pokemonList: [...pok]));
        } else {
          add(GetPokemonsEvent(
              pokemons: data,
              pokemonList: [...(state.pokemonList ?? []), ...pok]));
        }

        return true;
      } else {
        add(GetPokemonsEvent(status: PokemonsStatus.error, pokemons: data));
        return false;
      }
    } catch (e) {
      add(const GetPokemonsEvent(status: PokemonsStatus.error));
      return false;
    }
  }

  Future<void> repaintData() async {
    add(GetPokemonsEvent(
        status: PokemonsStatus.success, pokemonList: state.pokemonListBackup));
  }
}
