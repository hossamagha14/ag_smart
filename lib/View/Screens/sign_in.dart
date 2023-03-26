import 'package:ag_smart/View%20Model/bloc/Sign%20in/sign_in_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Sign%20in/sign_in_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_button.dart';
import 'package:ag_smart/View/Reusable/my_text_field.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/dashboard.dart';
import 'package:ag_smart/View/Screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/error_toast.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  TextEditingController nameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignInCubit(),
          child: BlocConsumer<SignInCubit, SignInStates>(
            listener: (context, state) {},
            builder: (context, state) {
              SignInCubit myCubit = SignInCubit.get(context);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
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
                                controller: passwordControl,
                                secureText: myCubit.secure,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    myCubit.showPassword();
                                  },
                                  child: myCubit.secure == true
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                color: Colors.white),
                          ],
                        ),
                      ),
                      MainButton(
                          buttonLabel: text[chosenLanguage]!['Sign in']!,
                          function: () {
                            if (nameControl.text.isNotEmpty ||
                                passwordControl.text.isNotEmpty) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashsboardScreen(
                                      email: nameControl.text,
                                    ),
                                  ),
                                  (route) => false);
                            } else {
                              errorToast('Please add your email and password');
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                        child: Text(
                          text[chosenLanguage]!['Create a new account']!,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
