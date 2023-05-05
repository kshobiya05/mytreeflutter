import 'package:mytreeflutter/api/dependencies/DI.dart';
import 'package:mytreeflutter/api/dependencies/Injection.dart';
import 'package:mytreeflutter/api/models/TreeEntity.dart';
import 'package:mytreeflutter/data/local/database.dart';

import '../../api/repositories/LocalRepository.dart';

class LocalRepositoryImpl extends LocalRepository{
  final db = DependencyInjection().get<DatabaseHelper>(Dependencies.database.value);
  @override
  Future<List<TreeEntity>> getTrees(int start) {
    return db.getAllTrees(start);
  }

  @override
  void insertTrees(List<TreeEntity> list) {
    db.insertAllTrees(list);
  }



}