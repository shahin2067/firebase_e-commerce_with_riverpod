import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Cart extends HookConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: Text("Cart Page"),
      ),
    );
  }
}
