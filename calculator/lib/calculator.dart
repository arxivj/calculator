import 'package:calculator/circle_button.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int? firstOperand;
  String? operator;
  int? secondOperand;
  dynamic result;

  void numberTapped(int tappedNumber) {
    if (firstOperand == null) {
      setState(() {
        firstOperand = tappedNumber; // 아무것도 입력 안돼있으면 firstOperand 변수에 저장
      });
      return; // 더이상 진행하지 않도록 리턴
    }

    if (operator == null) {
      // 이후 다시 입력하면 위에 !=null 이므로 이쪽으로 오지
      setState(() {
        firstOperand = int.parse(
            "$firstOperand$tappedNumber"); // 그러면 firstOperand를 새로 입력한 숫자를 추가해서 변경해주고
      });
      return; // 다시 더이상 진행하지 않도록 리턴 -> 그리고 또 입력시 계속 이쪽에서 진행 ( operator != null 일 때 까지)
    }

    if (secondOperand == null) {
      // firstOperand != null && operator != null 이면 이쪽으로 진행됨
      setState(() {
        secondOperand = tappedNumber; // 그러면 입력한 숫자를 secondOperand 변수에 넣어주고
      });
      return; // secondOperand != null 이면 아래로
    }

    setState(() {
      secondOperand =
          int.parse("$secondOperand$tappedNumber"); // 두번째 변수 역시 마찬가지로 계속 붙여줌
    });
  }

  void clearNumber() {
    setState(
      () {
        firstOperand = null;
        operator = null;
        secondOperand = null;
        result = null;
      },
    );
  }

  void operatorTapped(String tappedOperator) {
    setState(() {
      operator = tappedOperator;
    });
  }

  String showText() {
    if (result != null) {
      return "$result";
    }
    if (secondOperand != null) {
      // 두번째 숫자가 존재하면 전체 출력해줘야지. 앞에 첫번째 숫자와 operator가 존재하니까
      return "$firstOperand$operator$secondOperand";
    }

    if (operator != null) {
      // 만약 두번쨰 숫자가 Null이면 이젠 operator가 존재하는지 확인해야지
      return "$firstOperand$operator"; // 존재하면 거기까지 출력
    }

    if (firstOperand != null) {
      // 만약 operator가 null이면 첫번째 숫자가 존재하는지 확인
      return "$firstOperand"; // 존재하면 거기까지 출력
    }
    return "0"; // 싹다 널이면 0 출력
  }

  void calculateResult() {
    if (firstOperand == null || secondOperand == null) {
      return;
    }
    // 계산식 써야될 것 같음
    if (operator == "+") {
      plusNumber();
      return;
    }
    if (operator == "-") {
      minusNumber();
      return;
    }
    if (operator == "x") {
      multiplayNumber();
      return;
    }
    if (operator == "%") {
      divideNumber();
      return;
    }
    return;
  }

  void plusNumber() {
    setState(() {
      result = firstOperand! + secondOperand!;
    });
  }

  void minusNumber() {
    setState(() {
      result = firstOperand! - secondOperand!;
    });
  }

  void multiplayNumber() {
    setState(() {
      result = firstOperand! * secondOperand!;
    });
  }

  void divideNumber() {
    setState(() {
      result = firstOperand! / secondOperand!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              showText(),
              style: TextStyle(color: Colors.white, fontSize: 32),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(padNumber: "7", onTap: () => numberTapped(7)),
                CircleButton(padNumber: "8", onTap: () => numberTapped(8)),
                CircleButton(padNumber: "9", onTap: () => numberTapped(9)),
                CircleButton(padNumber: "%", onTap: () => operatorTapped("%")),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(padNumber: "4", onTap: () => numberTapped(4)),
                CircleButton(padNumber: "5", onTap: () => numberTapped(5)),
                CircleButton(padNumber: "6", onTap: () => numberTapped(6)),
                CircleButton(padNumber: "x", onTap: () => operatorTapped("x")),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(padNumber: "1", onTap: () => numberTapped(1)),
                CircleButton(padNumber: "2", onTap: () => numberTapped(2)),
                CircleButton(padNumber: "3", onTap: () => numberTapped(3)),
                CircleButton(padNumber: "-", onTap: () => operatorTapped("-")),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(padNumber: "C", onTap: () => clearNumber()),
                CircleButton(padNumber: "0", onTap: () => numberTapped(0)),
                CircleButton(padNumber: "=", onTap: () => calculateResult(), color: Colors.grey,),
                CircleButton(padNumber: "+", onTap: () => operatorTapped("+")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}