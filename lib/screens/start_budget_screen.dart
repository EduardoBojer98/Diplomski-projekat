import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/colors.dart';
import 'package:googleauth/controllers/auth_controller.dart';
import 'package:googleauth/screens/home_screen.dart';

class StartBudgetScreen extends StatefulWidget {
  AuthController controller;
  StartBudgetScreen({required this.controller});

  @override
  State<StartBudgetScreen> createState() => _StartBudgetScreenState();
}

class _StartBudgetScreenState extends State<StartBudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.kPrimaryColor,
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Top sconst ection
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Register your current amount!',
                style: GoogleFonts.roboto(
                  fontSize: 34,
                  color: ColorConstants.kWhite,
                ),
              ),
            ),
            //starting anount imput fild
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: widget.controller.amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_outlined,
                        color: ColorConstants.kSecondaryColor),
                    hintText: "Current Amount",
                    filled: true,
                    fillColor: ColorConstants.kThirdColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
            //register anount
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  widget.controller.signup();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: ColorConstants.kFortColor,
                      borderRadius: BorderRadius.circular(35)),
                  child: Center(
                    child: Text(
                      'Register Amount',
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
          ],
        ))));
  }
}
