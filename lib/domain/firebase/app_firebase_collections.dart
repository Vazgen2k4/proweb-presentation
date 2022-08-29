import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CollectionsNames {
  static const directions = 'directions';
  static const admins = 'admins';
}

abstract class AppFirebaseCollections {
  static final directions = FirebaseFirestore.instance.collection(
    CollectionsNames.directions,
  );
  static final admins = FirebaseFirestore.instance.collection(
    CollectionsNames.admins,
  );
}
