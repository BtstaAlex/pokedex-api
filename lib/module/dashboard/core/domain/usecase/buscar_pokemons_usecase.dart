import '../../data/repository/pokemon_repository.dart';
import '../model/pokemon.dart';

class BuscarPokemonsUseCase {
  final PokemonRepository repository;

  BuscarPokemonsUseCase(this.repository);

  Future<List<Pokemon>> call() async {
    return await repository.buscarPokemons();
  }
}
