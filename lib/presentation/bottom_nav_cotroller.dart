import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_pages/favourite.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_pages/home.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_pages/profile/profile.dart';
import 'package:e_commerce_app_with_firebase_riverpod/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavController extends HookConsumerWidget {
  const BottomNavController({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pages = [
      const Home(),
      const Favourite(),
      const Cart(),
      const Profile(),
    ];
    final currentIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex.value,
        selectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Cart",
            // title: Text("Cart"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          currentIndex.value = index;
          // setState(() {
          //   _currentIndex = index;
          //   print(_currentIndex);
          // });
        },
      ),
      body: pages[currentIndex.value],
    );
  }
}
