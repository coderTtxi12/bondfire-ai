import 'package:flutter/material.dart';

class FloatingIconModel {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double size;
  final Offset position;
  final Duration animationDuration;
  final double rotation;

  const FloatingIconModel({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.size,
    required this.position,
    this.animationDuration = const Duration(seconds: 3),
    this.rotation = 0.0,
  });

  FloatingIconModel copyWith({
    IconData? icon,
    Color? color,
    Color? backgroundColor,
    double? size,
    Offset? position,
    Duration? animationDuration,
    double? rotation,
  }) {
    return FloatingIconModel(
      icon: icon ?? this.icon,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      size: size ?? this.size,
      position: position ?? this.position,
      animationDuration: animationDuration ?? this.animationDuration,
      rotation: rotation ?? this.rotation,
    );
  }
}
