import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_schema.dart';

class SafeRouteFirestore {
  SafeRouteFirestore({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get users =>
      _firestore.collection(FirestoreCollections.users);

  CollectionReference<Map<String, dynamic>> get routes =>
      _firestore.collection(FirestoreCollections.routes);

  CollectionReference<Map<String, dynamic>> get notifications =>
      _firestore.collection(FirestoreCollections.notifications);

  DocumentReference<Map<String, dynamic>> userDoc(String userId) =>
      users.doc(userId);

  CollectionReference<Map<String, dynamic>> userBookmarks(String userId) =>
      userDoc(userId).collection(FirestoreCollections.bookmarks);

  DocumentReference<Map<String, dynamic>> routeDoc(String routeId) =>
      routes.doc(routeId);

  CollectionReference<Map<String, dynamic>> routeReviews(String routeId) =>
      routeDoc(routeId).collection(FirestoreCollections.reviews);

  CollectionReference<Map<String, dynamic>> routeSafetyReports(
    String routeId,
  ) => routeDoc(routeId).collection(FirestoreCollections.safetyReports);

  CollectionReference<Map<String, dynamic>> routeVerifications(
    String routeId,
  ) => routeDoc(routeId).collection(FirestoreCollections.verifications);

  Query<Map<String, dynamic>> notificationsForUser(String userId) =>
      notifications.where('userId', isEqualTo: userId);
}
