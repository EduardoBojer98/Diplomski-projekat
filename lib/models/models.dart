
class Transaction {
  String? transactionName;
  String? transactionAmount;
  String? category;

  Transaction(this.transactionName, this.transactionAmount, this.category);

  Map<String, dynamic> json() => {
        'transactionName': transactionName,
        'transactionAmount': transactionAmount,
        'category': category
      };

  Transaction.fromjson(Map<String, dynamic> json) {
    transactionName = json['transactionName'];
    transactionAmount = json['transactionAmount'];
    category = json['category'];
  }

}
