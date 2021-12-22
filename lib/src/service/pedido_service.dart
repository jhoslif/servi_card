import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servi_card/src/models/cliente_model.dart';
import 'package:servi_card/src/models/foto_model.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servi_card/src/service/cliente_service.dart';
import 'package:servi_card/src/service/foto_service.dart';

class PedidoService {
  PedidoService();

  Future<List<Pedido>> getPedido() async {
    await Firebase.initializeApp();
    List<Pedido> _pedidos = [];
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("pedido");
      QuerySnapshot pedido = await collectionReference.get();
      if (pedido.docs.isNotEmpty) {
        for (var doc in pedido.docs) {
          ClienteService _cs = ClienteService();
          FotoService _fs = FotoService();
          Pedido _p = Pedido(
              clienteid: doc.get("clienteid").toString(),
              direccion: doc.get("direccion").toString(),
              estado: doc.get("estado").toString(),
              fotoid: doc.get("fotoid").toString(),
              hdr: doc.get("hdr").toString(),
              id: doc.get("id").toString(),
              repartidorid: doc.get("repartidorid").toString(),
              tipoServicio: doc.get("tipoServicio").toString());

          Cliente _c = await _cs.getCliente(_p);
          _p.cliente = _c;
          Foto _f = await _fs.getFoto(_p);
          _p.foto = _f;
          _pedidos.add(_p);
        }
        return _pedidos;
      }
    } catch (exp) {
      // ignore: avoid_print
      print(exp);
    }
    return _pedidos;
  }
}
