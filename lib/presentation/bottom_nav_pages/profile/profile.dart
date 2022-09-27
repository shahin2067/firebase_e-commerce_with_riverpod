import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/auth/login_screen.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_pages/profile/widgets/eidt_profile.dart';
import 'package:e_commerce_app_with_firebase_riverpod/style/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0.h),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user-data")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${data['name']}')
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      const Text(
                        "Gender: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${data['gender']}')
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      const Text(
                        "Date of birth: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${data['dateOfBirth']}')
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      const Text(
                        "Age: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${data['age']}')
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      const Text(
                        "Phone No: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${data['phone']}')
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const EditProfile());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deep_orange,
                            elevation: 3,
                          ),
                          child: const Icon(Icons.edit)),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deep_orange,
                            elevation: 3,
                          ),
                          child: const Icon(Icons.logout)),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
