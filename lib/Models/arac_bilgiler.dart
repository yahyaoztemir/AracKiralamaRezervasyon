class AracBilgiler {
  int id;
  String aracKisiKapasite;
  String aracEsyaKapasite;
  String aracVitesTuru;
  String aracYakitTuru;

  AracBilgiler(
      {this.id,
        this.aracKisiKapasite,
        this.aracEsyaKapasite,
        this.aracVitesTuru,
        this.aracYakitTuru});

  AracBilgiler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aracKisiKapasite = json['arac_kisi_kapasite'];
    aracEsyaKapasite = json['arac_esya_kapasite'];
    aracVitesTuru = json['arac_vites_turu'];
    aracYakitTuru = json['arac_yakit_turu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arac_kisi_kapasite'] = this.aracKisiKapasite;
    data['arac_esya_kapasite'] = this.aracEsyaKapasite;
    data['arac_vites_turu'] = this.aracVitesTuru;
    data['arac_yakit_turu'] = this.aracYakitTuru;
    return data;
  }
}