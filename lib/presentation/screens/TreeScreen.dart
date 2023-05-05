import 'package:flutter/material.dart';
import '../../api/dependencies/DI.dart';
import '../../api/dependencies/Injection.dart';
import '../../api/models/Tree.dart';
import '../Screens/TreeDetailsScreen.dart';
import '../util/DataState.dart';
import '../viewModel/TreesListViewModel.dart';


class TreeScreen extends StatelessWidget {
  const TreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = DependencyInjection().get<TreesListViewModel>(Dependencies.viewModel.value);
    final scrollController = ScrollController();
    viewModel.fetchTrees();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        viewModel.fetchTrees();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des arbres'),
      ),
      body: _buildTreesList(viewModel.treesState, scrollController),
    );
  }

  Widget _buildTreesList(DataState<List<Tree>> treesState, ScrollController scrollController) {

    if (treesState is DataStateLoading  && treesState.data!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (treesState is DataStateSuccess) {
      final trees = treesState.data;

      return ListView.builder(
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          final tree = trees![index];
          return ListTile(
            title: Text(tree.espece),
            subtitle: Text(tree.id),
            leading: CircleAvatar(
              child: Text(tree.espece.substring(0, 1)),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TreeDetailsScreen(tree)),
              );
            },
          );
        },
        itemCount: trees?.length ?? 0,
      );
    } else if (treesState is DataStateError) {
      return const Center(child: Text('Une erreur est survenue.'));
    } else if(treesState is DataStateIdle){
      return const Center(child: Text('Aucune donnée à afficher.'));
    }
    else{
      return const Center(child: Text('Une erreur inconnue est survenue'));
    }
  }
}
