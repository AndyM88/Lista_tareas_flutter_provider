import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lista_tareas/Pages/inicio_page.dart';
import 'Controllers/tarea_controller.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Agrega aquí los proveedores necesarios
        ChangeNotifierProvider<TareaController>(
          create: (_) => TareaController(),
        ),
        // Otros proveedores aquí si es necesario
      ],
      child: MaterialApp(
        title: 'Lista de tareas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            key: const PageStorageKey('MainPage'),
            appBar: AppBar(
              title: const Text('App de tareas'),
              centerTitle: true,
              actions: [
                Consumer<TareaController>(
                  builder: (context, tareaController, _) => IconButton(
                    padding: const EdgeInsets.only(right: 20.0),
                    icon: PopupMenuButton<String>(
                      tooltip: 'Configuraciones',
                      icon: const Icon(Icons.settings),
                      onSelected: (String result) {
                        tareaController.cambiarVista();
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'opcion1',
                          child: Text(tareaController.vista),
                        ),
                      ],
                    ),
                    onPressed: null,
                  ),
                ),
              ],
            ),
            body: InicioPage()),
        routes: {
          '/Inicio': (context) => InicioPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
