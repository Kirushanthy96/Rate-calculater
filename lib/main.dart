import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: ("Simple Interest Calculater App"),
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();

  var _currencies = ["Rupees", "Dollers", "Pounds"];
  final _minimalPadding = 5.0;

  var _currentItemSelected = "Rupees";
  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController TermController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculater App'),
      ),
      body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(_minimalPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimalPadding, bottom: _minimalPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: principalController,
                    validator:(String value) {
                      if (value.isEmpty) {
                        return "please enter the principal amount";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelStyle: textStyle,
                        labelText: "Principal",
                        hintText: "Enter the Principal e.g 12000",
                        errorStyle:TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimalPadding, bottom: _minimalPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: roiController,
                    keyboardType: TextInputType.number,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter the Interest value";
                      }
                    },
                    decoration: InputDecoration(
                        labelStyle: textStyle,
                        labelText: "Rate of Interest",
                        hintText: "In Percent",
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimalPadding, bottom: _minimalPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: textStyle,
                          controller: TermController,
                          keyboardType: TextInputType.number,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Enter the term value";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Term",
                              labelStyle: textStyle,
                              hintText: "Time in Years",
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(width: _minimalPadding * 5),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimalPadding, bottom: _minimalPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text("Calculate", textScaleFactor: 1.5),
                          onPressed: () {
                            setState(() {
                              if(_formkey.currentState.validate()){
                              this.displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).accentColor,
                          child: Text("Reset", textScaleFactor: 1.5),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimalPadding * 2),
                  child: Text(this.displayResult),
                )
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, height: 150.0, width: 150.0);

    return Container(
      child: image,
      margin: EdgeInsets.all(50.0),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(TermController.text);

    double totalAmountPayable = principal + (principal + roi + term) / 100;

    String Result =
        'After $term years invesment will be worth $totalAmountPayable $_currentItemSelected';

    return Result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    TermController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];

  }
}
