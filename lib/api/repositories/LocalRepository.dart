import '../models/TreeEntity.dart';

abstract class LocalRepository {

  Future<List<TreeEntity>> getTrees(int start);

  void insertTrees(List<TreeEntity> list);
}