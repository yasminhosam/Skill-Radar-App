import 'package:flutter/material.dart';

class ApiErrorModel {
  final bool ok;
  final String errors;

  ApiErrorModel({required this.ok , required this.errors});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      ok: json['ok'] ?? false,
      errors: json['errors']?.toString() ?? 'Unexpected Error',
    );
  }


}