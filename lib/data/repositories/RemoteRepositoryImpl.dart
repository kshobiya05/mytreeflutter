import 'package:mytreeflutter/api/dependencies/DI.dart';
import 'package:mytreeflutter/api/dependencies/Injection.dart';
import 'package:mytreeflutter/api/repositories/RemoteRepository.dart';
import '../../api/models/Tree.dart';
import '../remote/TreeApi.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  final TreeApiClient apiClient = DependencyInjection().get<TreeApiClient>(Dependencies.api.value);

  @override
  Future<List<Tree>> getTrees(int start) async {
      final trees = await apiClient.getTrees(start);
      return trees;
  }
}