// ignore_for_file: deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/screens/main_screens/mainscreen.dart';
import 'package:gradproj/screens/welcome&login/signup.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/custom_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../core/widgets/alert_dialog.dart';
import '../../core/widgets/style.dart';
import '../../cubit/auth_cubit/login_cubit/login_cubit.dart';
import '../../cubit/auth_cubit/login_cubit/login_state.dart';
import '../../widgets/text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      bool type = false;
      await Future.delayed(
        Duration.zero,
            () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Are you sure to close the app?',
                  style:
                  Styles.textStyle22.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        type = false;
                        Navigator.pop(context);
                      },
                      child: const Text('No', style: Styles.textStyle16)),
                  TextButton(
                      onPressed: () {
                        type = true;
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'Yes',
                        style: Styles.textStyle16,
                      )),
                ],
              );
            },
          );
        },
      );
      return type;
    }

    bool isLoaded = false;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          isLoaded = true;
        } else if (state is LoginSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (v) =>  MainPage()));

          isLoaded = false;
        } else if (state is LoginFailure) {
          isLoaded = false;
          customAwesomeDialog(
            buildContext: context,
            title: 'Error',
            dialogType: DialogType.error,
            animType: AnimType.scale,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoaded,
          child: WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 100.0, 32.0, 0),
                    child: Center(
                      child: Column(
                        children: [
                          const Row(children: [
                            TextTitle(
                              text: 'Login To Your\nAccount',
                              textcolor: Colors.black,
                            )
                          ]),
                          Row(children: [
                            CustomTextField(
                                hintText: "Enter your email",
                                controller: emailController,
                                isPassword: false,
                                padding_left: 0,
                                padding_top: 50,
                                padding_right: 0,
                                padding_bottom: 0)
                          ]),
                          Row(
                            children: [
                              CustomTextField(
                                  hintText: "Enter your password",
                                  controller: passwordController,
                                  isPassword: true,
                                  padding_left: 0,
                                  padding_top: 30,
                                  padding_right: 0,
                                  padding_bottom: 0),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 70, bottom: 30),
                            child: CalculateButton(
                                title: 'Login',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginCubit>(context)
                                        .loginUser(
                                            email: emailController.text,
                                            password: passwordController.text);
                                  } else {}
                                },
                                buttonbackcolor: kButtonColor,
                                buttontextcolor: Colors.white),
                          ),
                          Row(
                            children: [
                              const SmallText(
                                  text: "Don't have an account?",
                                  textcolor: Colors.black,
                                  weight: FontWeight.normal),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (v) => const SignUp()));
                                    },
                                    child: const SmallText(
                                      text: 'Sign Up',
                                      textcolor: kButtonColor,
                                      weight: FontWeight.bold,
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
