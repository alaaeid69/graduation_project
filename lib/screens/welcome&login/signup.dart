import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/core/widgets/alert_dialog.dart';
import 'package:gradproj/cubit/auth_cubit/register_cubit/register_cubit.dart';
import 'package:gradproj/cubit/auth_cubit/register_cubit/register_state.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text.dart';
import '../data&bmr&bmi/datascreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullname = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String? email;
  String? password;
  final GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    bool isLoaded = false;
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is RegisterLoading) {
        isLoaded = true;
      } else if (state is RegisterSuccess) {
        Navigator.of(context).push(
        MaterialPageRoute(builder: (v) => const DataHomeScreen())
        );
        isLoaded = false;
      } else if (state is RegisterFailure) {
        isLoaded = false;
        customAwesomeDialog(
            buildContext: context,
            title: 'Error',
            dialogType: DialogType.error,
            animType: AnimType.scale,
            description: state.error);
      }
    },
    builder: (context, state) {
    return ModalProgressHUD(
    inAsyncCall: isLoaded,
    child: Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 100.0, 32.0, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(children: [
                  TextTitle(
                    text: 'Create Your\nAccount',
                    textcolor: Colors.black,
                  )
                ]),
                Row(children: [
                  CustomTextField(
                      hintText: "Enter your full name",
                      controller: fullname,
                      isPassword: false,
                      padding_left: 0,
                      padding_top: 50,
                      padding_right: 0,
                      padding_bottom: 0)
                ]),
                Row(
                  children: [
                    CustomTextField(
                        hintText: "Enter your email",
                        controller: emailController,
                        isPassword: false,
                        padding_left: 0,
                        padding_top: 30,
                        padding_right: 0,
                        padding_bottom: 0),
                  ],
                ),
                Row(children: [
                  CustomTextField(
                      hintText: "Create your password",
                      controller: passwordController,
                      isPassword: true,
                      padding_left: 0,
                      padding_top: 30,
                      padding_right: 0,
                      padding_bottom: 0)
                ]),
                Row(
                  children: [
                    CustomTextField(
                        hintText: "Confirm your password",
                        controller: confirmPassword,
                        isPassword: true,
                        padding_left: 0,
                        padding_top: 30,
                        padding_right: 0,
                        padding_bottom: 0),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: CalculateButton(
                        title: 'Sign Up',
                        onTap: () async {
                          if(formKey.currentState!.validate()){
                           BlocProvider.of<RegisterCubit>(context).registerUser(
                               email: emailController.text,
                               password: passwordController.text,
                               userName: fullname.text,
                               phoneNumber: ''
                           );
                          }

                          // Navigator.of(context).push(
                          // MaterialPageRoute(builder: (v) => const DataHomeScreen())
                          // );
                        },
                        buttonbackcolor: kButtonColor,
                        buttontextcolor: Colors.white))
              ],
            ),
          ),
        ),
      ),
    ));
  },
    );


  }}

