import 'package:flutter/material.dart';

String oldNumber1 = '';
String oldNumber2 = '';
String task = '';
bool changed = false;

final GlobalKey<MainText> wKey = GlobalKey<MainText>();
final GlobalKey<Calc> calcKey = GlobalKey<Calc>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child : Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 75, 0),
                        child: Calc_(key: calcKey, label: "")
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child : Padding(
                        padding: EdgeInsets.fromLTRB(0, 100, screenWidth * 0.14, 0),
                        child: MainText_(key: wKey, label: "0")
                      ),
                    )
                  ],
                ),
              ),
              const ButtonSection(label1: ["AC", Color.fromARGB(165, 165, 165, 165)], label2: ["+|-", Color.fromARGB(165, 165, 165, 165)], label3: ["%", Color.fromARGB(165, 165, 165, 165)], label4: ["/", Color.fromARGB(255, 255, 198, 41)]),
              const ButtonSection(label1: ["7", Color.fromARGB(255, 51, 51, 51)], label2: ["8", Color.fromARGB(255, 51, 51, 51)], label3: ["9", Color.fromARGB(255, 51, 51, 51)], label4: ["X", Color.fromARGB(255, 255, 198, 41)]),
              const ButtonSection(label1: ["4", Color.fromARGB(255, 51, 51, 51)], label2: ["5", Color.fromARGB(255, 51, 51, 51)], label3: ["6", Color.fromARGB(255, 51, 51, 51)], label4: ["—", Color.fromARGB(255, 255, 198, 41)]),
              const ButtonSection(label1: ["1", Color.fromARGB(255, 51, 51, 51)], label2: ["2", Color.fromARGB(255, 51, 51, 51)], label3: ["3", Color.fromARGB(255, 51, 51, 51)], label4: ["+", Color.fromARGB(255, 255, 198, 41)]),
              const ButtonSection(label1: ["0", Color.fromARGB(255, 51, 51, 51)], label2: [" ", Color.fromARGB(255, 51, 51, 51)], label3: [".", Color.fromARGB(255, 51, 51, 51)], label4: ["=", Color.fromARGB(255, 255, 198, 41)]),
            ]
          ),
        ),
      ),
    );
  }
}

class MainText_ extends StatefulWidget {
  MainText_({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  MainText createState() => MainText();
}

class MainText extends State<MainText_>{
  String _Number = "0";
  String Cashe = "0";

  void Operation(String Numb) {
    setState(() {
      if(Numb == "."){
        if(!_Number.contains(".")){
          _Number = _Number + ".";
        }
      }
      else if(Numb == "AC"){
        changed = false;
        _Number = '0';
        task = "";
        oldNumber1 = "";
        oldNumber2 = "";
        calcKey.currentState?.Change("");
      }
      else if(Numb == "+|-"){
        if(_Number != "0"){
          _Number = (-double.parse(_Number)).toString();
        }
      }
      else if(Numb == "%"){
        if(oldNumber1 == ""){
          _Number = '0';
        }
        else{
          calcKey.currentState?.Change(oldNumber1 + "% z " + _Number + " =");
          _Number = ((double.parse(oldNumber1) / 100) * double.parse(_Number)).toString();
        }
      }
      else if(Numb == "+"|| Numb == "—" || Numb == "X" || Numb == "/"){
        changed = true;
        oldNumber1 = _Number;
        _Number = '0';
        task = Numb;
        calcKey.currentState?.Change(oldNumber1 + " " + Numb);
      }
      else if(Numb == "="){
        if(changed){
          oldNumber2 = _Number;
          changed = false;
        }
        else{
          oldNumber1 = _Number;
        }
        calcKey.currentState?.Change(oldNumber1 + " " + task + " " + oldNumber2 + " =");
        if(task == "—"){
            _Number = (double.parse(oldNumber1) - double.parse(oldNumber2)).toString();
          }
          if(task == "/"){
            _Number = (double.parse(oldNumber1) / double.parse(oldNumber2)).toString();
          }
        if(task == "+"){
          _Number = (double.parse(oldNumber1) + double.parse(oldNumber2)).toString();
        }
        if(task == "X"){
          _Number = (double.parse(oldNumber1) * double.parse(oldNumber2)).toString();
        }
      }
      else if(int.parse(Numb) < 10 && _Number != "0" && _Number.length <= 9){
          if(calcKey.currentState!.Text_.contains("=")){
            this.Operation("AC");
            _Number = Numb;
          }
          else{
            _Number = _Number + Numb;
          }
      }
      else if(int.parse(Numb) < 10 && _Number.length <= 9){
        if(_Number == "0"){
          _Number = Numb;
        }
      }
    });
  }
    
  @override
  Widget build(BuildContext context) {

    return Text(
      _Number,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontWeight: FontWeight.w100),
    );
  }
}


class Calc_ extends StatefulWidget {
  Calc_({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  Calc createState() => Calc();
}

class Calc extends State<Calc_>{
  String Text_ = "";

  void Change(String Change) {
    setState(() {
      Text_ = Change;
    });
  }
    
  @override
  Widget build(BuildContext context) {

    return Text(
      Text_,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 30,
        fontWeight: FontWeight.w100),
    );
  }
}


class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.label4,
  }) : super(key: key);

  final List label1;
  final List label2;
  final List label3;
  final List label4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWithText(
            color: label1[1],
            label: label1[0],
          ),
          ButtonWithText(
            color: label2[1],
            label: label2[0],
          ),
          ButtonWithText(
            color: label3[1],
            label: label3[0],
          ),
          ButtonWithText(
            color: label4[1],
            label: label4[0],
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 90))
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  ButtonWithText({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final Color color;
  final String label;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        wKey.currentState?.Operation(label);
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 35,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}


