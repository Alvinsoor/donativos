import 'package:donativos/donativos.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _donation_total = 0;

  int _paypal = 0;
  int _tarjeta = 0;
  int _acumulado = 0;
  bool _goalMet = false;

  int? _dropDownValue = null;
  var _dropDownGroup = {
    1: "1",
    10: "10",
    69: "69",
    100: "100",
    350: "350",
    999: "999",
    1000: "1000"
  };

  dropDownGen() {
    return _dropDownGroup.entries
        .map((item) => DropdownMenuItem(
              child: Text(item.value),
              value: item.key,
            ))
        .toList();
  }

  int? currentRadio;
  var assetsRadioGroup = {0: "assets/paypal.png", 1: "assets/credit-card.png"};
  var radioGroup = {0: "Paypal", 1: "Tarjeta"};
  radioGroupGenerator() {
    return radioGroup.entries
        .map((item) => ListTile(
              leading: Image.asset(
                assetsRadioGroup[item.key]!,
                height: 64,
                width: 24,
              ),
              title: Text(
                "${item.value}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Radio(
                value: item.key,
                groupValue: currentRadio,
                onChanged: (int? newSelectedRadio) {
                  currentRadio = newSelectedRadio;
                  setState(() {});
                },
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Es para una buena causa",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              subtitle: Text(
                "Elija un donativo",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: radioGroupGenerator(),
              ),
            ),
            Divider(
              thickness: 5.0,
            ),
            ListTile(
              leading: Text("Cantidad a donar: "),
              trailing: DropdownButton<int>(
                  hint: Text(" "),
                  value: _dropDownValue,
                  items: dropDownGen(),
                  onChanged: (newVal) {
                    setState(() {
                      _dropDownValue = newVal;
                    });
                  }),
            ),
            LinearPercentIndicator(
              lineHeight: 25.0,
              backgroundColor: Colors.white10,
              animation: true,
              animateFromLastPercent: true,
              percent: _acumulado / 10000 > 1.0 ? 1.0 : _acumulado / 10000,
              progressColor: (_acumulado > 0) ? Colors.purple : Colors.white10,
              center: (_acumulado / 100 < 100)
                  ? Text(
                      (_acumulado / 100).toString() + "%",
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    )
                  : Text(
                      "100%",
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  // Respond to button press
                  if (_dropDownValue != null) {
                    if (currentRadio == 0) {
                      _paypal += _dropDownValue!;
                      _acumulado += _dropDownValue!;
                    } else if (currentRadio == 1) {
                      _tarjeta += _dropDownValue!;
                      _acumulado += _dropDownValue!;
                    }

                    if (_acumulado >= 10000) {
                      _goalMet = true;
                    }
                  }
                  setState(() {});
                },
                child: Text(
                  'Donar',
                  style: TextStyle(fontSize: 20, fontFamily: 'RobotoMono'),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1500, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurple),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Donativos(
                      donativos: {
                        "paypal": _paypal,
                        "tarjeta": _tarjeta,
                        "acumulado": _acumulado,
                        "goalMet": _goalMet
                      },
                    )),
          );
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
