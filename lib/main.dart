import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple GST Calculator App',
    home: GSTForm(),
    theme: ThemeData(
        // brightness: Brightness.light,
        primaryColor: Colors.grey,
        accentColor: Colors.indigoAccent),
  ));
}

class GSTForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GSTFormState();
  }
}

class _GSTFormState extends State<GSTForm> {
  var _formKey = GlobalKey<FormState>();

  var _gsttype = ['interstate', 'intrastate'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = 'interstate';

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
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: amountController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter The Amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter Amount e.g. 1000',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: gstController,
                      decoration: InputDecoration(
                          labelText: 'GST (%)',
                          hintText: 'Enter GST percentage e.g. 18',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding,
                        left: _minimumPadding * 2),
                    child: Row(
                      children: <Widget>[
                        DropdownButton<String>(
                          style: textStyle,
                          items: _gsttype.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding,
                        top: _minimumPadding,
                        left: _minimumPadding * 20,
                        right: _minimumPadding * 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              style: textStyle,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateTotalReturns(
                                      _currentItemSelected);
                                }
                              });
                            },
                          ),
                        ),

                        /*Expanded(
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
              ),*/
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns(_currentItemSelected) {
    double amount = double.parse(amountController.text);
    double gst = double.parse(gstController.text);

    switch (_currentItemSelected) {
      case 'interstate':
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
        break;

      case 'intrastate':
        double igst = amount * 18 / 100;
        double cgst = 0.0;
        double sgst = amount * 9 / 100;
        double totalgst = amount * gst / 100.0;
        double totalamount = amount + totalgst;

        String result1 = "GST Intrastate\n\n"
            "IGST : $igst\n"
            "CGST : $cgst\n"
            "SGST : $sgst\n"
            "TOTAL GST : $totalgst\n"
            "Total AMOUNT : $totalamount\n";
        return result1;

      default:
        this.displayResult = "smoething";
    }

    /* double igst = 0.0;
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
    return result;*/
  }

/*String _calculateTotalReturns1() {
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
  }*/
}
