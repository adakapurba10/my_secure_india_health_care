import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getProducts(String locationKey) async {
    final snapshot = await _db
        .collection('products')
        .where('locationKey', isEqualTo: locationKey)
        .limit(50)
        .get();
    return snapshot.docs.map((d) => d.data()).toList();
  }
}
