import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/app/user/user_provider.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/app/user/user_state.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfile extends HookConsumerWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(userProvider.notifier).getUserData();
      });
      return null;
    }, []);
    final data = ref.read(userProvider.notifier).getUserData();
    final buttonPressed = useState(false);

    var nameController = useTextEditingController();
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
    }

    ref.listen<UserState>(userProvider, (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.userData.name;
        phoneController.text = next.userData.phone;
        dobController.text = next.userData.dateOfBirth;
        genderController.text = next.userData.gender;
        ageController.text = next.userData.age;

        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          CherryToast.info(
            title: const Text('Profile Updated'),
            animationType: AnimationType.fromTop,
          ).show(context);
          buttonPressed.value = false;
        }
      }
    });

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
                keyboardType: TextInputType.text, controller: nameController),
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
            myTextField("enter your age", TextInputType.number, ageController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            final userData = UserData(
                name: nameController.text,
                phone: phoneController.text,
                dateOfBirth: dobController.text,
                age: ageController.text,
                gender: genderController.text);

            if (nameController.text.isNotEmpty &&
                phoneController.text.isNotEmpty &&
                dobController.text.isNotEmpty &&
                ageController.text.isNotEmpty &&
                genderController.text.isNotEmpty) {
              buttonPressed.value = true;
              ref
                  .read(userProvider.notifier)
                  .updateUserData(userData: userData);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );

    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection("user-data")
    //       .doc(FirebaseAuth.instance.currentUser!.email)
    //       .snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     var data = snapshot.data;
    //     if (data == null) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     return AlertDialog(
    //       insetPadding: EdgeInsets.zero,
    //       title: const Text('Edit Profile'),
    //       content: SingleChildScrollView(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             TextFormField(
    //                 keyboardType: TextInputType.text,
    //                 controller: nameController),
    //             myTextField("enter your phone number", TextInputType.number,
    //                 phoneController),
    //             TextField(
    //               controller: dobController,
    //               readOnly: true,
    //               decoration: InputDecoration(
    //                 hintText: "date of birth",
    //                 suffixIcon: IconButton(
    //                   onPressed: () => _selectDateFromPicker(context),
    //                   icon: Icon(Icons.calendar_today_outlined),
    //                 ),
    //               ),
    //             ),
    //             TextField(
    //               controller: genderController,
    //               readOnly: true,
    //               decoration: InputDecoration(
    //                 hintText: "choose your gender",
    //                 prefixIcon: DropdownButton<String>(
    //                   items: gender.map((String value) {
    //                     return DropdownMenuItem<String>(
    //                       value: value,
    //                       child: Text(value),
    //                       onTap: () {
    //                         genderController.text = value;
    //                       },
    //                     );
    //                   }).toList(),
    //                   onChanged: (_) {},
    //                 ),
    //               ),
    //             ),
    //             myTextField(
    //                 "enter your age", TextInputType.number, ageController),
    //           ],
    //         ),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text(
    //             'Cancel',
    //             style: TextStyle(color: Colors.red),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: () {},
    //           child: const Text('Save'),
    //         ),
    //       ],
    //     );
    //   },
    //   //child:
    // );
  }
}
