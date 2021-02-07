import 'package:arac_kiralama_app/rezervasyon_kontrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'Models/arac.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:filter_list/filter_list.dart';
import 'arac_card.dart';

class AnaSayfa extends StatefulWidget {
  List<AracId> aracListesi = [];
  List<String> markaListesi = [];
  List<String> seciliMarkaListesi = [];

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Color> list = [
    Color(0xFFb1bcd4),
    Color(0xFF0118fe),
    Color(0xFF4e5057),
    Color(0xFF2450e1),
    Color(0xFFa5acba),
    Color(0xFF5b88b8)
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => araclariGetir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getAppBar(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [getActions(context)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          filterRow(),
          SizedBox(
            height: 20,
          ),
          filterResultList(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: getBody(),
          ),
        ]),
      ),
    );
  }

  Container getAppBar() {
    return Container(
      width: 180,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.car_rental,
              color: Colors.black,
              size: 36,
            ),
            Text(
              "Araç Kirala ! ",
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Padding getActions(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RezervasyonKontrol()));
        },
      ),
    );
  }

  Widget getBody() {
    return widget.aracListesi.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: widget.aracListesi
                .where(
                    (e) => widget.seciliMarkaListesi.contains(e.aracMarkaName))
                .toList()
                .length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  AracCard(
                    widget.aracListesi
                        .where((e) =>
                            widget.seciliMarkaListesi.contains(e.aracMarkaName))
                        .toList()[index],
                    list[Random().nextInt(6)],
                  ),
                  if (index !=
                      widget.aracListesi
                              .where((e) => widget.seciliMarkaListesi
                                  .contains(e.aracMarkaName))
                              .toList()
                              .length -
                          1)
                    Divider(
                      height: 30,
                      thickness: 2.5,
                      color: Colors.blueAccent,
                    ),
                ],
              );
            },
          );
  }

  void araclariGetir() async {
    debugPrint("Methoda Girildi");
    var response =
        await http.get("https://carrentalapi.herokuapp.com/api/aracs");
    if (response.statusCode == 200) {
      setState(() {
        widget.aracListesi = (json.decode(response.body) as List)
            .map((tekGonderiMap) => AracId.fromJson(tekGonderiMap))
            .toList();
        widget.markaListesi =
            widget.aracListesi.map((e) => e.aracMarkaName).toSet().toList();
        widget.seciliMarkaListesi = List.from(widget.markaListesi);
      });
    } else {
      debugPrint("StatusCode 200 degil" + response.statusCode.toString());
      return null;
    }
  }

  Widget filterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "choose",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              "a car",
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
        ButtonTheme(
          minWidth: 50,
          height: 45,
          buttonColor: Colors.white,
          child: RaisedButton(
            elevation: 0,
            onPressed: () {
              _openFilterDialog();
            },
            child: Text(
              "Filters ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(color: Colors.grey)),
          ),
        ),
      ],
    );
  }

  void _openFilterDialog() async {
    await FilterListDialog.display(context,
        allTextList: widget.markaListesi,
        height: 480,
        borderRadius: 20,
        headlineText: "Select Count",
        searchFieldHintText: "Search Here",
        selectedTextList: widget.seciliMarkaListesi,
        onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          widget.seciliMarkaListesi = List.from(list);
          debugPrint("seciliMarkaListesi length : " +
              widget.seciliMarkaListesi.length.toString());
        });
      }
      Navigator.pop(context);
    });
  }

  Widget filterResultList() {
    return Container(
      height: 35,
      child: ListView.builder(
        itemCount: widget.seciliMarkaListesi.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: widget.seciliMarkaListesi[index].length.toDouble() * 12.0 +
                  24,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.24)),
              child: Center(
                child: Text(
                  widget.seciliMarkaListesi[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
