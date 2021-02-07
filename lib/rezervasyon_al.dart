import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'Models/arac.dart';
import 'Models/kisi.dart';

class RezervasyonAl extends StatefulWidget {
  AracId arac;

  RezervasyonAl(this.arac);

  @override
  _RezervasyonAlState createState() => _RezervasyonAlState();
}

class _RezervasyonAlState extends State<RezervasyonAl> {
  DateTime firstDate = DateTime.now();
  DateTime endDate = DateTime(2022);
  String isim;

  String soyisim;

  String telefon;

  String tc;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.arac.id,
                child: Image.network(
                  widget.arac.aracImagePath,
                  scale: 0.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                      child: Text(
                    "Araç Rezervasyon",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.arac.aracMarkaName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          widget.arac.aracModelName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.arac.aracFiyat.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "/day",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Başlangıc Tarihini Seçiniz:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () => _selectFirstDate(context),
                        // Refer step 3
                        child: Text(
                          formatDate(firstDate, [dd, '/', mm, '/', yyyy]),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.transparent,
                        elevation: 0,
                      ),
                      Center(
                        child: Text(
                          "Bitiş Tarihini Seçiniz:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () =>
                            _selectEndDate(context), // Refer step 3
                        child: Text(
                          formatDate(endDate, [dd, '/', mm, '/', yyyy]),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.transparent,
                        elevation: 0,
                      ),
                      Text(
                        "İsminiz:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (deger) => isim = deger,
                      ),
                      Text(
                        "Soy İsminiz:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (deger) => soyisim = deger,
                      ),
                      Text(
                        "Tc niz :",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (deger) => tc = deger,
                      ),
                      Text(
                        "Telefon Numaraniz:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (deger) => telefon = deger,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            final http.Response response = await http.post(
                              'https://carrentalapi.herokuapp.com/api/kisis',
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, dynamic>{
                                "kisiAd": isim,
                                "kisiSoyad": soyisim,
                                "kisiTc": tc,
                                "kisiTelefon": telefon,
                              }),
                            );

                            if (response.statusCode == 201) {
                              KisiId kisi =
                                  KisiId.fromJson(json.decode(response.body));
                              final http.Response response2 = await http.post(
                                'https://carrentalapi.herokuapp.com/api/rezervasyons',
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "rezervBaslangicTarihi":
                                      firstDate.toIso8601String(),
                                  "rezervBitisTarihi":
                                      endDate.toIso8601String(),
                                  "aracId": "/api/aracs/${widget.arac.id}",
                                  "kisiId": "/api/kisis/${kisi.id}"
                                }),
                              );

                              if (response2.statusCode == 201) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _alertDialog);
                                _formKey.currentState.reset();
                              } else {}
                            } else {}
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get _alertDialog {
    return AlertDialog(
      title: const Text('Rezervasyon Başarılı'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Aracınızı teslim almak için başlangıç tarihinde şubemize gelebilirsiniz"),
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

  _selectFirstDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != firstDate)
      setState(() {
        firstDate = picked;
      });
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }
}
