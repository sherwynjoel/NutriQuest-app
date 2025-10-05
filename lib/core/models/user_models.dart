import 'package:cloud_firestore/cloud_firestore.dart';

// User Profile Model
class UserProfile {

  UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.totalXP, required this.level, required this.badges, required this.streak, this.photoURL,
    this.lastActive,
    this.createdAt,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return UserProfile(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoURL: data['photoURL'],
      totalXP: data['totalXP'] ?? 0,
      level: data['level'] ?? 1,
      badges: List<String>.from(data['badges'] ?? []),
      streak: data['streak'] ?? 0,
      lastActive: data['lastActive']?.toDate(),
      createdAt: data['createdAt']?.toDate(),
    );
  }
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;
  final int totalXP;
  final int level;
  final List<String> badges;
  final int streak;
  final DateTime? lastActive;
  final DateTime? createdAt;

  UserProfile copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    int? totalXP,
    int? level,
    List<String>? badges,
    int? streak,
    DateTime? lastActive,
    DateTime? createdAt,
  }) => UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      totalXP: totalXP ?? this.totalXP,
      level: level ?? this.level,
      badges: badges ?? this.badges,
      streak: streak ?? this.streak,
      lastActive: lastActive ?? this.lastActive,
      createdAt: createdAt ?? this.createdAt,
    );
}

// Badge Model
class Badge {

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.isUnlocked,
  });
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final bool isUnlocked;

  Badge copyWith({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    bool? isUnlocked,
  }) => Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
}

// Achievement Model
class Achievement {

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.isUnlocked,
    required this.progress,
  });
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final bool isUnlocked;
  final double progress;

  Achievement copyWith({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    bool? isUnlocked,
    double? progress,
  }) => Achievement(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      progress: progress ?? this.progress,
    );
}
