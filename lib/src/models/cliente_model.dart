import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    Cliente({
        this.nombre,
        this.cedula,
        this.telefono,
        this.idCliente,
    });

    String ?nombre;
    String ?cedula;
    String ?telefono;
    String ?idCliente;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        cedula: json["cedula"],
        telefono: json["telefono"],
        idCliente: json["id_cliente"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cedula": cedula,
        "telefono": telefono,
        "id_cliente": idCliente,
    };
}
