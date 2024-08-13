part of 'home_bloc.dart';

enum PokemonsStatus { initial, loading, success, error, done }

class HomeState extends Equatable {
  const HomeState(
      {this.pokemons,
      this.status = PokemonsStatus.initial,
      this.offset,
      this.limit,
      this.pokemonList,
      this.color,
      this.statusSearch,
      this.search,
      this.pokemonListBackup});
  final PokemonsEntity? pokemons;
  final PokemonEntity? search;
  final PokemonsStatus? status;
  final PokemonsStatus? statusSearch;
  final List<PokemonEntity>? pokemonList;
  final List<PokemonEntity>? pokemonListBackup;
  final int? offset;
  final int? limit;
  final Color? color;

  HomeState copyWith(
          {PokemonsEntity? pokemons,
          PokemonsStatus? status,
          int? limit,
          int? offset,
          List<PokemonEntity>? pokemonList,
          Color? color,
          PokemonsStatus? statusSearch,
          PokemonEntity? search,
          List<PokemonEntity>? pokemonListBackup}) =>
      HomeState(
          pokemons: pokemons ?? this.pokemons,
          status: status ?? this.status,
          limit: limit ?? this.limit,
          offset: offset ?? this.offset,
          pokemonList: pokemonList ?? this.pokemonList,
          color: color ?? this.color,
          statusSearch: statusSearch ?? this.statusSearch,
          search: search ?? this.search,
          pokemonListBackup: pokemonListBackup ?? this.pokemonListBackup);
  @override
  List<Object?> get props => [
        pokemons,
        status,
        limit,
        offset,
        pokemonList,
        color,
        statusSearch,
        search,
        pokemonListBackup
      ];
}

extension HomeStateX on HomeState {
  bool get error => status == PokemonsStatus.error;
  bool get loading => status == PokemonsStatus.loading;
  bool get initial => status == PokemonsStatus.initial;
  bool get success => status == PokemonsStatus.success;
  bool get done => status == PokemonsStatus.done;

  bool get errorSearch => statusSearch == PokemonsStatus.error;
  bool get loadingSearch => statusSearch == PokemonsStatus.loading;
  bool get initialSearch => statusSearch == PokemonsStatus.initial;
  bool get successSearch => statusSearch == PokemonsStatus.success;
  bool get doneSearch => statusSearch == PokemonsStatus.done;
}
