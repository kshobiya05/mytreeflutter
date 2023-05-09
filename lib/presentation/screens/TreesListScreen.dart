import 'package:flutter/material.dart';
import '../../api/dependencies/DI.dart';
import '../../api/dependencies/Injection.dart';
import '../../api/models/Tree.dart';
import '../Screens/TreeDetailsScreen.dart';
import '../util/DataState.dart';
import '../viewModel/TreesListViewModel.dart';

class TreesListScreen extends StatefulWidget {
  const TreesListScreen({super.key});

  @override
  _TreesListScreenState createState() => _TreesListScreenState();
}

class _TreesListScreenState extends State<TreesListScreen> {
  late TreesListViewModel _viewModel;

  @override
  void initState() {
    _viewModel = DependencyInjection().get<TreesListViewModel>(Dependencies.viewModel.value);
    _viewModel.fetchTrees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Trees'),
      ),
      body: StreamBuilder<DataState<List<Tree>>>(
        initialData: _viewModel.treesState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is DataStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DataStateSuccess) {
            final trees = state?.data;

            return ListView.builder(
              itemCount: trees?.length,
              itemBuilder: (context, index) {
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
            );
          }
            return const Center(
              child: Text('An error occurred while fetching the trees'),
            );
          }
      ),
    );
  }
}
