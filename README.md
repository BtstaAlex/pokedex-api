# Pokédex Flutter - API 

Uma Pokédex construída em **Flutter** que consome dados da **[PokéAPI](https://pokeapi.co/)**. Permite buscar, listar e visualizar detalhes de Pokémon de forma rápida e interativa.

---

## Funcionalidades

- Busca de Pokémon pelo nome.
- Visualização em **grid de quadradinhos** com imagem e nome.
- Página de detalhes de cada Pokémon, exibindo:
  - Nome
  - Número
  - Tipos (ex: Water, Fire)
  - Habilidades (skills)
  - Base experience (XP)
  - Estatísticas (HP, Attack, Defense, etc.)
- Carregamento incremental dos Pokémon para melhorar a experiência.
- Feedback visual durante carregamento ou quando nenhum Pokémon é encontrado.

---

## Tecnologias

- **Flutter**: Frontend para Android, iOS e Web.
- **Dart**: Linguagem principal.
- **Dio**: Cliente HTTP para requisições assíncronas.
- **PokéAPI**: Fonte de dados oficial de Pokémon.

---

## Download e execução


1. Faça o download do repositório:
```bash
git clone <https://github.com/BtstaAlex/pokedex-api.git``
```

2. Entre na pasta do projeto:
```bash
cd pokedex-api
```

3. Instale as dependências do Flutter:
```bash
flutter pub get
```

4. Rode o projeto:
```bash
flutter run
```