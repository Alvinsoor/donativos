import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  final donativos;
  Donativos({Key? key, required this.donativos}) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donativos obtenidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/paypal.png"),
              trailing: Text(
                "${widget.donativos["paypal"] ?? 0.0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ListTile(
              leading: Image.asset("assets/credit-card.png"),
              trailing: Text(
                "${widget.donativos["tarjeta"] ?? 0.0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 2.0,
            ),
            ListTile(
              leading: Icon(
                Icons.money,
                size: 64,
                color: Colors.green,
              ),
              trailing: Text(
                "${widget.donativos["acumulado"] ?? 0.0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(child: Image.asset("assets/thank-you.png"))
          ],
        ),
      ),
    );
  }
}
