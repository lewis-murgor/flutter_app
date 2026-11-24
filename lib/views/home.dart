import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/homecontroller.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/orders.dart';
import 'package:flutter_application_1/views/products.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:get/get.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

HomeController homeController = Get.put(HomeController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Same order as the tabs below.
  static const _pages = <Widget>[
    DashboardPage(),
    ProductsPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: homeController.selectedIndex.value,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Obx(() {
        return MoltenBottomNavigationBar(
          selectedIndex: homeController.selectedIndex.value,
          onTabChange: (clickedIndex) {
            homeController.setSelected(clickedIndex);
          },
          barColor: primaryColor,
          domeCircleColor: Colors.white,
          tabs: [
            MoltenTab(
              icon: const Icon(Icons.dashboard),
              selectedColor: primaryColor,
              unselectedColor: Colors.white,
            ),
            MoltenTab(
              icon: const Icon(Icons.category),
              selectedColor: primaryColor,
              unselectedColor: Colors.white,
            ),
            MoltenTab(
              icon: const Icon(Icons.list),
              selectedColor: primaryColor,
              unselectedColor: Colors.white,
            ),
            MoltenTab(
              icon: const Icon(Icons.person),
              selectedColor: primaryColor,
              unselectedColor: Colors.white,
            ),
          ],
        );
      }),
    );
  }
}
