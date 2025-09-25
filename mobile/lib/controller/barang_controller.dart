import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/model/barang.dart';
import 'package:mobile/model/kategori_barang.dart';
import 'package:mobile/service/api.dart';
import 'package:http/http.dart' as http;

class BarangController extends GetxController {
  var isLoading = true.obs;
  var total = 0.obs;
  var totalHarga = 0.obs;
  var totalStok = 0.obs;
  var isValid = false.obs;
  var selectedKategori = 0.obs;

  TextEditingController namaBarangTextController = TextEditingController();
  TextEditingController kelompokTextController = TextEditingController();
  TextEditingController hargaTextController = TextEditingController();
  TextEditingController stokTextController = TextEditingController();

  @override
  void onInit() {
    fetchBarang(1, 10);
    super.onInit();
  }

  @override
  void onClose() {
    namaBarangTextController.dispose();
    kelompokTextController.dispose();
    hargaTextController.dispose();
    stokTextController.dispose();
    super.onClose();
  }

  Future<List<Barang>> fetchBarang(int page, int limit) async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/barang?page=$page&limit=$limit');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var data = BarangResponse.fromJson(map);
        total(data.meta?.total ?? 0);
        totalHarga(data.meta?.totalHarga ?? 0);
        totalStok(data.meta?.totalStok ?? 0);
        return data.data!;
      }
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<List<Kategori>> fetchKategory(int page, int limit) async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/kategori-barang?page=$page&limit=$limit');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var data = KategoriResponse.fromJson(map);
        return data.data!;
      }
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<bool> createBarang() async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/barang');

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': namaBarangTextController.text,
          'kelompok_barang': kelompokTextController.text,
          'harga': int.parse(hargaTextController.text),
          'stok': int.parse(stokTextController.text),
          'kategori_id': selectedKategori.value,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } finally {
      isLoading(false);
    }
  }
}
