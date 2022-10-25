import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/controllers/auth_controller.dart';
import 'package:googleauth/screens/start_budget_screen.dart';
import '../colors.dart';
import '../services/auth_service.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUp({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthController controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Form(
            key: controller.key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon/Logo
                //Top sconst ection
                Text(
                  'Welcome!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 54,
                    color: ColorConstants.kWhite,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Lets crate your new account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: ColorConstants.kWhite),
                ),
                //email fild
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    validator:
                        EmailValidator(errorText: "Email not correct form"),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,
                            color: ColorConstants.kSecondaryColor),
                        hintText: "Email",
                        filled: true,
                        fillColor: ColorConstants.kThirdColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                //name
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc_outlined,
                            size: 35, color: ColorConstants.kSecondaryColor),
                        hintText: "Name",
                        filled: true,
                        fillColor: ColorConstants.kThirdColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                //password
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    validator:
                        RequiredValidator(errorText: "password is empty"),
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined,
                            size: 25, color: ColorConstants.kSecondaryColor),
                        hintText: "Password",
                        filled: true,
                        fillColor: ColorConstants.kThirdColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                //signup
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      if (controller.key.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StartBudgetScreen(controller: controller)));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: ColorConstants.kFortColor,
                          borderRadius: BorderRadius.circular(35)),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: ColorConstants.kBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //register now
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an acount? ",
                      style: TextStyle(
                          color: ColorConstants.kWhite,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        "Sing in!",
                        style: TextStyle(
                            color: ColorConstants.kFortColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
