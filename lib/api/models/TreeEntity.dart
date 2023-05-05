
class TreeEntity {
  final String id;
  final String adresse;
  final int circonferenceencm;
  final String espece;
  final int hauteurenm;
  final String timestamp;

  TreeEntity({
    required this.id,
    required this.adresse,
    required this.circonferenceencm,
    required this.espece,
    required this.hauteurenm,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    final timestamp = DateTime.now().toIso8601String();
    return {'id': id, 'adresse': adresse, 'circonferenceencm':circonferenceencm,'espece': espece, 'hauteurenm':hauteurenm,'timestamp':timestamp };
  }



}