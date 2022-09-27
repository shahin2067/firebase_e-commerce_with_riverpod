import 'package:e_commerce_app_with_firebase_riverpod/application/app/user/user_provider.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/auth/auth_provider.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_cotroller.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/widgets/my_text_field.dart';
import 'package:e_commerce_app_with_firebase_riverpod/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserForm extends HookConsumerWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final dobController = useTextEditingController();
    final genderController = useTextEditingController();
    final ageController = useTextEditingController();
    List<String> gender = ["Male", "Female", "Other"];
    final loading = ref.watch(userProvider.select((value) => value.loading));

    Future<void> _selectDateFromPicker(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 30),
        lastDate: DateTime(DateTime.now().year),
      );
      if (picked != null) {
        dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      }
      // setState(() {
      //   _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      // });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                      TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                myTextField(
                    "enter your name", TextInputType.text, nameController),
                myTextField("enter your phone number", TextInputType.number,
                    phoneController),
                TextField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                TextField(
                  controller: genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            genderController.text = value;
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                myTextField(
                    "enter your age", TextInputType.number, ageController),

                SizedBox(
                  height: 50.h,
                ),

                SizedBox(
                  width: 1.sw,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final userData = UserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          dateOfBirth: dobController.text,
                          age: ageController.text,
                          gender: genderController.text);
                      ref
                          .read(userProvider.notifier)
                          .collectUserData(userData: userData);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavController()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deep_orange,
                      elevation: 3,
                    ),
                    child: loading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Text(
                            "Done",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                  ),
                ),

                // elevated button
                // customButton("Continue", () => sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
