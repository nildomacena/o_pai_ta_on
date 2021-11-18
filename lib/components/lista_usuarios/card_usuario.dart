import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/lista_usuarios/lista_usuarios_controller.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class CardUsuario extends StatelessWidget {
  ListaUsuariosController controller = Get.find();
  final Usuario usuario;
  TextStyle style = const TextStyle(fontSize: 18);
  CardUsuario(this.usuario, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    usuario.id!,
                    style: style,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: TextButton(
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'COPIAR',
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        controller.copiar(usuario.id!);
                      },
                    ),
                  )
                ],
              ),
              Text(
                usuario.nome!,
                style: style,
              ),
              Text(
                'K/D: ${usuario.kd!}',
                style: style,
              ),
              if (usuario.modo != null)
                Text(
                  'Modo preferido: ${usuario.modo!.nome}',
                  style: style,
                ),
              Text(
                (usuario.forma! == 'rush'
                    ? 'Joga rushando'
                    : usuario.forma! == 'mix'
                        ? 'Joga de boa'
                        : 'Joga bem safe'),
                style: style,
              ),
              if (usuario.estado != null && usuario.estado != '')
                Text(
                  'De ${UtilService().estadoSiglaNome(usuario.estado!)}',
                  style: style,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
