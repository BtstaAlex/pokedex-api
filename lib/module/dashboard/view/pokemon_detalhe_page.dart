import 'package:flutter/material.dart';
import '../core/domain/model/pokemon.dart';

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

            // Nome
            Text(
              pokemon.nome.toUpperCase(),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Tipos
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tipos",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
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

            // Habilidades
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

            // XP Base
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Experiência Base: ${pokemon.xpBase}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Estatísticas
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
