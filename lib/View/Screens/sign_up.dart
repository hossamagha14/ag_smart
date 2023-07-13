import 'package:ag_smart/View%20Model/bloc/Sign%20up/sign_up_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Sign%20up/sign_up_states.dart';
import 'package:ag_smart/View/Reusable/main_button.dart';
import 'package:ag_smart/View/Reusable/my_text_field.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/colors.dart';
import '../Reusable/toasts.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController nameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController rePasswordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpStates>(
          listener: (context, state) {
            if (state is SignUpSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (route) => false);
              successToast(context,state.accountCreatedMessage);
            } else if (state is SignUpFailState) {
              errorToast(context,state.errorMessage);
            }
          },
          builder: (context, state) {
            SignUpCubit myCubit = SignUpCubit.get(context);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'a',
                            style: TextStyle(
                                fontFamily: 'icons',
                                fontSize: 100,
                                color: Colors.blue),
                          ),
                          Text(
                            'o',
                            style: TextStyle(
                                fontFamily: 'icons',
                                fontSize: 100,
                                color: greenButtonColor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          children: [
                            MyTextField(
                              label: text[chosenLanguage]!['sign in name']!,
                              controller: nameControl,
                              color: Colors.white,
                            ),
                            MyTextField(
                                label: text[chosenLanguage]!['Password']!,
                                secureText: myCubit.secure,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    myCubit.showPassword();
                                  },
                                  child: myCubit.secure == true
                                      ? Icon(
                                          Icons.visibility,
                                          color: iconColor,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: iconColor,
                                        ),
                                ),
                                controller: passwordControl,
                                color: Colors.white),
                            MyTextField(
                                label:
                                    text[chosenLanguage]!['confirm password']!,
                                controller: rePasswordControl,
                                secureText: myCubit.rePasswordSecure,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    myCubit.showRePassword();
                                  },
                                  child: myCubit.rePasswordSecure == true
                                      ? Icon(
                                          Icons.visibility,
                                          color: iconColor,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: iconColor,
                                        ),
                                ),
                                color: Colors.white)
                          ],
                        ),
                      ),
                      MainButton(
                          buttonLabel: text[chosenLanguage]!['Create account']!,
                          function: () {
                            {
                              if (nameControl.text.isEmpty ||
                                  passwordControl.text.isEmpty ||
                                  rePasswordControl.text.isEmpty) {
                                errorToast(context,'Please fill all');
                              } else if (passwordControl.text !=
                                  rePasswordControl.text) {
                                errorToast(context,'Password doesn\'t match');
                              } else {
                                myCubit.createAccount(
                                    username: nameControl.text,
                                    password: passwordControl.text);
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
