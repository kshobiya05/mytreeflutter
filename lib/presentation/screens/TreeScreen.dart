import 'package:flutter/material.dart';
import 'package:mytreeflutter/api/dependencies/Injection.dart';
import 'package:mytreeflutter/presentation/viewModel/TreesListViewModel.dart';
import '../../api/dependencies/DI.dart';
import '../../api/models/Tree.dart';
import '../Screens/TreeDetailsScreen.dart';

class TreeScreen extends StatefulWidget {

  @override
  _TreeScreenState createState() => _TreeScreenState();
}
class _TreeScreenState extends State<TreeScreen> {
  final TreesListViewModel _viewModel = DependencyInjection().get<TreesListViewModel>(Dependencies.viewModel.value);
  //final GetTreeUseCase _getTreesUseCase = DependencyInjection().get<GetTreeUseCase>(Dependencies.useCase.value);

  final List<Tree> _trees = [];
  int _start = 0;

  bool _isLoading = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchTrees();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _handleLoadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchTrees() async {
    final List<Tree> trees = await _viewModel.fetchTrees();
    setState(() {
      _trees.addAll(trees);
      _isLoading = false;
    });
  }

  Future<void> _handleLoadMore() async {
    setState(() {
      _isLoading = true;
      _start += _trees.length;
    });
    await _fetchTrees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des arbres'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        controller: _scrollController, // Ajouter le ScrollController ici
        itemCount: _trees.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _trees.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ListTile(
              title: Text(_trees[index].espece),
              subtitle: Text(_trees[index].id),
              leading: CircleAvatar(
                child: Text(_trees[index].espece.substring(0, 1)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TreeDetailsScreen(_trees[index])),
                );
              },
            );
          }
        },
      ),
    );
  }
}


