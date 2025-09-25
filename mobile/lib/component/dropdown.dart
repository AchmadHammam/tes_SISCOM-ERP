import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mobile/controller/barang_controller.dart';
import 'package:mobile/model/kategori_barang.dart';

class CostumDropdown extends StatefulWidget {
  const CostumDropdown({super.key, required this.barangController});

  final BarangController barangController;

  @override
  State<CostumDropdown> createState() => _CostumDropdownState();
}

class _CostumDropdownState extends State<CostumDropdown> {
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategori Barang*',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
          ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isValid ? Color.fromRGBO(216, 220, 224, 1) : Colors.red, width: 1),
            ),
            child: DropdownSearch<Kategori>(
              dropdownButtonProps: DropdownButtonProps(alignment: AlignmentGeometry.center),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Masukkan kategori barang',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                ),
                baseStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical(y: .05),
              ),
              asyncItems: (String? filter) async {
                final value = await widget.barangController.fetchKategory(1, 10);
                return value;
              },
              onChanged: (value) {
                widget.barangController.selectedKategori.value = value?.id ?? 0;
              },
              itemAsString: (item) {
                return item.nama ?? '';
              },
              validator: (value) {
                if (value == null) {
                  setState(() {
                    isValid = false;
                  });
                  return '';
                } else {
                  setState(() {
                    isValid = true;
                  });
                  return null;
                }
              },
            ),
          ),
          if (!isValid)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.error,
                    size: 12,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Kategori barang harus diisi',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                ),
              ],
            ),
        
        ],
      ),
    );
  }
}


