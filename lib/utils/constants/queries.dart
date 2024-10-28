import 'package:cloud_firestore/cloud_firestore.dart';

class LocalQuery {
  static Query<Map<String, dynamic>> featuredProduct =
  FirebaseFirestore.instance.collection('Products')
      .where('IsFeature' , isEqualTo: true)
      .limit(6);

}