import 'package:mytreeflutter/api/models/TreeEntity.dart';

class Tree {
  final String id;
  final String adresse;
  final int circonferenceencm;
  final String espece;
  final int hauteurenm;

  Tree ({
     required this.id,
     required this.adresse,
     required this.circonferenceencm,
     required this.espece,
     required this.hauteurenm,
  });

  static Tree fromEntity(TreeEntity tree) {
    return Tree(
        id : tree.id,
        adresse: tree.adresse,
        circonferenceencm: tree.circonferenceencm,
        espece: tree.espece,
        hauteurenm: tree.hauteurenm
    );
  }
  TreeEntity toEntity() {
    return TreeEntity(
      id: id,
      adresse: adresse,
      circonferenceencm: circonferenceencm,
      espece: espece,
      hauteurenm: hauteurenm,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}