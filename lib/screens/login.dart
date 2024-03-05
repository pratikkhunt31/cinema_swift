// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cinema_swift/controller/auth_controller.dart';
import 'package:cinema_swift/screens/signup.dart';
import 'package:cinema_swift/utils/social_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: MyTheme.splash,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/splash_icon.svg'),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Welcome to MovieMania',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Text(
                'Get the best seat in the house! Login now.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 15,
                        color: MyTheme.splash,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextFormField(
                        controller: passwordController,
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Forgot Password?",
                            content: TextFormField(
                              controller: forgotEmailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Email Address",
                                hintStyle:
                                    const TextStyle(color: Colors.black45),
                                fillColor: MyTheme.greyColor,
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                            radius: 10,
                            onWillPop: () {
                              forgotEmailController.text = "";
                              return Future.value(true);
                            },
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            confirm: ElevatedButton(
                              onPressed: () {
                                AuthController.instance.forgotPass(
                                    forgotEmailController.text.trim());
                                forgotEmailController.text = "";
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyTheme.splash,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Send Reset Mail",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AuthController.instance.login(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.splash,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'OR',
                              style: TextStyle(color: Color(0xFFC1C1C1)),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.8,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: SocialButton(
                        onGoogleClick: () {
                          AuthController.instance.googleLogin();
                        },
                        onFbClick: () {},
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Don't have an account ? ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => SignUpPage());
                      },
                  ),
                  TextSpan(
                    text: " here.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
