import 'dart:convert';
import 'package:mytreeflutter/api/util/Constants.dart';

import '../../api/models/Tree.dart';
import 'package:http/http.dart' as http;

 class TreeApiClient {

   Future <List<Tree>> getTrees(int start) async {
     String _baseUrl = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=les-arbres&q=&rows=${Constants.numOfItems}&start=${start}&facet=typeemplacement&facet=domanialite&facet=arrondissement&facet=libellefrancais&facet=espece&facet=circonferenceencm&facet=hauteurenm';
                        //'https://opendata.paris.fr/api/records/1.0/search/?dataset=les-arbres&q=&facet=typeemplacement&facet=domanialite&facet=arrondissement&facet=libellefrancais&facet=espece&facet=circonferenceencm&facet=hauteurenm';

     final response = await http.get(Uri.parse(_baseUrl));
     if (response.statusCode == 200) {
       final jsonData = jsonDecode(response.body);
       final records = jsonData['records'];
       final trees = <Tree>[];
       for (final record in records) {
         final tree = Tree(
           id: record['recordid'],
           adresse: record['fields']['adresse'],
           circonferenceencm: record['fields']['circonferenceencm'],
           espece: record['fields']['espece']?? 'unknown',
           hauteurenm: record['fields']['hauteurenm'],
         );
         trees.add(tree);
       }
       return trees;
     } else {
       throw Exception('Failed to fetch trees');
     }
   }
}