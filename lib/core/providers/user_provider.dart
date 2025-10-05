import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Badge;

import '../models/user_models.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserProfile? _userProfile;
  List<Badge> _badges = [];
  List<Achievement> _achievements = [];
  bool _isLoading = false;

  UserProfile? get userProfile => _userProfile;
  List<Badge> get badges => _badges;
  List<Achievement> get achievements => _achievements;
  bool get isLoading => _isLoading;

  Future<void> loadUserProfile() async {
    if (_auth.currentUser == null) return;

    _setLoading(true);
    
    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        _userProfile = UserProfile(
          uid: data['uid'],
          email: data['email'],
          displayName: data['displayName'],
          photoURL: data['photoURL'],
          totalXP: data['totalXP'] ?? 0,
          level: data['level'] ?? 1,
          badges: List<String>.from(data['badges'] ?? []),
          streak: data['streak'] ?? 0,
          lastActive: data['lastActive']?.toDate(),
          createdAt: data['createdAt']?.toDate(),
        );

        await _loadBadges();
        await _loadAchievements();
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
    
    _setLoading(false);
  }

  Future<void> _loadBadges() async {
    // Sample badges - in production, load from Firestore
    _badges = [
      Badge(
        id: '1',
        name: 'First Steps',
        description: 'Complete your first quiz',
        iconUrl: 'assets/icons/badges/first_steps.png',
        isUnlocked: _userProfile?.badges.contains('1') ?? false,
      ),
      Badge(
        id: '2',
        name: 'Quiz Master',
        description: 'Answer 10 questions correctly',
        iconUrl: 'assets/icons/badges/quiz_master.png',
        isUnlocked: _userProfile?.badges.contains('2') ?? false,
      ),
      Badge(
        id: '3',
        name: 'Healthy Eater',
        description: 'Sort 20 healthy foods correctly',
        iconUrl: 'assets/icons/badges/healthy_eater.png',
        isUnlocked: _userProfile?.badges.contains('3') ?? false,
      ),
    ];
  }

  Future<void> _loadAchievements() async {
    // Sample achievements
    _achievements = [
      Achievement(
        id: '1',
        name: 'Nutrition Novice',
        description: 'Reach level 5',
        iconUrl: 'assets/icons/achievements/nutrition_novice.png',
        isUnlocked: (_userProfile?.level ?? 0) >= 5,
        progress: ((_userProfile?.level ?? 0) / 5).clamp(0.0, 1.0),
      ),
      Achievement(
        id: '2',
        name: 'Streak Keeper',
        description: 'Maintain a 7-day streak',
        iconUrl: 'assets/icons/achievements/streak_keeper.png',
        isUnlocked: (_userProfile?.streak ?? 0) >= 7,
        progress: ((_userProfile?.streak ?? 0) / 7).clamp(0.0, 1.0),
      ),
    ];
  }

  Future<void> updateUserLevel() async {
    if (_userProfile == null) return;

    final newLevel = (_userProfile!.totalXP / 100).floor() + 1;
    if (newLevel > _userProfile!.level) {
      _userProfile = _userProfile!.copyWith(level: newLevel);
      
      // Update in Firestore
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'level': newLevel,
      });
      
      notifyListeners();
    }
  }

  Future<void> unlockBadge(String badgeId) async {
    if (_userProfile == null) return;

    final updatedBadges = List<String>.from(_userProfile!.badges);
    if (!updatedBadges.contains(badgeId)) {
      updatedBadges.add(badgeId);
      
      _userProfile = _userProfile!.copyWith(badges: updatedBadges);
      
      // Update in Firestore
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'badges': updatedBadges,
      });
      
      // Update local badges
      final badgeIndex = _badges.indexWhere((b) => b.id == badgeId);
      if (badgeIndex != -1) {
        _badges[badgeIndex] = _badges[badgeIndex].copyWith(isUnlocked: true);
      }
      
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
