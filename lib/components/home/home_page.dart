import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/home/home_controller.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<HomeController>(
      builder: (_) {
        return Stack(
          children: [
            Scaffold(
              body: _.paginaAtual,
              bottomNavigationBar: GetBuilder<HomeController>(
                builder: (_) {
                  return BottomNavigationBar(
                    currentIndex: _.indexBottomNavigation,
                    onTap: (int index) {
                      _.setIndex(index);
                    },
                    items: [
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.list), label: 'Lista'),
                      BottomNavigationBarItem(
                          icon: Stack(
                            children: [
                              const Icon(Icons.person),
                              Positioned(
                                bottom: 14,
                                right: 0,
                                child: GetX<HomeController>(builder: (_) {
                                  if (_.preencheuPerfil) {
                                    return Container();
                                  } else {
                                    return Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                    );
                                  }
                                }),
                              )
                            ],
                          ),
                          label: 'Conta'),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    ));
  }
}
