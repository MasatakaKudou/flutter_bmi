import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BMI',
        home: BMI(title: 'BMI'),
    );
  }
}

class BMI extends StatefulWidget {
  BMI({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BMI_calculate createState() => BMI_calculate();
}

class BMI_calculate extends State<BMI> {
  double bmi = 0.0; //初期値
  double weight= 0.0;
  double height = 0.0;

  final formKey = GlobalKey<FormState>();
  final heightFocus = FocusNode();
  final weightFocus = FocusNode();

  void newHeight(double _height){
    setState(() {
      height = _height;
    });
  }

  void newWeight(double _weight){
    setState(() {
      weight = _weight;
    });
  }

  void newBmi(double _bmi){
    setState(() {
      bmi = _bmi;
    });
  }

  void calculate(double _bmi,double _weight,double _height){
    _bmi = _weight / pow(_height,2);
    newBmi(_bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              '身長と体重を入力してください',
            ),
            Form(
              child: Column(
                children: <Widget>[
                  heightFormField(context),
                  weightFormField(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: RaisedButton(
                        onPressed: (){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                          }
                          calculate(bmi,height,weight);
                        },
                        child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'BMIは' + bmi.toStringAsFixed(2),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }

  TextFormField heightFormField(BuildContext context){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(labelText: "身長をm単位で記入"),
      focusNode: heightFocus,
      onFieldSubmitted: (v){
        heightFocus.unfocus();
      },
      onSaved: (value){
        newHeight(double.parse(value));
      },
    );
  }

  TextFormField weightFormField(BuildContext context){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      autofocus: true,
      decoration: InputDecoration(labelText: "体重をkg単位で記入"),
      focusNode: weightFocus,
      onFieldSubmitted: (v){
        weightFocus.unfocus();
      },
      onSaved: (value){
        newWeight(double.parse(value));
      },
    );
  }

}