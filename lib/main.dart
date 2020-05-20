import 'package:flutter/material.dart';

void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple GST Calculator App',
      home: GSTForm(),
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
    )
  );
}

class GSTForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _GSTFormState();
  }
}
class _GSTFormState extends State<GSTForm> {
 // var _gsttype = ['exclusive', 'inclusive'];
  final _minimumPadding = 5.0;

  TextEditingController amountController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  //TextEditingController termController = TextEditingController();

  var displayResult = '';
  var displayResult1 = '';

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('GST Calculator'),
      ),

      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(

          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child:TextField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter Amount e.g. 1000',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            )),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: gstController,
              decoration: InputDecoration(
                  labelText: 'GST (%)',
                  hintText: 'Enter GST percentage e.g. 18',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            )),

            Padding(
              padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
                child: Row(children: <Widget>[
                  Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text('GST_Interstate', style: textStyle,),
                  onPressed: () {
                    setState(() {
                      this.displayResult = _calculateTotalReturns();
                    });

                  },
                ),
              ),

              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text('GST_Intrastate', style: textStyle,),
                  onPressed: () {
                    setState(() {
                      this.displayResult1 = _calculateTotalReturns1();
                    });

                  },
                ),
              ),
            ],)),

            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text(this.displayResult, style: textStyle,),

            )



          ],
        ),
      ),
    );
  }

  String _calculateTotalReturns() {
    double amount = double.parse(amountController.text);
    double gst = double.parse(gstController.text);

    double igst = 0.0;
    double cgst = amount * 9 / 100;
    double sgst = amount * 9 / 100;
    double totalgst = amount * gst / 100.0;
    double totalamount = amount + totalgst;

    String result = "GST Interstate\n\n"
                    "IGST : $igst\n"
                    "CGST : $cgst\n"
                    "SGST : $sgst\n"
                    "TOTAL GST : $totalgst\n"
                    "Total AMOUNT : $totalamount\n";
    return result;
  }


  String _calculateTotalReturns1() {
    double amount = double.parse(amountController.text);
    double gst = double.parse(gstController.text);

    double igst = amount * 18 / 100;
    double cgst = amount * 0.0;
    double sgst = amount * 0.0;
    double totalgst = amount * gst / 100.0;
    double totalamount = amount + totalgst;

    String result1 = "GST Intrastate\n\n"
        "IGST : $igst\n"
        "CGST : $cgst\n"
        "SGST : $sgst\n"
        "TOTAL GST : $totalgst\n"
        "Total AMOUNT : $totalamount\n";
    return result1;
  }
}