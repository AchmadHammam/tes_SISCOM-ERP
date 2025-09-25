import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/component/dropdown.dart';
import 'package:mobile/component/text_input.dart';
import 'package:mobile/controller/barang_controller.dart';
import 'package:mobile/helper/format.dart';
import 'package:mobile/model/barang.dart';
import 'package:mobile/view/home_page.dart';

class EditBarangPage extends StatefulWidget {
  final Barang data;
  const EditBarangPage({super.key, required this.data});

  @override
  State<EditBarangPage> createState() => _EditBarangPageState();
}

class _EditBarangPageState extends State<EditBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final BarangController barangController = BarangController();
  @override
  void initState() {
    barangController.namaBarangTextController.text = widget.data.nama!;
    barangController.hargaTextController.setNumericValue(widget.data.harga ?? 0);
    barangController.stokTextController.text = widget.data.stok.toString();
    barangController.selectedKategori(widget.data.kategori!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.005),
          child: Obx(
            () => ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  barangController.updateBarang(widget.data.id!);
                  Get.to(() => const HomePage());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: barangController.isValid.value ? Color.fromRGBO(0, 23, 103, 1) : Color.fromRGBO(216, 220, 224, 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Simpan',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Text('Edit Barang', style: TextTheme.of(context).titleMedium),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.02),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CostumTextForm(
                  title: 'Nama Barang*',
                  hintText: 'Masukkan nama barang',
                  controller: barangController.namaBarangTextController,
                  errorText: 'Nama barang harus diisi',
                  formKey: _formKey,
                  onChange: (value) => barangController.isValid.value = _formKey.currentState?.validate() ?? false,
                ),
                CostumAsyncDropdown(barangController: barangController, initalValue: widget.data.kategori),
                CostumDropdown(barangController: barangController, initalValue: widget.data.kelompokBarang),
                CostumTextForm(
                  title: 'Stok Barang*',
                  hintText: 'Masukkan stok barang',
                  errorText: 'Stok barang harus diisi',
                  controller: barangController.stokTextController,
                  formKey: _formKey,
                  keyboardType: TextInputType.number,
                  onChange: (value) => barangController.isValid.value = _formKey.currentState?.validate() ?? false,
                ),
                CostumTextForm(
                  title: 'Harga Barang*',
                  hintText: 'Masukkan harga barang',
                  errorText: 'Harga barang harus diisi',
                  controller: barangController.hargaTextController,
                  keyboardType: TextInputType.number,
                  isHarga: true,
                  formKey: _formKey,
                  onChange: (value) => barangController.isValid.value = _formKey.currentState?.validate() ?? false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
