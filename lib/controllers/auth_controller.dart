import 'package:flutter/material.dart';
import 'package:googleauth/services/auth_service.dart';

class AuthController {
  static final AuthController _authController = AuthController._internal();
  factory AuthController() {
    return _authController;
  }
  AuthController._internal();
  List<String> items = ['Salary', 'Percents', 'Gifts', 'Freelance', 'Side Job'];
  List<String> itemsExpence = [
    'Food & Drink',
    'Bills',
    'Shopping',
    'Housing',
    'Life & Entertainment',
    'Presents',
    'Vehicle',
    'Savings',
    'Other'
  ];
  //////////////controllers for login/signup///////////
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final double curamount = 0.0;
  final double expencesamount = 0.0;
  final IncomeNameController = TextEditingController();
  final IncomeAmountController = TextEditingController();
  String Categoryoftransation = 'Salary';
  String CategoryoftransationExpence = 'Food & Drink';
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final AuthService service = AuthService();
/////////////////////////////////income and expense trackers////////////////
  void AddIncome() async {
    service.addIncome(double.parse(IncomeAmountController.text),
        IncomeNameController.text, Categoryoftransation);
  }

  void AddExpence() async {
    service.addExpence(double.parse(IncomeAmountController.text),
        IncomeNameController.text, CategoryoftransationExpence);
  }

//////////////////////////////////////////////////////////////////////////
  void signup() {
    service
        .signUp(emailController.text.trim(), passwordController.text.trim())
        .then((value) => service.crateUser(
              nameController.text.trim(),
              passwordController.text.trim(),
              double.parse(amountController.text),
              double.parse(curamount.toString()),
              double.parse(expencesamount.toString()),
            ));
  }

  void signIn() async {
    service.signIn(emailController.text.trim(), passwordController.text.trim());
  }
}
