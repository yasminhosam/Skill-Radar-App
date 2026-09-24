import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_projects/features/profile/data/models/user_model.dart';

class UserRepo {
  final FirebaseFirestore _firestore;

  UserRepo(this._firestore);
  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<void> createUser(UserModel user) async{
    debugPrint('UserRepo: createUser attempting set for uid: ${user.uid}');
    try {
      await _usersCollection.doc(user.uid).set(user.toFirestore(), SetOptions(merge: true));
      debugPrint('UserRepo: createUser success for uid: ${user.uid}');
    } catch (e) {
      debugPrint('UserRepo: createUser error: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUser(String uid) async{
    final doc= await _usersCollection.doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, uid);
  }

  Future<void> updateProfile({
    required String uid,
    String? targetRole,
    List<String>? skills,
    String? experienceLevel,
    String? githubUsername,
    String? cvText,
  }) async {
    final data = <String, dynamic>{};
    if (targetRole != null) data['targetRole'] = targetRole;
    if (skills != null) data['skills'] = skills;
    if (experienceLevel != null) data['experienceLevel'] = experienceLevel;
    if (githubUsername != null) data['githubUsername'] = githubUsername;
    if (cvText != null) data['cvText'] = cvText;

    await _usersCollection.doc(uid).set(data, SetOptions(merge: true));
  }

  Future<void> updateLastAnalysisAt(String uid, DateTime timestamp) async {
    await _usersCollection.doc(uid).update({
      'lastAnalysisAt': Timestamp.fromDate(timestamp),
    });
  }


}