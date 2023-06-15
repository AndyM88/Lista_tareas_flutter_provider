import 'package:flutter/cupertino.dart';
import '../Models/tarea_model.dart';

class TareaController with ChangeNotifier {
  List<TareaModel> _tareas = [];
  List<TareaModel> _tareasOriginales = [];
  List<TareaModel> get tareas => _tareas;
  List<TareaModel> get tareasOriginales => _tareasOriginales;
  String _vista = 'Modo lista';

  void buscadorTarea(String buscador) {
    if (buscador.isEmpty) {
      _tareas = _tareasOriginales;
    } else {
      _tareas = _tareasOriginales;
      _tareas = _tareas
          .where((element) =>
              element.nombre.toLowerCase().contains(buscador.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  set tareas(List<TareaModel> tareas) {
    _tareas = tareas;
    _tareasOriginales = tareas;
    notifyListeners();
  }

  set tareasOriginales(List<TareaModel> tareas) {
    _tareasOriginales = tareas;
    notifyListeners();
  }

  String get vista => _vista;

  set vista(String vista) {
    _vista = vista;
    notifyListeners();
  }

  //datos de prueba
  TareaController() {
    _tareas = [
      TareaModel(
          nombre: 'Tarea 1',
          descripcion: 'Descripción de la tarea 1',
          color: const Color(0xffFF0000)),
      TareaModel(
          nombre: 'Tarea 2',
          descripcion: 'Descripción de la tarea 2',
          color: const Color(0xff00FF00)),
      TareaModel(
          nombre: 'Tarea 3',
          descripcion: 'Descripción de la tarea 3',
          color: const Color(0xff0000FF)),
      TareaModel(
          nombre: 'Tarea 4',
          descripcion: 'Descripción de la tarea 4',
          color: const Color(0xffFFFF00)),
      TareaModel(
          nombre: 'Tarea 5',
          descripcion: 'Descripción de la tarea 5',
          color: const Color(0xff00FFFF)),
      TareaModel(
          nombre: 'Tarea 6',
          descripcion: 'Descripción de la tarea 6',
          color: const Color(0xffFF00FF)),
      //agrégale más datos de prueba
      TareaModel(
          nombre: 'Tarea 7',
          descripcion: 'Descripción de la tarea 7',
          color: const Color(0xffFF0000)),
      TareaModel(
          nombre: 'Tarea 8',
          descripcion: 'Descripción de la tarea 8',
          color: const Color(0xff00FF00)),
    ];
    _tareasOriginales = _tareas;
  }

  void addTarea(TareaModel tarea) {
    _tareas.add(tarea);
    _tareasOriginales.add(tarea);
    notifyListeners();
  }

  void removeTarea(TareaModel tarea) {
    _tareas.remove(tarea);
    _tareasOriginales.remove(tarea);
    notifyListeners();
  }

  void updateTarea(TareaModel tarea) {
    _tareas[_tareas.indexWhere((element) => element.nombre == tarea.nombre)] =
        tarea;
    _tareasOriginales[_tareasOriginales
        .indexWhere((element) => element.nombre == tarea.nombre)] = tarea;
    notifyListeners();
  }

  void cambiarVista() {
    if (_vista == 'Modo cuadrícula') {
      _vista = 'Modo lista';
    } else {
      _vista = 'Modo cuadrícula';
    }
    notifyListeners();
  }
}
