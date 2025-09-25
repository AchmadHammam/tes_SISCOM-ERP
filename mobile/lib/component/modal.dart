import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/barang_controller.dart';
import 'package:mobile/helper/format.dart';
import 'package:mobile/model/barang.dart';
import 'package:mobile/view/edit_barang_page.dart';

Future<void> showModalDetailBarang(BuildContext context, int id, BarangController barangController) async {
  return showModalBottomSheet(
    context: context,
    // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
    useSafeArea: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.02),
        child: FutureBuilder(
          future: barangController.getDetailBarang(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              Barang data = snapshot.data!;
              return Column(
                children: [
                  Image.network('https://placehold.co/600x400/png'),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.01),
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nama Barang  ',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                              Text(
                                data.nama!,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kategori  ',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                              Text(
                                data.kategori!.nama!,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kelompok  ',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                              Text(
                                data.kelompokBarang!,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga ',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                              Text(
                                formatCurrency(data.harga ?? 0),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),

                              //stock
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Stock ',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                              Text(
                                data.stok.toString(),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),

                          onPressed: () {
                            barangController.deleteDetail(data.id!);
                            Get.back();
                          },
                          child: Text(
                            'Hapus Data',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                          color: Color.fromRGBO(0, 23, 103, 1),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => EditBarangPage(data: data));
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                          child: Text(
                            'Edit Data',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      );
    },
  );
}
