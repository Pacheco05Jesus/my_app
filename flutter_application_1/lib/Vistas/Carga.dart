import 'package:flutter/material.dart';

class TransparentLoadingView extends StatelessWidget {
  const TransparentLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        // Fondo transparente
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: ColoredBox(color: Colors.transparent),
          ),
        ),
        // Indicador de carga centrado
        Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(
              255,
              83,
              241,
              4,
            ), // o cualquier color que se ajuste
          ),
        ),
      ],
    );
  }
}
