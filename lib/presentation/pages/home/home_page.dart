import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/presentation/blocs/home/home_bloc.dart';
import 'package:pokemon/presentation/widgets/pokemon_item.dart';

class HomePage extends StatefulWidget {
  static const name = "home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late ScrollController _controller;
late TextEditingController _search;
bool hasNextPage = true;
bool isFirstLoadingRunning = false;
bool isLoadMoreRunning = false;
bool wait = false;
Timer? timer;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller = ScrollController()..addListener(_loadMore);
    _search = TextEditingController()..addListener(_showSearch);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (mounted) {
          context.read<HomeBloc>().getPokemons();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    timer?.cancel();
    _controller.dispose();
    _search.removeListener(_showSearch);
    _search.dispose();
    super.dispose();
  }

  void _showSearch() async {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 700), () {
      if (_search.text.isNotEmpty) {
        context.read<HomeBloc>().searchPokemon(_search.text);
      } else {
        context.read<HomeBloc>().repaintData();
      }
    });
  }

  void _loadMore() async {
    if (hasNextPage &&
        !isFirstLoadingRunning &&
        !isLoadMoreRunning &&
        !wait &&
        _controller.position.extentAfter < 200) {
      isLoadMoreRunning = true;
      wait = true;
      final response = await context.read<HomeBloc>().getPokemons();
      wait = false;

      if (!response) {
        hasNextPage = false;
      }

      if (hasNextPage) {
        setState(() {});
      }

      isLoadMoreRunning = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: CachedNetworkImage(
                    imageUrl:
                        "https://raw.githubusercontent.com/PokeAPI/media/master/logo/pokeapi_256.png"),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                child: const Text(
                  "Search for Pokémon by name or using the National Pokédex number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const _searchItem(),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.success) {
                    final pokemons = state.pokemonList ?? [];
                    if (pokemons.isEmpty) {
                      return const Center(
                        child: Text("No hay información"),
                      );
                    }

                    return Expanded(
                      child: PokemonItem(
                        pokemons: pokemons,
                        controller: _controller,
                      ),
                    );
                  }
                  if (state.error) {
                    return Expanded(
                      child: Container(
                        child: const Center(
                          child: Text(
                            "Error al obtener la información",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: Container(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          if (isLoadMoreRunning)
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                bottom: 5,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )))
        ],
      )),
    );
  }
}

class _searchItem extends StatelessWidget {
  const _searchItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
      child: TextFormField(
        controller: _search,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          label: const Text(
            "What Pokémon are you looking for?",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
