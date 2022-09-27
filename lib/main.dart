import 'package:e_commerce_app_with_firebase_riverpod/firebase_options.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/auth/login_screen.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/auth/user_form.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_cotroller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// b  g

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flitter Firebase E-commerce',
        home: LoginScreen(),
      ),
    );
  }
}
