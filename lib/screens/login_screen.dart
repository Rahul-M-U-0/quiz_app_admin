// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_admin/resources/authentication_methods.dart';
import 'package:quiz_admin/screens/add_quiz.dart';
import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  bool _isPasswordVisible = false;

  String email = "", password = "";

  @override
  void dispose() {
    _userController.text;
    _passwordController.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: blackBG,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Welcome !",
                  style: TextStyle(
                    fontSize: 40,
                    color: whiteText,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Please sign as admin",
                  style: TextStyle(
                    fontSize: 18,
                    color: grayText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60),

                // email field
                Container(
                  height: 70,
                  width: double.infinity,
                  // margin: const EdgeInsets.symmetric(
                  //   horizontal: 20,
                  // ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: blackTextFild,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _userController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: grayText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            color: whiteText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/icons/user.svg",
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                          grayText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // password field
                Container(
                  height: 70,
                  // margin: const EdgeInsets.symmetric(
                  //   horizontal: 20,
                  //   vertical: 15,
                  // ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: blackTextFild,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: grayText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            color: whiteText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: !_isPasswordVisible
                            ? SvgPicture.asset(
                                "assets/icons/hide.svg",
                                height: 25,
                                colorFilter: const ColorFilter.mode(
                                  grayText,
                                  BlendMode.srcIn,
                                ),
                              )
                            : SvgPicture.asset(
                                "assets/icons/visibility.svg",
                                height: 25,
                                colorFilter: const ColorFilter.mode(
                                  grayText,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),

                // sign in button
                GestureDetector(
                  onTap: () async {
                    String output = await authenticationMethods.signInUser(
                      userEmail: _userController.text,
                      userPassword: _passwordController.text,
                    );

                    if (output == "success") {
                      // doing next function
                      log("login success");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const AddQuizScreen(),
                        ),
                      );
                    } else {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: Text(
                          output,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    height: 75,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: blueButton,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 18,
                        color: whiteText,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
