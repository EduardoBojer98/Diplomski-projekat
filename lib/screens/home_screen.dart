import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/screens/transactions_screen.dart';
import 'package:pie_chart/pie_chart.dart';
import '../screens/trnsactions/icome_screen.dart';
import '../screens/trnsactions/expense_screen.dart';
import '../services/auth_service.dart';
import '../widgets/AppBarWidget.dart';
import '../colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService service = AuthService();
  Future? currentAmount;
  Future? currentExpence;
  List transactionList = [];

  @override
  void initState() {
    currentAmount = service.getCurrentAmount();
    currentExpence = service.getCurrentExpence();
    fetchDataBaseList();
    super.initState();
  }

  fetchDataBaseList() async {
    dynamic result = await service.getUserData();

    if (result == null) {
      debugPrint("cant get data");
    } else {
      setState(() {
        transactionList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.kPrimaryColor,
        appBar: CustomAppBar(
          backgroundColor: ColorConstants.kPrimaryColor,
          title: "Badget Manager",
        ),
        //////////////////body/ middle section of home//////////////////////////
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              color: ColorConstants.kThirdColor,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Expence Chart',
                          style: TextStyle(
                              color: ColorConstants.kBlack,
                              fontSize: 26,
                              fontWeight: FontWeight.w300),
                        ),
                        FutureBuilder(
                          future: service.fetchDataBaseList(),
                          builder: (context,AsyncSnapshot<dynamic> snapshot)
                          => PieChart(
                            dataMap: {'Food & Drinks':snapshot.data?.elementAt(0)??0,
                              'Bills':snapshot.data?.elementAt(1)??0,
                              'Shopping':snapshot.data?.elementAt(2)??0,
                              'Housing':snapshot.data?.elementAt(3)??0,
                              'Life & Entertainment':snapshot.data?.elementAt(4)??0,
                              'Presents':snapshot.data?.elementAt(5)??0,
                              'Vehicle':snapshot.data?.elementAt(6)??0,
                              'Savings':snapshot.data?.elementAt(7)??0,
                              'Other':snapshot.data?.elementAt(8)??0,},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ////////////////////////title Transition view all////////////////
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                  child: Text(
                    'Transaction History',
                    style: TextStyle(
                        color: ColorConstants.kWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 130.0, bottom: 10),
                  child: GestureDetector(
                    child: Text(
                      "view all",
                      style: TextStyle(
                          color: ColorConstants.kWhite, fontSize: 16.0),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionsScreen()));
                    },
                  ),
                ),
              ],
            ),
            //////////////////////////////Transition history///////////////
            Expanded(
              child: FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                      itemCount: transactionList.length,
                      itemBuilder: (context, snapshot) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${transactionList[snapshot]['transactionName']}',
                              style: GoogleFonts.roboto(fontSize: 17),
                            ),
                            subtitle: Text(
                              '\$ ${transactionList[snapshot]['transactionAmount']}',
                              style: GoogleFonts.roboto(fontSize: 15),
                            ),
                            trailing: Text(
                              '${transactionList[snapshot]['category']}',
                              style: GoogleFonts.roboto(fontSize: 17),
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
        //////////////////////////////////////bottom bar/////////////////////////
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
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Add Transactions"),
                                content: Container(
                                  height: 100.0,
                                  child: Column(
                                    children: <Widget>[
                                      //button for incomes
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                                Icons.attach_money_outlined),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(1.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            IcomeScreen()));
                                              },
                                              child: Text("Income"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //button for expense
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.money_off),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(1.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ExpenceScreen()));
                                              },
                                              child: Text("Expense"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    },
                    icon: Icon(
                      Icons.add,
                      color: ColorConstants.kWhite,
                      size: 35,
                    )),
              ),
            ],
          ),
        ));
  }
}
