import 'package:mytreeflutter/api/repositories/LocalRepository.dart';
import 'package:mytreeflutter/api/usecase/GetTreeUseCase.dart';
import 'package:mytreeflutter/api/util/FetchStrategy.dart';
import 'package:mytreeflutter/presentation/connectivity/Connectivity.dart';
import '../../api/dependencies/DI.dart';
import '../../api/dependencies/Injection.dart';
import '../../api/models/Tree.dart';
import '../../api/models/TreeEntity.dart';
import '../../api/repositories/RemoteRepository.dart';

class GetTreesUseCaseImpl implements GetTreeUseCase {

  final RemoteRepository remoterepository= DependencyInjection().get<RemoteRepository>(Dependencies.remote.value);
  final LocalRepository  localrepository = DependencyInjection().get<LocalRepository>(Dependencies.local.value);

  Future<List<Tree>> execute(int start)  async {

      var fetchStrategy = await getFetchStrategy();
      print(fetchStrategy);

      if (fetchStrategy == FetchStrategy.Remote){
        final List<Tree> trees = await remoterepository.getTrees(start);
        final List<TreeEntity> convertedtrees = trees.map((tree) => tree.toEntity()).toList();
        localrepository.insertTrees(convertedtrees);
        return trees;
      }
      else {
        final trees = await localrepository.getTrees(start);
        final List<Tree> convertedTrees = trees.map((tree) => Tree.fromEntity(tree)).toList();
        return convertedTrees;
      }
  }
}