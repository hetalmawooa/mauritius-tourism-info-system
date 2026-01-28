import 'package:flutter/material.dart';

class EmergencyContact {
  final String id;
  final String name;
  final String phone;
  final IconData icon;
  final Color color;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.icon,
    required this.color,
  });
}