class Pokemon {
  final String nome;
  final String imagemUrl;
  final List<String> tipos;
  final List<String> habilidades;
  final int xpBase;
  final Map<String, int> stats;

  Pokemon({
    required this.nome,
    required this.imagemUrl,
    required this.tipos,
    required this.habilidades,
    required this.xpBase,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      nome: json['name'] ?? '',
      imagemUrl: json['sprites']['front_default'] ?? '',
      tipos: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      habilidades: (json['abilities'] as List)
          .map((h) => h['ability']['name'] as String)
          .toList(),
      xpBase: json['base_experience'] ?? 0,
      stats: {for (var s in json['stats']) s['stat']['name']: s['base_stat']},
    );
  }
}
