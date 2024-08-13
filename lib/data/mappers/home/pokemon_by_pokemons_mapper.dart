import 'package:pokemon/data/models/home/pokemons_model.dart';
import 'package:pokemon/domain/entities/home/pokemons_entity.dart' as PE;
class PokemonByPokemonsMapper{
  static PE.Pokemon pokemon(Result r)=>PE.Pokemon( name: r.name!, url: r.url!,);
}