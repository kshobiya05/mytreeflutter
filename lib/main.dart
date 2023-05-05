import 'package:flutter/material.dart';
import 'package:mytreeflutter/api/dependencies/Injection.dart';
import 'package:mytreeflutter/data/local/database.dart';
import 'package:mytreeflutter/data/repositories/LocalRepositoryImpl.dart';
import 'package:mytreeflutter/domain/usecase/GetTreeUseCaseImpl.dart';
import 'package:mytreeflutter/presentation/screens/TreeScreen.dart';
import 'package:mytreeflutter/presentation/viewModel/TreesListViewModel.dart';
import 'api/dependencies/DI.dart';
import 'data/remote/TreeApi.dart';
import 'data/repositories/RemoteRepositoryImpl.dart';

Future <void> main() async {
  final injector = DependencyInjection();
  injector.register(Dependencies.api.value, TreeApiClient());
  injector.register(Dependencies.database.value,DatabaseHelper());
  injector.register(Dependencies.remote.value, RemoteRepositoryImpl());
  injector.register(Dependencies.local.value,LocalRepositoryImpl());
  injector.register(Dependencies.useCase.value, GetTreesUseCaseImpl());
  injector.register(Dependencies.viewModel.value, TreesListViewModel());
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon application',
      home: TreeScreen(),
    );
  }
}



