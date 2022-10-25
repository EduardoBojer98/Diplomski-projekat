import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/auth/AuthPage.dart';
import 'package:googleauth/colors.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      appBar: AppBar(
        backgroundColor: ColorConstants.kPrimaryColor,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: GoogleFonts.roboto(),
        ),
        leading: Image.asset(
          'assets/logo.png',
          scale: 1.6,
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await service.signOut().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthPage())));
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Container(),
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
                    Icons.home,
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
