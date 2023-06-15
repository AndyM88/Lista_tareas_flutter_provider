import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/tarea_controller.dart';
import '../Models/tarea_model.dart';

class VistaLista extends StatelessWidget {
  const VistaLista({
    Key? key,
    required this.tareas,
  }) : super(key: key);

  final List<TareaModel> tareas;

  @override
  Widget build(BuildContext context) {
    final tareaController = Provider.of<TareaController>(context);
    return ListView.builder(
      key: const PageStorageKey('VistaLista'),
      itemCount: tareas.length,
      itemBuilder: (context, index) {
        final tarea = tareas[index];

        return ListTile(
          title: Text(tarea.nombre),
          subtitle: Text(tarea.descripcion),
          leading: CircleAvatar(
            backgroundColor: tarea.color,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              tareaController.removeTarea(tarea);
            },
          ),
        );
      },
    );
  }
}
