import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Favourite extends HookConsumerWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: Text("Favourite Page"),
      ),
    );
  }
}
