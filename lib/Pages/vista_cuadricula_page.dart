import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/tarea_controller.dart';
import '../Models/tarea_model.dart';

class VistaCuadricula extends StatelessWidget {
  const VistaCuadricula({
    Key? key,
    required this.tareas,
  }) : super(key: key);

  final List<TareaModel> tareas;

  @override
  Widget build(BuildContext context) {
    final tareaController = Provider.of<TareaController>(context);
    return LayoutBuilder(
      key: const PageStorageKey('VistaCuadricula'),
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 600 ? 3 : 2;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.0,
          ),
          itemCount: tareas.length,
          itemBuilder: (context, index) {
            final tarea = tareas[index];
            return GestureDetector(
              onTap: null,
              child: Card(
                color: tarea.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      tarea.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(tarea.descripcion),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            tareaController.removeTarea(tarea);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
