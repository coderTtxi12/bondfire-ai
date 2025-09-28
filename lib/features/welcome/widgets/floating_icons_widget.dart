import 'package:flutter/material.dart';
import '../models/floating_icon_model.dart';

class FloatingIconsWidget extends StatefulWidget {
  final List<FloatingIconModel> icons;

  const FloatingIconsWidget({
    super.key,
    required this.icons,
  });

  @override
  State<FloatingIconsWidget> createState() => _FloatingIconsWidgetState();
}

class _FloatingIconsWidgetState extends State<FloatingIconsWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = [];
    _animations = [];

    // Verificar que la lista de iconos no esté vacía
    if (widget.icons.isEmpty) return;

    for (int i = 0; i < widget.icons.length; i++) {
      final controller = AnimationController(
        duration: widget.icons[i].animationDuration,
        vsync: this,
      );

      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ));

      _controllers.add(controller);
      _animations.add(animation);

      // Agregar delay escalonado para cada icono
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si no hay iconos, retornar un contenedor vacío
    if (widget.icons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: widget.icons.asMap().entries.map((entry) {
        final index = entry.key;
        final iconModel = entry.value;

        return AnimatedBuilder(
          animation: _animations.isNotEmpty ? _animations[index] : const AlwaysStoppedAnimation(1.0),
          builder: (context, child) {
            return Positioned(
              left: MediaQuery.of(context).size.width * iconModel.position.dx,
              top: MediaQuery.of(context).size.height * iconModel.position.dy,
              child: Transform.scale(
                scale: _animations.isNotEmpty ? _animations[index].value : 1.0,
                child: Transform.rotate(
                  angle: iconModel.rotation,
                  child: _buildFloatingIcon(iconModel),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFloatingIcon(FloatingIconModel iconModel) {
    if (iconModel.backgroundColor == Colors.transparent) {
      // Icono sin fondo
      return Icon(
        iconModel.icon,
        size: iconModel.size,
        color: iconModel.color,
      );
    }

    // Icono con fondo circular
    return Container(
      width: iconModel.size + 16,
      height: iconModel.size + 16,
      decoration: BoxDecoration(
        color: iconModel.backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: iconModel.backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        iconModel.icon,
        size: iconModel.size * 0.6,
        color: iconModel.color,
      ),
    );
  }
}
