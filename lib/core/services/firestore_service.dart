import 'package:cloud_firestore/cloud_firestore.dart';

/// SINGLETON PATTERN
/// there is only one for the entire app lifecycle.
class FirestoreService {
  FirestoreService._internal(this._db);

  static final FirestoreService _instance =
      FirestoreService._internal(FirebaseFirestore.instance);
  factory FirestoreService() => _instance;
  final FirebaseFirestore _db;

  Future<void> setDocument(
    String path,
    Map<String, dynamic> data, {
    bool merge = true,
  }) =>
      _db.doc(path).set(data, SetOptions(merge: merge));

  Future<Map<String, dynamic>?> getDocument(String path) async {
    final snapshot = await _db.doc(path).get();
    return snapshot.data();
  }

  Stream<Map<String, dynamic>?> watchDocument(String path) =>
      _db.doc(path).snapshots().map((snapshot) => snapshot.data());

  Stream<List<Map<String, dynamic>>> watchCollection(
    String path, {
    String? orderBy,
    bool descending = false,
  }) {
    Query<Map<String, dynamic>> query = _db.collection(path);
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => {...doc.data(), 'id': doc.id})
              .toList(),
        );
  }
}