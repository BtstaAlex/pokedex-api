import '../core/domain/model/pokemon.dart';
import '../core/domain/usecase/buscar_pokemons_usecase.dart';

class PokemonController {
  final BuscarPokemonsUseCase buscarPokemonsUseCase;

  PokemonController(this.buscarPokemonsUseCase);

  Future<List<Pokemon>> buscarPokemons() async {
    return await buscarPokemonsUseCase();
  }
}
