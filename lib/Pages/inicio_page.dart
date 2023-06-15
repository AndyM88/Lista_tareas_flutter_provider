import 'package:flutter/material.dart';
import 'package:lista_tareas/Models/tarea_model.dart';
import 'package:lista_tareas/Pages/vista_cuadricula_page.dart';
import 'package:lista_tareas/Pages/vista_lista_page.dart';
import 'package:provider/provider.dart';
import '../Controllers/tarea_controller.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class InicioPage extends StatelessWidget {
  InicioPage({Key? key}) : super(key: key);
  final TextEditingController controllerBusqueda = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tareaController = Provider.of<TareaController>(context);
    final tareas = tareaController.tareas;

    return Column(
      key: const PageStorageKey('InicioPage'),
      children: [
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controllerBusqueda,
                  onChanged: (value) {
                    tareaController.buscadorTarea(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar tareas por nombre',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      tooltip: 'Limpiar búsqueda',
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controllerBusqueda.clear();
                        tareaController.buscadorTarea('');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Tareas',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Flexible(
              child: IconButton(
                tooltip: 'Agregar tarea',
                onPressed: () {
                  //mostrar dialogo
                  showDialog(
                    context: context,
                    builder: (context) {
                      final nombreController = TextEditingController();
                      final descripcionController = TextEditingController();
                      final colorController = TextEditingController();
                      return AlertDialog(
                        title: const Text('Agregar tarea'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nombreController,
                              decoration: const InputDecoration(
                                hintText: 'Nombre',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: descripcionController,
                              decoration: const InputDecoration(
                                hintText: 'Descripción',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            //Usar el color picker
                            TextField(
                              controller: colorController,
                              decoration: const InputDecoration(
                                hintText: 'Color',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Color'),
                                      content: SingleChildScrollView(
                                        child: BlockPicker(
                                          pickerColor: Colors.white,
                                          onColorChanged: (color) {
                                            colorController.text =
                                                color.value.toString();
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Aceptar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              tareaController.tareas = [
                                ...tareaController.tareas,
                                TareaModel(
                                  nombre: nombreController.text,
                                  descripcion: descripcionController.text,
                                  color: Color(int.parse(colorController.text)),
                                ),
                              ];
                              Navigator.pop(context);
                            },
                            child: const Text('Agregar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        if (tareaController.vista == 'Modo cuadrícula')
          Expanded(child: VistaLista(tareas: tareas))
        else
          Expanded(child: VistaCuadricula(tareas: tareas)),
      ],
    );
  }
}
