import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/home/home_controller.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          body: _.paginaAtual,
          bottomNavigationBar: GetBuilder<HomeController>(
            builder: (_) {
              return BottomNavigationBar(
                currentIndex: _.indexBottomNavigation,
                onTap: (int index) {
                  _.setIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Lista'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Conta'),
                ],
              );
            },
          ),
        );
      },
    ));
  }
}
