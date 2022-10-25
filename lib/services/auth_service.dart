import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth user = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;

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
//////////////////////// create user after crating acc/////////////////////////
  void crateUser(String username, String password, double amount,
      double currentamount, double currentexpense) {
    currentamount += amount;
    database.collection('User').doc(user.currentUser!.uid).set({
      'Username': username,
      'Password': password,
      'StartingAmount': amount,
      'currentAmount': currentamount,
      'currentExpense': currentexpense
    });
  }

  /////////////////////Read data for home page//////////////////////////
  Future getUserDataByCategory(category) async {
    String uid = user.currentUser!.uid;
    List itemList = [];
    await FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: uid)
        .where('category', isEqualTo: category)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        itemList.add(element);
      });
    });
    return itemList;
  }

  /////////////////////Read data for home page//////////////////////////
  Future getUserData() async {
    String uid = user.currentUser!.uid;
    List itemList = [];
    await FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        itemList.add(element);
      });
    });
    return itemList;
  }

///////////////////////////// getter for pieChart/////////////////////////
  fetchDataBaseList() async {
    List<double> sum=[0,0,0,0,0,0,0,0,0];
    int index= 0;
    for (var item in itemsExpence){
      sum[index]= await getmountbycat(item);
      index++;
      print(await getmountbycat(item));
    }
    //print(sum);
    return sum;
  }

  getmountbycat(String category) async{
    double sum=0;
    dynamic result = await getUserDataByCategory(category);
    if (result == null) {
      debugPrint("cant get data");
    } else {
      result.forEach((e){
        sum+=e['transactionAmount'];
      });
      return sum;}
  }
////////////////////////////Update amount and expense//////////////////////////
  void updateCurrentAmount(newamount) async {
    String uid = user.currentUser!.uid;
    double amount = await getCurrentAmount();
    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .update({'currentAmount': amount + newamount});
  }

  void updateCurrentExpence(newamount) async {
    String uid = user.currentUser!.uid;
    double amount = await getCurrentAmount();
    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .update({'currentAmount': amount - newamount});
    double expense = await getCurrentExpence();
    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .update({'currentExpense': expense + newamount});
  }

/////////////////////////current amount and curent expence/////////////////////
  Future getCurrentAmount() async {
    String uid = user.currentUser!.uid;
    DocumentSnapshot samount =
        await FirebaseFirestore.instance.collection('User').doc(uid).get();
    print(samount.get('currentAmount'));
    return samount.get('currentAmount');
  }

  Future getCurrentExpence() async {
    String uid = user.currentUser!.uid;
    DocumentSnapshot samount =
        await FirebaseFirestore.instance.collection('User').doc(uid).get();
    print(samount.get('currentExpense'));
    return samount.get('currentExpense');
  }

/////////////////////////add new income and update current ammount/////////////
  void addIncome(
    double newIncome,
    String incomeName,
    String category,
  ) {
    String uid = user.currentUser!.uid.toString();
    database.collection('transactions').add({
      'transactionName': incomeName,
      'transactionAmount': newIncome,
      'category': category,
      'uid': uid
    }).then((value) => updateCurrentAmount(newIncome));
  }

////////////////////// add expencce and update expence trakar///////////////
  void addExpence(
    double newIncome,
    String incomeName,
    String category,
  ) {
    String uid = user.currentUser!.uid.toString();
    database.collection('transactions').add({
      'transactionName': incomeName,
      'transactionAmount': newIncome,
      'category': category,
      'uid': uid
    }).then((value) => updateCurrentExpence(newIncome));
  }

  ////////////////////////sign in///////////////////////////////////////
  Future signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

////////////////////////sign up///////////////////////////////////////
  Future signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

////////////////////////sign out///////////////////////////////////////
  Future signOut() async {
    try {
      return FirebaseAuth.instance.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
