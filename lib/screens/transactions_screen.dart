import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/home_screen.dart';
import '../colors.dart';
import '../services/auth_service.dart';
import '../widgets/AppBarWidget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final AuthService service = AuthService();
  Future? currentAmount;
  Future? currentExpence;
  List transactionList = [];
  String selector = '';

  fetchDataBaseList() async {
    dynamic result = await service.getUserDataByCategory(selector);

    if (result == null) {
      debugPrint("cant get data");
    } else {
      setState(() {
        transactionList = result;
      });
    }
  }

  @override
  void initState() {
    currentAmount = service.getCurrentAmount();
    currentExpence = service.getCurrentExpence();
    fetchDataBaseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kSecondaryColor,
      appBar: CustomAppBar(
        title: "Transactions",
        backgroundColor: ColorConstants.kPrimaryColor,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: service.itemsExpence.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selector = service.itemsExpence.elementAt(index);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        width: 100,
                        //color: ColorConstants.kWhite,
                        height: 20,
                        decoration: BoxDecoration(
                          color: ColorConstants.kWhite,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          service.itemsExpence.elementAt(index),
                          style: GoogleFonts.robotoMono(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
          ),
          Expanded(
            flex: 20,
            child: FutureBuilder(
              future: service.getUserDataByCategory(selector),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            '${snapshot.data.elementAt(index)['transactionName']}',
                            style: GoogleFonts.roboto(fontSize: 17),
                          ),
                          subtitle: Text(
                            '${snapshot.data.elementAt(index)['transactionAmount']}',
                            style: GoogleFonts.roboto(fontSize: 15),
                          ),
                          trailing: Text(
                            '${snapshot.data.elementAt(index)['category']}',
                            style: GoogleFonts.roboto(fontSize: 17),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
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
                        style: TextStyle(
                            color: ColorConstants.kWhite, fontSize: 17),
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
                        style: TextStyle(color: Colors.red, fontSize: 17),
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
