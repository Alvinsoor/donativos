import 'package:donativos/donativos.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _donation_total = 0.0;
  double? _donation_dropdown;
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
              title: Text("${item.value}"),
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
              trailing: DropdownButton<double>(
                  hint: Text(" "),
                  value: _donation_dropdown,
                  items: <double>[
                    0.0,
                    1.0,
                    5.0,
                    10.0,
                    20.0,
                    50.0,
                    100.0,
                    200.0,
                    500.0,
                    1000.0,
                    10000.0
                  ].map((double value) {
                    return new DropdownMenuItem<double>(
                      value: value,
                      child: new Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _donation_dropdown = newVal;
                    });
                  }),
            ),
            LinearPercentIndicator(
              lineHeight: 25.0,
              backgroundColor: Colors.white10,
              animation: true,
              animateFromLastPercent: true,
              percent: _donation_total! / 10000 > 1.0
                  ? 1.0
                  : _donation_total! / 10000,
              progressColor:
                  (_donation_total! > 0) ? Colors.purple[300] : Colors.white10,
              center: (_donation_total! / 100 < 100)
                  ? Text(
                      (_donation_total! / 100).toString() + "%",
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    )
                  : Text(
                      "100%",
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
            ),
            ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                child: Text(
                  'Donar',
                  style: TextStyle(fontSize: 20, fontFamily: 'RobotoMono'),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1500, 50)),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Donativos(
                      donativos: {
                        "paypal": 0.0,
                        "tarjeta": 0.0,
                        "acumulado": 0.0,
                        "goalMet": false
                      },
                    )),
          );
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
