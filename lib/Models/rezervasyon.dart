import 'arac.dart';
import 'kisi.dart';

class Rezervasyon {
  int id;
  String rezervBaslangicTarihi;
  String rezervBitisTarihi;
  AracId aracId;
  KisiId kisiId;

  Rezervasyon(
      {this.id,
        this.rezervBaslangicTarihi,
        this.rezervBitisTarihi,
        this.aracId,
        this.kisiId});

  Rezervasyon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rezervBaslangicTarihi = json['rezerv_baslangic_tarihi'];
    rezervBitisTarihi = json['rezerv_bitis_tarihi'];
    aracId =
    json['arac_id'] != null ? new AracId.fromJson(json['arac_id']) : null;
    kisiId =
    json['kisi_id'] != null ? new KisiId.fromJson(json['kisi_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rezerv_baslangic_tarihi'] = this.rezervBaslangicTarihi;
    data['rezerv_bitis_tarihi'] = this.rezervBitisTarihi;
    if (this.aracId != null) {
      data['arac_id'] = this.aracId.toJson();
    }
    if (this.kisiId != null) {
      data['kisi_id'] = this.kisiId.toJson();
    }
    return data;
  }
}


