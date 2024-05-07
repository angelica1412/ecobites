import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadBarang extends StatefulWidget {
  @override
  _UploadBarangState createState() => _UploadBarangState();
}

class _UploadBarangState extends State<UploadBarang> {
  String? _selectedQuantity;
  List<String> _quantities = ['1', '2', '3', '4', '5'];

  String? _selectedDiscount;
  List<String> _discountOptions = ['100%', '90%', '50%'];

  String? _selectedCategory;
  List<String> _categoryOptions = [
    'Makanan',
    'Daur Ulang',
    'Bahan Daur Ulang',
  ];

  final _hargaAsliController = TextEditingController();
  final _hargaDiskonController = TextEditingController();

  bool _hargaAsliFieldFocused = false;
  File? _imageFile;

  @override
  void dispose() {
    _hargaAsliController.dispose();
    _hargaDiskonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Barang'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Gambar Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: Text('Pilih dari Galeri'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    child: Text('Ambil Foto'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Nama Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nama Barang',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jumlah Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                hint: Text('Pilih Jumlah Barang'),
                value: _selectedQuantity,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedQuantity = newValue;
                  });
                },
                items: _quantities.map((quantity) {
                  return DropdownMenuItem(
                    child: new Text(quantity),
                    value: quantity,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Harga Asli Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _hargaAsliController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  hintText: 'Harga Asli',
                  errorText: _hargaAsliFieldFocused &&
                          _hargaAsliController.text.isEmpty
                      ? '*required number'
                      : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _hargaAsliFieldFocused = true;
                  });
                },
                onChanged: (value) {
                  calculateDiscountedPrice();
                },
              ),
              SizedBox(height: 20),
              Text(
                'Potongan Harga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                hint: Text('Pilih Potongan'),
                value: _selectedDiscount,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDiscount = newValue;
                    calculateDiscountedPrice();
                  });
                },
                items: _discountOptions.map((discount) {
                  return DropdownMenuItem(
                    child: new Text(discount),
                    value: discount,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Harga Barang setelah Diskon',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              Text(
                'Rp. ${_hargaDiskonController.text}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Kategori Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                hint: Text('Pilih Kategori Barang'),
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: _categoryOptions.map((category) {
                  return DropdownMenuItem(
                    child: new Text(category),
                    value: category,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Deskripsi Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Deskripsi',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
  onPressed: () {
    // Hapus gambar yang dipilih saat tombol submit ditekan
    setState(() {
      _imageFile = null;
    });

    // Mengosongkan semua data input
    setState(() {
      _selectedQuantity = null;
      _selectedCategory = null;
      _hargaAsliController.clear();
      _hargaDiskonController.clear();
      _selectedDiscount = null;
    });

    // Menampilkan popup berhasil
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sukses'),
          content: Text('Data berhasil ditambahkan.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(color: Colors.black),
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Submit',
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  ),
),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void calculateDiscountedPrice() {
    if (_selectedDiscount != null && _hargaAsliController.text.isNotEmpty) {
      double hargaAsli =
          double.parse(_hargaAsliController.text.replaceAll(',', ''));
      double discountPercentage =
          double.parse(_selectedDiscount!.replaceAll('%', ''));
      double hargaSetelahDiskon =
          hargaAsli - (hargaAsli * (discountPercentage / 100));
      _hargaDiskonController.text = hargaSetelahDiskon.toStringAsFixed(2);
    }
  }
}
