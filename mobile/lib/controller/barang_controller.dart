import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/model/barang.dart';
import 'package:mobile/service/api.dart';
import 'package:http/http.dart' as http;

class BarangController extends GetxController {
  var isLoading = true.obs;
  var total = 0.obs;
  var totalHarga = 0.obs;
  var totalStok = 0.obs;
  var isValid = false.obs;

  TextEditingController namaBarangTextController = TextEditingController();
  TextEditingController kategoriTextController = TextEditingController();
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
    kategoriTextController.dispose();
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
}
