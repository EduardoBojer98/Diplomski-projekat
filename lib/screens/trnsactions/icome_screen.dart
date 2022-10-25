import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/colors.dart';
import 'package:googleauth/screens/home_screen.dart';

import '../../controllers/auth_controller.dart';
import '../../services/auth_service.dart';
import '../../widgets/AppBarWidget.dart';

class IcomeScreen extends StatefulWidget {
  IcomeScreen({Key? key}) : super(key: key) {}

  @override
  State<IcomeScreen> createState() => _IcomeScreenState();
}

class _IcomeScreenState extends State<IcomeScreen> {
  final AuthController controller = AuthController();
  String? selectedItem = 'Salary';

  final AuthService service = AuthService();
  Future? currentAmount;
  Future? currentExpence;


  @override
  void initState() {
    currentAmount = service.getCurrentAmount();
    currentExpence = service.getCurrentExpence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kSecondaryColor,
      appBar: CustomAppBar(
        title: 'Incomes',
        backgroundColor: ColorConstants.kPrimaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 100),
                child: Text(
                  'Register ',
                  style: GoogleFonts.roboto(
                    fontSize: 50,
                    fontStyle: FontStyle.italic,
                    color: ColorConstants.kWhite,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'your income!',
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: ColorConstants.kWhite,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: controller.IncomeNameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.abc_outlined,
                          color: ColorConstants.kSecondaryColor),
                      hintText: "Income Name",
                      filled: true,
                      fillColor: ColorConstants.kThirdColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: controller.IncomeAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on_outlined,
                          color: ColorConstants.kSecondaryColor),
                      hintText: "Income Amount",
                      filled: true,
                      fillColor: ColorConstants.kThirdColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category_outlined,
                          color: ColorConstants.kSecondaryColor),
                      filled: true,
                      fillColor: ColorConstants.kThirdColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      )),
                  value: selectedItem,
                  items: controller.items
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: GoogleFonts.roboto())))
                      .toList(),
                  onChanged: (item) => setState(() { selectedItem = item;
                  controller.Categoryoftransation=item!;
                  }),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: GestureDetector(
                  onTap: () {
                    Map<String, String> transactionToAdd = {
                      'IncomeName': controller.IncomeNameController.text,
                      'IncomeAmount': controller.IncomeAmountController.text
                    };
                    Navigator.of(context).pop();
                  },
                  child: InkWell(
                    onTap: (){controller.AddIncome();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));},
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorConstants.kPrimaryColor,
        child: Row(
          children: <Widget>[
            FutureBuilder(
                future: currentAmount,
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListTile(
                      title: Text(
                        "Balance:",
                        style: TextStyle(color: ColorConstants.kWhite),
                      ),
                      subtitle: Text(
                        "\$ ${snapshot.data}",
                        style: TextStyle(color: ColorConstants.kWhite,fontSize: 17),
                      ),
                    ),
                  );
                }),
            FutureBuilder(
                future: currentExpence,
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListTile(
                      title: Text(
                        "Expense:",
                        style: TextStyle(color: ColorConstants.kWhite),
                      ),
                      subtitle: Text(
                        "\$ ${snapshot.data}",
                        style: TextStyle(
                            color: Colors.red, fontSize: 17),
                      ),
                    ),
                  );
                }),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    color: ColorConstants.kWhite,
                    size: 35,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
