import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/services/firestore_service.dart';
import 'package:flutter_app/data/models/favourite_model.dart';
import 'package:flutter_app/data/models/order_model.dart';

/// Reads the signed-in user's Favourites and Orders through the
/// FirestoreService Singleton, as live streams.
class UserCollectionsDataSource {
  final FirebaseAuth _auth;
  final FirestoreService _firestore;

  UserCollectionsDataSource(this._auth, this._firestore);

  Stream<T> _forUser<T>(Stream<T> Function(String uid) build) {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.error(StateError('No signed-in user'));
    }
    return build(user.uid);
  }

  Stream<List<FavouriteModel>> watchFavourites() {
    return _forUser(
      (uid) => _firestore
          .watchCollection('users/$uid/favourites')
          .map((docs) => docs.map(FavouriteModel.fromJson).toList()),
    );
  }

  Stream<List<OrderModel>> watchOrders() {
    return _forUser(
      (uid) => _firestore
          .watchCollection(
            'users/$uid/orders',
            orderBy: 'createdAt',
            descending: true,
          )
          .map((docs) => docs.map(OrderModel.fromJson).toList()),
    );
  }
}