import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class SelecionarEstado extends StatelessWidget {
  const SelecionarEstado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Estado'),
      ),
      body: ListView.builder(
        itemCount: ESTADOS.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ESTADOS[index]['nome']!),
            onTap: () {
              Get.back(result: ESTADOS[index]);
            },
          );
        },
      ),
    );
  }
}
