import 'dart:convert';

import 'package:arac_kiralama_app/Models/rezervasyon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RezervasyonKontrol extends StatefulWidget {
  @override
  _RezervasyonKontrolState createState() => _RezervasyonKontrolState();
}

class _RezervasyonKontrolState extends State<RezervasyonKontrol> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rezervasyon Kontrol")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lütfen Tc Kimlik Numaranizi Giriniz",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                autofocus: false,
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.purple,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(onPressed: onPressed, child: Text("Kontrol Et")),
          ],
        ),
      ),
    );
  }

  onPressed() async {
    var response =
        await http.get("https://carrentalapi.herokuapp.com/api/rezervasyons");
    if (response.statusCode == 200) {
      var rezervYok = true ;
      List<Rezervasyon> list = (json.decode(response.body) as List)
          .map((tekGonderiMap) => Rezervasyon.fromJson(tekGonderiMap))
          .toList();
      list.forEach((element) {
        if (element.kisiId.kisiTc == _controller.value.text) {
          rezervYok = false ;
          showDialog(
              context: context, builder: (context) => getAlertDialog(element));
        }
      });
      if(rezervYok){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Maalesef Rezervasyonunuz Yok!!"),
            ));
      }

    } else {
      debugPrint("StatusCode 200 degil" + response.statusCode.toString());
      return null;
    }
  }

  Widget getAlertDialog(Rezervasyon element) {
    return AlertDialog(
      title: const Text('Rezervasyonunuz Mevcut'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Kisi Adi " + element.kisiId.kisiAd),
          Text("Kisi Soyad : " + element.kisiId.kisiSoyad),
          Text("Başlangıc Tarihi : " +
              element.rezervBaslangicTarihi.substring(0, 10)),
          Text("Bitiş Tarihi : " + element.rezervBitisTarihi.substring(0, 10)),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
