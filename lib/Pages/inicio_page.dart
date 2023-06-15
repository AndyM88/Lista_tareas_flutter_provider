import 'package:flutter/material.dart';
import 'package:lista_tareas/Models/tarea_model.dart';
import 'package:provider/provider.dart';
import '../Controllers/tarea_controller.dart';

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
                onPressed: () {},
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
