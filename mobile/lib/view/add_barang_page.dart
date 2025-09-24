import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/component/text_input.dart';
import 'package:mobile/controller/barang_controller.dart';

class AddBarangPage extends StatefulWidget {
  const AddBarangPage({super.key});

  @override
  State<AddBarangPage> createState() => _AddBarangPageState();
}

class _AddBarangPageState extends State<AddBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final BarangController barangController = BarangController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    barangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.005,
          ),
          child: Obx(
            () => ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: barangController.isValid.value ? Color.fromRGBO(0, 23, 103, 1) : Color.fromRGBO(216, 220, 224, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Simpan',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
        title: Text(
          'Tambah Barang',
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
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
                CostumTextForm(
                  title: 'Kategori Barang*',
                  hintText: 'Masukkan kategori barang',
                  errorText: 'Kategori barang harus diisi',
                  controller: barangController.kategoriTextController,
                  formKey: _formKey,
                  onChange: (value) => barangController.isValid.value = _formKey.currentState?.validate() ?? false,
                ),
                CostumTextForm(
                  title: 'Kelompok Barang*',
                  hintText: 'Masukkan kelompok barang',
                  errorText: 'Kelompok barang harus diisi',
                  controller: barangController.kelompokTextController,
                  formKey: _formKey,
                  onChange: (value) => barangController.isValid.value = _formKey.currentState?.validate() ?? false,
                ),
                CostumTextForm(
                  title: 'Stok Barang*',
                  hintText: 'Masukkan stok barang',
                  errorText: 'Stok barang harus diisi',
                  controller: barangController.stokTextController,
                  formKey: _formKey,
                  onChange: (value) => barangController.isValid.value = _formKey.currentState?.validate() ?? false,
                ),
                CostumTextForm(
                  title: 'Harga Barang*',
                  hintText: 'Masukkan harga barang',
                  errorText: 'Harga barang harus diisi',
                  controller: barangController.hargaTextController,
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
