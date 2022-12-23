
import 'dart:convert';

class ServerResponse {
    ServerResponse({
        required this.mensaje,
        required this.ok,
    });

    final String mensaje;
    final bool ok;

    factory ServerResponse.fromJson(String str) => ServerResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ServerResponse.fromMap(Map<String, dynamic> json) => ServerResponse(
        mensaje: json["mensaje"],
        ok: json["ok"],
    );

    Map<String, dynamic> toMap() => {
        "mensaje": mensaje,
        "ok": ok,
    };
}
