
class KisiId {
  int id;
  String kisiAd;
  String kisiSoyad;
  String kisiTc;
  String kisiTelefon;

  KisiId({this.id, this.kisiAd, this.kisiSoyad, this.kisiTc, this.kisiTelefon});

  KisiId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kisiAd = json['kisi_ad'];
    kisiSoyad = json['kisi_soyad'];
    kisiTc = json['kisi_tc'];
    kisiTelefon = json['kisi_telefon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kisi_ad'] = this.kisiAd;
    data['kisi_soyad'] = this.kisiSoyad;
    data['kisi_tc'] = this.kisiTc;
    data['kisi_telefon'] = this.kisiTelefon;
    return data;
  }
}