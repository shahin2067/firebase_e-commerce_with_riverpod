import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/auth/auth_provider.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/auth/auth_state.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/auth/registration_screen.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/bottom_nav_cotroller.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/widgets/custom_button.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/widgets/k_text_field.dart';
import 'package:e_commerce_app_with_firebase_riverpod/presentation/widgets/validator_logic.dart';
import 'package:e_commerce_app_with_firebase_riverpod/style/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final emailController =
        useTextEditingController(text: "srkhancucse@gmail.com");
    final passwordController = useTextEditingController(text: "123456");
    final showPassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final loading = ref.watch(authProvider.select((value) => value.loading));

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && next.loggedIn) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavController()));
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.error(
            title: Text(next.failure.error),
            toastPosition: Position.bottom,
          ).show(context);
        }
      }
    });

    // ref.listen<AuthState>(authProvider, (previous, next) {
    //   if (next.failure == CleanFailure.none() && next.loggedIn) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const BottomNavController(),
    //       ),
    //     );
    //   }
    // });

    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.light,
                        color: Colors.transparent,
                      ),
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
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
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 22.sp, color: AppColors.deep_orange),
                        ),
                        Text(
                          "Glad to see you back my buddy.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 48.h,
                                    width: 41.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.deep_orange,
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Center(
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: Colors.white,
                                        size: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: KTextField(
                                      validator: (text) {
                                        final d =
                                            ValidatorLogic.requiredEmail(text);
                                        Logger.i('cheking');
                                        Logger.i('email: $d');
                                        return d;
                                      },
                                      controller: emailController,
                                      hintText: "email@mail.com",
                                      labelText: "Email",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 48.h,
                                    width: 41.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.deep_orange,
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Center(
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                        size: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: KTextField(
                                      validator: (text) =>
                                          ValidatorLogic.requiredPassword(text),
                                      controller: passwordController,
                                      labelText: "Password",
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          showPassword.value =
                                              !showPassword.value;
                                        },
                                        child: showPassword.value
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: AppColors.deep_orange,
                                                size: 20.w,
                                              )
                                            : Icon(
                                                Icons.remove_red_eye,
                                                color: AppColors.deep_orange,
                                                size: 20.w,
                                              ),
                                      ),
                                      obscureText: !showPassword.value,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        SizedBox(
                          width: 1.sw,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                ref.read(authProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deep_orange,
                              elevation: 3,
                            ),
                            child: loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                  ),
                          ),
                        ),
                        // elevated button
                        // customButton(
                        //   "Sign In",
                        //   () {
                        //     Logger.i(formKey.currentState?.validate() ?? false);
                        //     if (formKey.currentState?.validate() ?? false) {
                        //       ref.read(authProvider.notifier).login(
                        //           email: emailController.text,
                        //           password: passwordController.text);
                        //       // final body = LogInBody(
                        //       //     email: emailController.text,
                        //       //     password: passwordController.text);
                        //       // Logger.i(body);
                        //       // ref.read(authProvider.notifier).login(body: body);
                        //     }
                        //     //signIn();
                        //   },
                        // ),

                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                " Sign Up",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deep_orange,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
