import 'package:flutter/material.dart';
import 'package:mobile/controller/barang_controller.dart';
import 'package:mobile/helper/format.dart';

class CostumTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final String errorText;
  final Key formKey;
  final bool isHarga;
  final TextInputType keyboardType;
  final void Function(String)? onChange;

  const CostumTextForm({
    required this.title,
    required this.hintText,
    required this.controller,
    this.isHarga = false,
    this.onChange,
    this.errorText = 'Harus diisi',
    this.keyboardType = TextInputType.text,
    required this.formKey,
    super.key,
  });

  @override
  State<CostumTextForm> createState() => _CostumTextFormState();
}

class _CostumTextFormState extends State<CostumTextForm> {
  BarangController barangController = BarangController();
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
          ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isValid ? Color.fromRGBO(216, 220, 224, 1) : Colors.red, width: 1),
            ),

            child: TextFormField(
              key: widget.key,
              onChanged: widget.onChange,
              controller: widget.controller,
              inputFormatters: [
                if(widget.isHarga)
                CurrencyInputFormatter()
              ],
              validator: (data) {
                if (data == null || data.isEmpty) {
                  setState(() {
                    isValid = false;
                  });
                  return '';
                } else {
                  setState(() {
                    isValid = true;
                  });
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Color.fromRGBO(32, 35, 39, 1)),
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Color.fromRGBO(104, 119, 141, 1)),
                errorStyle: TextStyle(height: 0, fontSize: 0),
              ),
            ),
          ),
          if (!isValid)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.error, size: 12, color: Colors.red),
                ),
                Text(
                  widget.errorText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.red),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
