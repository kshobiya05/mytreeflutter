import '../models/Tree.dart';

abstract class RemoteRepository {
  Future<List<Tree>> getTrees(int start);
}
