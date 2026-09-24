import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? targetRole;
  final List<String> skills;
  final String? experienceLevel;
  final String? githubUsername;
  final String? cvText;
  final DateTime? lastAnalysisAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.targetRole,
    this.skills = const [],
    this.experienceLevel,
    this.githubUsername,
    this.cvText,
    this.lastAnalysisAt,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> json, String uid) {
    return UserModel(
      uid: uid,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      targetRole: json['targetRole'],
      skills: List<String>.from(json['skills'] ?? []),
      experienceLevel: json['experienceLevel'],
      githubUsername: json['githubUsername'],
      cvText: json['cvText'],
      lastAnalysisAt: json['lastAnalysisAt'] != null
          ? (json['lastAnalysisAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'targetRole': targetRole,
      'skills': skills,
      'experienceLevel': experienceLevel,
      'githubUsername': githubUsername,
      'cvText': cvText,
      'lastAnalysisAt': lastAnalysisAt,
    };
  }
}