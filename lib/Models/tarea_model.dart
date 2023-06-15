import 'package:flutter/cupertino.dart';

class TareaModel {
  String nombre;
  String descripcion;
  Color color;

  TareaModel(
      {required this.nombre, required this.descripcion, required this.color});

  //getters y setters
  String get getNombre => nombre;
  String get getDescripcion => descripcion;
  Color get getColor => color;

  set setNombre(String nombre) => this.nombre = nombre;
  set setDescripcion(String descripcion) => this.descripcion = descripcion;
  set setColor(Color color) => this.color = color;
}
