import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mytreeflutter/api/dependencies/Injection.dart';
import 'package:mytreeflutter/api/util/Constants.dart';
import '../../api/dependencies/DI.dart';
import '../../api/models/Tree.dart';
import '../../api/usecase/GetTreeUseCase.dart';

class TreesListViewModel extends ChangeNotifier {

  final GetTreeUseCase _getTreesUseCase = DependencyInjection().get<GetTreeUseCase>(Dependencies.useCase.value);
  int index = 1;
  final List<Tree> _trees = [];

  Future<List<Tree>> fetchTrees() async {
    final trees = await _getTreesUseCase.execute(index * Constants.numOfItems);
      _trees.addAll(trees);
      index = index+1;
    return _trees;
  }

}
