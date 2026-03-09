import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static const users = 'users';
  static const routes = 'routes';
  static const reviews = 'reviews';
  static const safetyReports = 'safetyReports';
  static const verifications = 'verifications';
  static const notifications = 'notifications';
  static const bookmarks = 'bookmarks';
}

class FirestoreDate {
  static DateTime fromDynamic(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  static Timestamp toTimestamp(DateTime value) => Timestamp.fromDate(value);
}

class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    this.preferences = const <String, dynamic>{},
  });

  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> preferences;

  factory AppUser.fromMap(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: (data['name'] as String?) ?? '',
      email: (data['email'] as String?) ?? '',
      photoUrl: data['photoUrl'] as String?,
      createdAt: FirestoreDate.fromDynamic(data['createdAt']),
      updatedAt: FirestoreDate.fromDynamic(data['updatedAt']),
      preferences:
          (data['preferences'] as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': FirestoreDate.toTimestamp(createdAt),
      'updatedAt': FirestoreDate.toTimestamp(updatedAt),
      'preferences': preferences,
    };
  }
}

class SafeRouteModel {
  SafeRouteModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.city,
    required this.distanceKm,
    required this.path,
    required this.avgRating,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final String createdBy;
  final String city;
  final double distanceKm;
  final List<GeoPoint> path;
  final double avgRating;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory SafeRouteModel.fromMap(String id, Map<String, dynamic> data) {
    final rawPath = (data['path'] as List<dynamic>? ?? <dynamic>[])
        .whereType<GeoPoint>()
        .toList();

    return SafeRouteModel(
      id: id,
      name: (data['name'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      createdBy: (data['createdBy'] as String?) ?? '',
      city: (data['city'] as String?) ?? '',
      distanceKm: ((data['distanceKm'] as num?) ?? 0).toDouble(),
      path: rawPath,
      avgRating: ((data['avgRating'] as num?) ?? 0).toDouble(),
      isVerified: (data['isVerified'] as bool?) ?? false,
      createdAt: FirestoreDate.fromDynamic(data['createdAt']),
      updatedAt: FirestoreDate.fromDynamic(data['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'city': city,
      'distanceKm': distanceKm,
      'path': path,
      'avgRating': avgRating,
      'isVerified': isVerified,
      'createdAt': FirestoreDate.toTimestamp(createdAt),
      'updatedAt': FirestoreDate.toTimestamp(updatedAt),
    };
  }
}

class RouteReview {
  RouteReview({
    required this.id,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  factory RouteReview.fromMap(String id, Map<String, dynamic> data) {
    return RouteReview(
      id: id,
      userId: (data['userId'] as String?) ?? '',
      rating: ((data['rating'] as num?) ?? 0).toInt(),
      comment: (data['comment'] as String?) ?? '',
      createdAt: FirestoreDate.fromDynamic(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': FirestoreDate.toTimestamp(createdAt),
    };
  }
}

class SafetyReport {
  SafetyReport({
    required this.id,
    required this.userId,
    required this.type,
    required this.description,
    required this.location,
    required this.reportedAt,
    required this.upvotes,
    required this.downvotes,
  });

  final String id;
  final String userId;
  final String type;
  final String description;
  final GeoPoint location;
  final DateTime reportedAt;
  final int upvotes;
  final int downvotes;

  factory SafetyReport.fromMap(String id, Map<String, dynamic> data) {
    return SafetyReport(
      id: id,
      userId: (data['userId'] as String?) ?? '',
      type: (data['type'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      location: (data['location'] as GeoPoint?) ?? const GeoPoint(0, 0),
      reportedAt: FirestoreDate.fromDynamic(data['reportedAt']),
      upvotes: ((data['upvotes'] as num?) ?? 0).toInt(),
      downvotes: ((data['downvotes'] as num?) ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'type': type,
      'description': description,
      'location': location,
      'reportedAt': FirestoreDate.toTimestamp(reportedAt),
      'upvotes': upvotes,
      'downvotes': downvotes,
    };
  }
}

class RouteVerification {
  RouteVerification({
    required this.id,
    required this.userId,
    required this.verifiedAt,
  });

  final String id;
  final String userId;
  final DateTime verifiedAt;

  factory RouteVerification.fromMap(String id, Map<String, dynamic> data) {
    return RouteVerification(
      id: id,
      userId: (data['userId'] as String?) ?? '',
      verifiedAt: FirestoreDate.fromDynamic(data['verifiedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'verifiedAt': FirestoreDate.toTimestamp(verifiedAt),
    };
  }
}

class UserBookmark {
  UserBookmark({required this.routeId, required this.savedAt});

  final String routeId;
  final DateTime savedAt;

  factory UserBookmark.fromMap(Map<String, dynamic> data) {
    return UserBookmark(
      routeId: (data['routeId'] as String?) ?? '',
      savedAt: FirestoreDate.fromDynamic(data['savedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'routeId': routeId,
      'savedAt': FirestoreDate.toTimestamp(savedAt),
    };
  }
}

class AppNotification {
  AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
  });

  final String id;
  final String userId;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;

  factory AppNotification.fromMap(String id, Map<String, dynamic> data) {
    return AppNotification(
      id: id,
      userId: (data['userId'] as String?) ?? '',
      title: (data['title'] as String?) ?? '',
      body: (data['body'] as String?) ?? '',
      createdAt: FirestoreDate.fromDynamic(data['createdAt']),
      isRead: (data['isRead'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'title': title,
      'body': body,
      'createdAt': FirestoreDate.toTimestamp(createdAt),
      'isRead': isRead,
    };
  }
}
