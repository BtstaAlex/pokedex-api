import 'package:dio/dio.dart';
import '../../domain/model/pokemon.dart';

class PokemonRepository {
  final Dio dio;

  PokemonRepository(this.dio);

  Future<List<Pokemon>> buscarPokemons() async {
    List<Pokemon> pokemons = [];

    for (int i = 1; i <= 150; i++) {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$i/');
      if (response.statusCode == 200) {
        final pokemon = Pokemon.fromJson(response.data);
        pokemons.add(pokemon);
      }
    }
    return pokemons;
  }
}
