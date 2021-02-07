import 'arac_bilgiler.dart';

class AracId {
  int id;
  String aracMarkaName;
  String aracModelName;
  int aracFiyat;
  bool aracOzelTeklif;
  int aracAdeti;
  AracBilgiler aracBilgiler;
  String aracImagePath;
  String blob ;

  AracId(
      {this.id,
        this.aracMarkaName,
        this.aracModelName,
        this.aracFiyat,
        this.aracOzelTeklif,
        this.aracAdeti,
        this.aracBilgiler,
        this.aracImagePath,
        this.blob});

  AracId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aracMarkaName = json['arac_marka_name'];
    aracModelName = json['arac_model_name'];
    aracFiyat = json['arac_fiyat'];
    aracOzelTeklif = json['arac_ozel_teklif'];
    aracAdeti = json['arac_adeti'];
    aracBilgiler = json['arac_bilgiler'] != null
        ? new AracBilgiler.fromJson(json['arac_bilgiler'])
        : null;
    aracImagePath = json['arac_image_path'];
    blob = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arac_marka_name'] = this.aracMarkaName;
    data['arac_model_name'] = this.aracModelName;
    data['arac_fiyat'] = this.aracFiyat;
    data['arac_ozel_teklif'] = this.aracOzelTeklif;
    data['arac_adeti'] = this.aracAdeti;
    if (this.aracBilgiler != null) {
      data['arac_bilgiler'] = this.aracBilgiler.toJson();
    }
    data['arac_image_path'] = this.aracImagePath;
    data['image'] = this.blob;
    return data;
  }
}