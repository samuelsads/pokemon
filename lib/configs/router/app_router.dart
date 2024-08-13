import 'package:go_router/go_router.dart';
import 'package:pokemon/domain/entities/home/pokemon_entity.dart';
import 'package:pokemon/presentation/pages/home/home_page.dart';
import 'package:pokemon/presentation/pages/home/information_page.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: '/',
    name: HomePage.name,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/information-page',
    name: InformationPage.name,
    builder: (context, state) {
      final pokemon = state.extra as PokemonEntity;
      return InformationPage(pokemon: pokemon);
    },
  ),
]);
