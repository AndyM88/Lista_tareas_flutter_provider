import 'package:flutter/cupertino.dart';

class TareaModel {
  String nombre;
  String descripcion;
  Color color;
  int estado;

  TareaModel(
      {required this.nombre,
      required this.descripcion,
      required this.color,
      required this.estado});

  //getters y setters
  String get getNombre => nombre;
  String get getDescripcion => descripcion;
  Color get getColor => color;
  int get getEstado => estado;

  set setNombre(String nombre) => this.nombre = nombre;
  set setDescripcion(String descripcion) => this.descripcion = descripcion;
  set setColor(Color color) => this.color = color;
  set setEstado(int estado) => this.estado = estado;
}
