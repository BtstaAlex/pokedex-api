import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> todosPokemons = [];
  List<Pokemon> pokemonsParaMostrar = [];
  bool carregando = true;
  String textoBusca = '';

  @override
  void initState() {
    super.initState();
    buscarPokemons();
  }

  Future<void> buscarPokemons() async {
    try {
      setState(() {
        carregando = true;
      });

      final dio = Dio();
      todosPokemons = [];

      for (int i = 1; i <= 150; i++) {
        final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$i/');

        if (response.statusCode == 200) {
          final pokemon = Pokemon.fromJson(response.data);
          todosPokemons.add(pokemon);
        }
      }

      setState(() {
        pokemonsParaMostrar = todosPokemons;
        carregando = false;
      });
    } catch (e) {
      setState(() {
        carregando = false;
      });
    }
  }

  void filtrarPokemons(String busca) {
    setState(() {
      textoBusca = busca;

      if (busca.isEmpty) {
        pokemonsParaMostrar = todosPokemons;
      } else {
        pokemonsParaMostrar = todosPokemons.where((pokemon) {
          return pokemon.nome.toLowerCase().contains(busca.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 82, 177, 255),
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: filtrarPokemons,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Buscar Pokémon...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: carregando
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 82, 229, 255),
                    ),
                  )
                : pokemonsParaMostrar.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 70,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          textoBusca.isEmpty
                              ? 'Nenhum Pokémon carregado'
                              : 'Nenhum Pokémon encontrado',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: pokemonsParaMostrar.length,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pokemon.imagemUrl.isNotEmpty
                                  ? Image.network(
                                      pokemon.imagemUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.contain,
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

class PokemonDetalhePage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetalhePage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.nome.toUpperCase()),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: pokemon.imagemUrl.isNotEmpty
                  ? Image.network(pokemon.imagemUrl, width: 150, height: 150)
                  : const Icon(Icons.question_mark, size: 100),
            ),
            const SizedBox(height: 20),
            Text(
              pokemon.nome.toUpperCase(),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: pokemon.tipos
                  .map(
                    (tipo) => Chip(
                      label: Text(tipo.toUpperCase()),
                      backgroundColor: Colors.lightBlue[100],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Habilidades",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: pokemon.habilidades
                  .map(
                    (habilidade) => Chip(
                      label: Text(habilidade.toUpperCase()),
                      backgroundColor: Colors.green[100],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Experiência Base: ${pokemon.xpBase}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Estatísticas",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 10),
            ...pokemon.stats.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.key.toUpperCase()),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: entry.value / 200,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    Text("${entry.value}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
