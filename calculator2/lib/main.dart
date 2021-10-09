import 'package:flutter/material.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      child: RaisedButton(
        onPressed: (){
          // Todo add function for button press
          calculation(btntxt);
        },
        child: Text(btntxt,
          style : TextStyle(
            fontSize: 35,
            color: txtcolor,
         ),
       ),
       shape: CircleBorder(),
       color: btncolor,
       padding: EdgeInsets.all(20),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator'),backgroundColor: Colors.black,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // calculator display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(text,
                      textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                      fontSize: 100
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called where we will pass some arguments
                calcbutton('AC', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            // copy the Row code above to make more rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called where we will pass some arguments
                calcbutton('7', Colors.grey.shade800, Colors.white),
                calcbutton('8', Colors.grey.shade800, Colors.white),
                calcbutton('9', Colors.grey.shade800, Colors.white),
                calcbutton('x', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            // copy it again
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called where we will pass some arguments
                calcbutton('4', Colors.grey.shade800, Colors.white),
                calcbutton('5', Colors.grey.shade800, Colors.white),
                calcbutton('6', Colors.grey.shade800, Colors.white),
                calcbutton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            // copy it again
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called where we will pass some arguments
                calcbutton('1', Colors.grey.shade800, Colors.white),
                calcbutton('2', Colors.grey.shade800, Colors.white),
                calcbutton('3', Colors.grey.shade800, Colors.white),
                calcbutton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            // last row is different and needs to be created
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // This is button 0
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 24, 128, 20),
                  onPressed: (){
                    
                  },
                  shape: StadiumBorder(),
                  child: Text("0",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white
                    ),
                  ),
                  color: Colors.grey.shade800,
                ),
                calcbutton('.', Colors.grey.shade800, Colors.white), 
                calcbutton('=', Colors.amber.shade700, Colors.white),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(height: 10),
        color: Colors.black,
      ),
    );
  }
  // logic of the calculator
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}

