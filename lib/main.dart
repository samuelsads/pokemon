import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/configs/router/app_router.dart';
import 'package:pokemon/core/network/dio_client.dart';
import 'package:pokemon/data/datasources/home/home_service_impl.dart';
import 'package:pokemon/data/repositories/home/home_repository_impl.dart';
import 'package:pokemon/presentation/blocs/home/home_bloc.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => HomeBloc(
            HomeRepositoryImpl(homeService: HomeServiceImpl(DioClient()))),
      )
    ], child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'Material App',
    );
  }
}
