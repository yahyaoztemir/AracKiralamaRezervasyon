import 'package:arac_kiralama_app/rezervasyon_al.dart';
import 'details.dart';
import 'package:flutter/material.dart';

import 'Models/arac.dart';

class AracCard extends StatelessWidget {
  AracId arac;
  Color color;

  AracCard(this.arac, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: this.color,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Hero(
                  tag: arac.id,
                  child: Image.network(
                    arac.aracImagePath,
                    scale: 0.5,
                  ),
                  /* for blob : Image.memory(Base64Codec().decode(arac.blob),scale: 0.5,) */
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24.0, right: 24, bottom: 4, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      arac.aracMarkaName,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      arac.aracModelName,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      arac.aracFiyat.toString() + " TL",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "/day",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ButtonTheme(
                  height: 65,
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Details(this.arac, this.color)));
                    },
                    color: this.color,
                    child: Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(40)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  height: 65,
                  buttonColor: Colors.white,
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => RezervasyonAl(this.arac)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(40)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
