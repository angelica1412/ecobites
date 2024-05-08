import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadBarang extends StatefulWidget {
  const UploadBarang({super.key});

  @override
  _UploadBarangState createState() => _UploadBarangState();
}

class _UploadBarangState extends State<UploadBarang> {
  String? _selectedQuantity;
  final List<String> _quantities = ['1', '2', '3', '4', '5'];

  String? _selectedDiscount;
  final List<String> _discountOptions = ['100%', '90%', '50%'];

  String? _selectedCategory;
  final List<String> _categoryOptions = [
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
        title: const Text('Upload Barang'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Gambar Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: const Text('Pilih dari Galeri'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    child: const Text('Ambil Foto'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Nama Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              const TextField(
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
              const SizedBox(height: 20),
              const Text(
                'Jumlah Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                hint: const Text('Pilih Jumlah Barang'),
                value: _selectedQuantity,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedQuantity = newValue;
                  });
                },
                items: _quantities.map((quantity) {
                  return DropdownMenuItem(
                    value: quantity,
                    child: Text(quantity),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Harga Asli Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
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
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
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
              const SizedBox(height: 20),
              const Text(
                'Potongan Harga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                hint: const Text('Pilih Potongan'),
                value: _selectedDiscount,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDiscount = newValue;
                    calculateDiscountedPrice();
                  });
                },
                items: _discountOptions.map((discount) {
                  return DropdownMenuItem(
                    value: discount,
                    child: Text(discount),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Harga Barang setelah Diskon',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp. ${_hargaDiskonController.text}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kategori Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                hint: const Text('Pilih Kategori Barang'),
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: _categoryOptions.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Deskripsi Barang',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              const TextField(
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
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
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
                            title: const Text('Sukses'),
                            content: const Text('Data berhasil ditambahkan.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(0.0),
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
