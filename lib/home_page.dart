import 'package:donativos/donativos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: radioGroupGenerator(),
              ),
            )
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
