import 'dart:convert';

import 'package:arac_kiralama_app/rezervasyon_al.dart';
import 'package:flutter/material.dart';
import 'Models/arac.dart';

class Details extends StatelessWidget {
  Color color;
  AracId arac;

  Details(this.arac, this.color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.color,
        elevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: this.color,
          ),
          child: ListView(
            children: [
              Hero(
                tag: arac.id,
                child: Image.network(
                  arac.aracImagePath,
                  scale: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          arac.aracMarkaName,
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                        Text(
                          arac.aracModelName,
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: CircleAvatar(
                        child: Text("Logo"),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          arac.aracFiyat.toString() + " TL",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "/day",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ButtonTheme(
                    minWidth: 180,
                    height: 75,
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => RezervasyonAl(arac)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Book Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                          )
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.people_alt_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Arac",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Kisi",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Kpst",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            arac.aracBilgiler.aracKisiKapasite,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Arac",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Esya",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Kpst",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            arac.aracBilgiler.aracEsyaKapasite,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.speed,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Arac",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Vites",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Turu",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            arac.aracBilgiler.aracVitesTuru,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.local_gas_station_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Arac",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Yakıt",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Turu",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            arac.aracBilgiler.aracYakitTuru,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ]),
              )
            ],
          )),
    );
  }
}
