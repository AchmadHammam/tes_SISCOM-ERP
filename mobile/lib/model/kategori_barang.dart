import 'package:mobile/model/barang.dart';

class Kategori {
  int? id;
  String? nama;

  Kategori({this.id, this.nama});

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'],
      nama: json['nama'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
  
}
class KategoriResponse {
  List<Kategori>? data = <Kategori>[];
  Pagination? meta;

  KategoriResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Kategori>[];
      json['data'].forEach((v) {
        data!.add(Kategori.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Pagination.fromJson(json['meta']) : null;
  }
}
