import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Comenzar desde la esquina superior izquierda
    path.moveTo(0, 0);
    
    // Ir hasta la esquina superior derecha
    path.lineTo(size.width, 0);
    
    // Ir hasta la esquina inferior derecha
    path.lineTo(size.width, size.height);
    
    // Crear la curva cóncava en la parte inferior
    // Esta curva se "hunde" hacia arriba en el centro
    path.quadraticBezierTo(
      size.width * 0.5, // Punto de control X en el centro horizontal
      size.height * 0.88, // Punto de control Y hacia arriba para crear la curva cóncava hacia arriba
      0, // Punto final X en la esquina inferior izquierda
      size.height, // Punto final Y en la esquina inferior izquierda
    );
    
    // Cerrar el path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
