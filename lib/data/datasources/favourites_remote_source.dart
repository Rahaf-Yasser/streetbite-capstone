import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/domain/entities/meal.dart';

class FavouritesRemoteSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>>? _doc(String mealId) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null; // not signed in
    return _db
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .doc(mealId);
  }

  /// Emits true/false live, so the heart updates by itself.
  Stream<bool> isFavourite(String mealId) {
    final doc = _doc(mealId);
    if (doc == null) return Stream.value(false);
    return doc.snapshots().map((snap) => snap.exists);
  }

  Future<void> add(Meal meal) async {
    final doc = _doc(meal.id.toString());
    if (doc == null) throw StateError('No signed-in user');
    await doc.set({
      'id': meal.id.toString(),
      'name': meal.name,
      'thumbnail': meal.thumbnail,
      'category': meal.category,
      'area': meal.area,
      'price': meal.price,
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> remove(String mealId) async {
    final doc = _doc(mealId);
    if (doc == null) throw StateError('No signed-in user');
    await doc.delete();
  }
}