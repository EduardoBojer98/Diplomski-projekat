import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/screens/home_screen.dart';
import '../colors.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({Key? key, required this.showRegisterPage})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //icon/Logo
              Image.asset('assets/logo.png', scale: 0.7),
              SizedBox(height: 10),
              //Top sconst ection
              Text(
                'Welcome Back',
                style: GoogleFonts.bebasNeue(
                  fontSize: 54,
                  color: ColorConstants.kWhite,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Lets manage some money",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: ColorConstants.kWhite),
              ),
              //email fild
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
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
              //password
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined,
                          color: ColorConstants.kSecondaryColor),
                      hintText: "Password",
                      filled: true,
                      fillColor: ColorConstants.kThirdColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              //singin
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: (){
                    controller.signIn();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: ColorConstants.kFortColor,
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                      child: Text(
                        'Sign In',
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
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account? ",
                    style: TextStyle(
                        color: ColorConstants.kWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      "Register Now!",
                      style: TextStyle(
                        color: ColorConstants.kFortColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
