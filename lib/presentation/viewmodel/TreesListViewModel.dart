import 'package:flutter/cupertino.dart';
import 'package:mytreeflutter/api/dependencies/Injection.dart';
import 'package:mytreeflutter/api/util/Constants.dart';
import '../../api/dependencies/DI.dart';
import '../../api/models/Tree.dart';
import '../../api/usecase/GetTreeUseCase.dart';
import '../util/DataState.dart';

class TreesListViewModel extends ChangeNotifier {

  final GetTreeUseCase _getTreesUseCase = DependencyInjection().get<GetTreeUseCase>(Dependencies.useCase.value);
  int index = 1;
  DataState<List<Tree>> _treesState = DataStateIdle([]);

  DataState<List<Tree>> get treesState => _treesState;

  Future<void> fetchTrees() async {
    notifyListeners();
    final trees = await _getTreesUseCase.execute(index * Constants.numOfItems);
    if (_treesState is DataStateSuccess<List<Tree>>) {
      final actualtrees = (_treesState as DataStateSuccess<List<Tree>>).data;
      final updatedTrees = List<Tree>.from(actualtrees as Iterable)
        ..addAll(trees);
      _treesState = DataStateSuccess(updatedTrees);
      notifyListeners();
      index = index+1;
    }
    else if (_treesState is DataStateLoading){
      _treesState = DataStateLoading(null);
      notifyListeners(); //never called
    }
    else {
      _treesState = DataStateSuccess(trees);
      notifyListeners();
    }
    notifyListeners();
  }
}
