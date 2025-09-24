import 'package:mobile/model/kategori_barang.dart';

class BarangResponse {
  List<Barang>? data;
  Pagination? meta;

  BarangResponse({this.data, this.meta});

  factory BarangResponse.fromJson(Map<String, dynamic> json) {
    return BarangResponse(
      data: (json['data'] as List<dynamic>?)?.map((e) => Barang.fromJson(e as Map<String, dynamic>)).toList(),
      meta: json['meta'] != null ? Pagination.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class Barang {
  int? id;
  String? nama;
  int? harga;
  int? stok;
  Kategori? kategori;
  String? kelompokBarang;

  Barang({this.id, this.nama, this.harga, this.stok, this.kategori, this.kelompokBarang});

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      stok: json['stok'],
      kategori: json['kategori'] != null ? Kategori.fromJson(json['kategori']) : null,
      kelompokBarang: json['kelompokBarang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'kategori': kategori?.toJson(),
      'kelompokBarang': kelompokBarang,
    };
  }
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalHarga;
  int? totalStok;
  int? totalPage;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPage,
    this.totalHarga,
    this.totalStok,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalHarga: json['totalHarga'],
      totalStok: json['totalStok'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'limit': limit,
      'totalPage': totalPage,
    };
  }
}
