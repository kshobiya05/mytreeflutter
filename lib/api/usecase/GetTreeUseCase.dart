import '../models/Tree.dart';

abstract class GetTreeUseCase{
  Future<List<Tree>> execute(int start);
}