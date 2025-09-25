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
  var kelompokBarang = ''.obs;

  TextEditingController namaBarangTextController = TextEditingController();
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
          'kelompok_barang': kelompokBarang.value,
          'harga': int.parse(hargaTextController.text.numericOnly()),
          'stok': int.parse(stokTextController.text),
          'kategori_id': selectedKategori.value,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<Barang?>? getDetailBarang(int id) async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/barang/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var data = Barang.fromJson(map);
        return data;
      }
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteDetail(int id) async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/barang/$id/delete');
      print(url);
      var response = await http.delete(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteAll(List<int> id) async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/barang/delete-all');
      var response = await http.delete(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({'id': id}));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> updateBarang(int id) async {
    try {
      isLoading(true);
      var url = Uri.parse('${APIService.baseUrl}/barang/$id');
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': namaBarangTextController.text,
          'kelompok_barang': kelompokBarang.value,
          'harga': int.parse(hargaTextController.text.numericOnly()),

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
