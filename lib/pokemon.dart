class Pokemon {
  final String nome;
  final String imagemUrl;
  final int numero;
  final List<String> tipos;
  final List<String> habilidades;
  final int xpBase;
  final Map<String, int> stats;

  Pokemon({
    required this.nome,
    required this.imagemUrl,
    required this.numero,
    required this.tipos,
    required this.habilidades,
    required this.xpBase,
    required this.stats,
  });

  static Pokemon fromJson(Map<String, dynamic> json) {
    final habilidades =
        (json['abilities'] as List<dynamic>?)
            ?.map((h) => h['ability']?['name'] as String? ?? '')
            .where((name) => name.isNotEmpty)
            .toList() ??
        [];

    final Map<String, int> stats = {};
    for (var stat in json['stats'] ?? []) {
      final name = stat['stat']?['name'] as String?;
      final value = stat['base_stat'] as int?;
      if (name != null && value != null) {
        stats[name] = value;
      }
    }

    return Pokemon(
      nome: json['name'] ?? '',
      imagemUrl: json['sprites'] != null
          ? json['sprites']['front_default'] ?? ''
          : '',
      numero: json['id'] ?? 0,
      tipos: json['types'] != null
          ? (json['types'] as List)
                .map((type) => type['type']['name'] as String)
                .toList()
          : [],
      habilidades: habilidades,
      xpBase: json['base_experience'] ?? 0,
      stats: stats,
    );
  }
}
