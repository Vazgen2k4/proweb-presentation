import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proweb_presentations_web/domain/json_convertors/directions.dart';

class DirectionsProvider extends ChangeNotifier {
  List<String> _lables = [];
  List<String> get lables => _lables;

  List<Directions> _directions = [];
  List<Directions> get directions => _directions;

  void setUp(QuerySnapshot<Map<String, dynamic>>? snapshot) async {
    if (snapshot == null) return;

    _directions = snapshot.docs.map<Directions>((item) {
      return Directions.fromJson(item.data());
    }).toList();

    _directions.sort((a, b) {
      if (a.id! < b.id!) {
        return -1;
      } else if (a.id! < b.id!) {
        return 1;
      } else {
        return 0;
      }
    });

    _lables = _directions.map<String>((e) => e.title ?? 'error').toList();
  }
}
