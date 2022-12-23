
import 'dart:convert';

class ProductoResponse {
    ProductoResponse({
        required this.productos,
    });

    final List<Producto> productos;

    factory ProductoResponse.fromJson(String str) => ProductoResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductoResponse.fromMap(Map<String, dynamic> json) => ProductoResponse(
        productos: List<Producto>.from(json["productos"].map((x) => Producto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
    };
}

class Producto {
    Producto({
        required this.id,
        required this.disponible,
        required this.nombre,
        required this.precio,
        required this.productoFotos,
    });

    final int id;
    final bool disponible;
    final String nombre;
    final double precio;
    final List<String> productoFotos;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

     String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        disponible: json["disponible"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
        productoFotos: List<String>.from(json["productoFotos"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "disponible": disponible,
        "nombre": nombre,
        "precio": precio,
        "productoFotos": List<dynamic>.from(productoFotos.map((x) => x)),
    };

    @override
  String toString() {
    // TODO: implement toString
    return "Nombre: $nombre, Precio $precio, Disponible? $disponible";
  }
}
