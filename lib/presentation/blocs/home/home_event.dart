part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props =>
      [const GetPokemonsEvent(), const SearchPokemonEvent()];
}

class GetPokemonsEvent extends HomeEvent {
  final PokemonsEntity? pokemons;
  final PokemonsStatus? status;
  final List<PokemonEntity>? pokemonList;
  final List<PokemonEntity>? pokemonListBackup;
  const GetPokemonsEvent(
      {this.pokemons, this.status, this.pokemonList, this.pokemonListBackup});
}

class SearchPokemonEvent extends HomeEvent {
  final PokemonsStatus? statusSearch;
  final PokemonEntity? search;

  const SearchPokemonEvent({this.statusSearch, this.search});
}
