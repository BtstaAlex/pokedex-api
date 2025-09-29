import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../controller/pokemon_controller.dart';
import '../core/data/repository/pokemon_repository.dart';
import '../core/domain/model/pokemon.dart';
import '../core/domain/usecase/buscar_pokemons_usecase.dart';
import 'pokemon_detalhe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PokemonController controller;
  List<Pokemon> todosPokemons = [];
  List<Pokemon> pokemonsParaMostrar = [];
  bool carregando = true;
  String textoBusca = '';

  @override
  void initState() {
    super.initState();
    controller = PokemonController(
      BuscarPokemonsUseCase(PokemonRepository(Dio())),
    );
    buscarPokemons();
  }

  Future<void> buscarPokemons() async {
    setState(() => carregando = true);
    todosPokemons = await controller.buscarPokemons();
    setState(() {
      pokemonsParaMostrar = todosPokemons;
      carregando = false;
    });
  }

  void filtrarPokemons(String busca) {
    setState(() {
      textoBusca = busca;
      if (busca.isEmpty) {
        pokemonsParaMostrar = todosPokemons;
      } else {
        pokemonsParaMostrar = todosPokemons
            .where((p) => p.nome.toLowerCase().contains(busca.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: filtrarPokemons,
              decoration: InputDecoration(
                hintText: 'Buscar Pokémon...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: carregando
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: pokemonsParaMostrar.length,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final pokemon = pokemonsParaMostrar[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PokemonDetalhePage(pokemon: pokemon),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pokemon.imagemUrl.isNotEmpty
                                  ? Image.network(
                                      pokemon.imagemUrl,
                                      width: 80,
                                      height: 80,
                                    )
                                  : const Icon(Icons.question_mark, size: 50),
                              const SizedBox(height: 8),
                              Text(
                                pokemon.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
