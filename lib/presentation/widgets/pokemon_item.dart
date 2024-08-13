import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/presentation/pages/home/information_page.dart';
import 'package:pokemon/utils/formats.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    required this.controller,
    super.key,
    required this.pokemons,
  });
  final ScrollController controller;
  final List<PokemonEntity> pokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: pokemons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(
              InformationPage.name,
              extra: pokemon,
            );
          },
          child: Container(
            margin: const EdgeInsets.only(
              top: 24,
              left: 12,
              right: 12,
            ),
            padding: const EdgeInsets.only(bottom: 12),
            height: 300,
            decoration: BoxDecoration(
                color: pokemon.color, borderRadius: BorderRadius.circular(22)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.network(
                  pokemon.image,
                  height: 100,
                  width: 100,
                ),
                Text(
                  pokemon.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "#${Formats().formatId(pokemon.id)}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
