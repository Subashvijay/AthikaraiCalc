import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({
    Key? key,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final List _tenureTypes = ["Months", "Years"];
  String _tenureType = "Months";
  // String _totalAmount = "";
  // String _totalInterest = "";
  final TextEditingController amount = TextEditingController();
  final TextEditingController months = TextEditingController();
  final TextEditingController rate = TextEditingController();

  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _input("Amount", amount),
          _periodInput(months),
          _input("Interest", rate),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {},
                child: const Text('Calculate'),
              ),
              _buttons("Reset"),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(3),
            },
            border: TableBorder.all(color: Colors.blue, width: 2),
            children: [
              TableRow(children: [
                _totalHeader("No"),
                _totalHeader("Interest"),
                _totalHeader("Total Amount"),
                _totalHeader("Outstanding"),
              ]),
              for (int i = 1; i <= 5; i++)
                TableRow(children: [
                  Text(amount.text.toString()),
                  Text(i.toString()),
                  Text(i.toString()),
                  Text(i.toString()),
                ]),
            ],
          )
        ],
      ),
    );
  }

  Column _totalHeader(String name) {
    return Column(children: [
      Text(name,
          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
    ]);
  }

  TextButton _buttons(String buttonName) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.blue,
      ),
      onPressed: () {
        if (buttonName == "Reset") {
          rate.clear();
          months.clear();
          amount.clear();
        }
      },
      child: Text(buttonName),
    );
  }

  Row _periodInput(TextEditingController months) {
    return Row(
      children: [
        Flexible(flex: 5, child: _input(_tenureType, months)),
        Flexible(
            flex: 1,
            child: Column(
              children: [
                Text(_tenureType,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                    value: _switchValue,
                    onChanged: (bool value) {
                      if (value) {
                        _tenureType = _tenureTypes[1];
                      } else {
                        _tenureType = _tenureTypes[0];
                      }
                      setState(() {
                        _switchValue = value;
                      });
                    })
              ],
            ))
      ],
    );
  }

  Container _input(String value, TextEditingController val) => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: TextField(
          controller: val,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: (value),
              suffixIcon: IconButton(
                  onPressed: () {
                    if (value == "Amount") {
                      amount.clear();
                    } else if (value == "Months" || value == "Years") {
                      months.clear();
                    } else if (value == "Interest") {
                      rate.clear();
                    }
                  },
                  icon: const Icon(Icons.clear))),
          keyboardType: TextInputType.number,
        ),
      );
}
