import 'dart:io';

import 'package:ecobites/Widgets/customTextfield.dart';
import 'package:ecobites/authenticate/Controller/productController.dart';
import 'package:flutter/cupertino.dart';
// import 'package:ecobites/Widgets/SliderWithLabel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'Widgets/ProductCard.dart';
import 'historypage.dart';
import 'homepage.dart';

class UploadBarang extends StatefulWidget {
  const UploadBarang(
      {super.key,
      required this.fromHome,
      required this.fromUserToko,
      required this.isEdit,
      this.product,
        this.storeID,});
  final bool fromHome;
  final bool fromUserToko;
  final bool isEdit;
  final Product? product;
  final String? storeID;

  @override
  _UploadBarangState createState() => _UploadBarangState();
}

class _UploadBarangState extends State<UploadBarang> {
  bool _isLoading = false;

  String? _selectedQuality;
  final List<String> _quality = [
    'Sangat Baik',
    'Baik',
    'Kurang Baik',
    'Buruk',
  ];

  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );

  String? _selectedQuantity;
  final List<String> _quantities = ['1', '2', '3', '4', '5'];

  String? _selectedDiscount;
  final List<String> _discountOptions = ['100%', '90%', '50%'];

  String? _selectedCategory;
  final List<String> _categoryOptions = [
    'Food',
    'Bahan Daur',
    'Hasil Daur',
  ];

  String? _selectedUnit;
  final List<String> _unitOptions = ['pcs','porsi','Kg', 'g'];

  final TextEditingController _hargaAsliController = TextEditingController();
  final TextEditingController _hargaDiskonController = TextEditingController();
  final TextEditingController _namaBarang = TextEditingController();
  final TextEditingController _deskBarang = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _imageFile;

  Future<void> saveProductData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile == null ||
          _selectedQuantity == null ||
          _selectedUnit == null ||
          _selectedQuality == null ||
          _hargaAsliController.text.isEmpty ||
          _selectedDiscount == null ||
          _selectedCategory == null ||
          _deskBarang.text.isEmpty) {
        // Tampilkan pesan kesalahan jika ada bagian yang kosong
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Data Belum Lengkap'),
              content: const Text(
                  'Mohon lengkapi semua data sebelum menekan tombol Submit.'),
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
        return;
      }
      setState(() {
        _isLoading = true; // Set loading state to true
      });
      Map<String, dynamic> productData = {
        'namaBarang': _namaBarang.text.trim(),
        'jumlahBarang': _selectedQuantity,
        'satuanBarang': _selectedUnit,
        'kualitasBarang': _selectedQuality,
        'hargaAsliBarang': _hargaAsliController.text.trim(),
        'discount': _selectedDiscount,
        'hargaAkhirBarang': _hargaDiskonController.text.trim(),
        'kategoriBarang': _selectedCategory,
        'deskripsiBarang': _deskBarang.text.trim(),
      };

      await addProductToFireStore(widget.storeID, productData, _imageFile);
      setState(() {
        _isLoading = false; // Set loading state to false
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sukses'),
            content: const Text('Data berhasil ditambahkan.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.of(context).pop(true); // Kembali ke halaman sebelumnya
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

          @override
  void dispose() {
    _hargaAsliController.dispose();
    _hargaDiskonController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    if (widget.isEdit && widget.product != null) {
      _namaBarang.text = widget.product!.name;
      _deskBarang.text = widget.product!.description;
      _hargaAsliController.text = widget.product!.price.toString();
      _selectedCategory = widget.product!.category;
      _imageFile = File(widget.product!.imageURL); // Asumsi imageURL adalah path file lokal
      // Jika imageURL adalah URL online, Anda perlu menggunakan mekanisme yang berbeda untuk memuat gambar
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (_isLoading) {
          // Tampilkan pesan bahwa aplikasi sedang melakukan proses

          return false;
        } else {
          // Izinkan navigasi kembali jika tidak ada proses loading
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: widget.isEdit
                ? Text('Edit Barang',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))
                : const Text('Upload Barang',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true,
            leading: _isLoading
                ? null
                : widget.fromUserToko
                ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
                : null, // Berikan null jika tidak ada leading icon yang diinginkan
            automaticallyImplyLeading: !_isLoading, // Disable back button when loading
            elevation: 0,
            backgroundColor: const Color(0xFFFAFAFA),
          ),
          body: Stack(
            children: [
            IgnorePointer(
              ignoring: _isLoading,
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child:Column(
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .white24, // Ubah warna latar belakang sesuai keinginanmu
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.photo_library,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _pickImageFromCamera,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .white24, // Ubah warna latar belakang sesuai keinginanmu
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
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
                    CustomTextField(
                      controller: _namaBarang,
                      hintText: "Masukkan Nama Barang",
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
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
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            hint: const Text('Jumlah'),
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
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButton<String>(
                            hint: const Text('Satuan'),
                            value: _selectedUnit,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedUnit = newValue;
                              });
                            },
                            items: _unitOptions.map((unit) {
                              return DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
              
                    const SizedBox(height: 20),
                    // Kualitas Barang
                    const Text(
                      'Kualitas Barang',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      hint: const Text('Kualitas Barang'),
                      value: _selectedQuality,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedQuality = newValue;
                        });
                      },
                      items: _quality.map((quality) {
                        return DropdownMenuItem(
                          value: quality,
                          child: Text(quality),
                        );
                      }).toList(),
                    ),
              // Kualitas Barang end
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Harga Asli Barang',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _hargaAsliController,
                      hintText: "Harga Asli",
                      keyboardType: TextInputType.number,
                      prefixText: 'Rp. ',
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
                    Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Menggunakan lebar perangkat sebagai lebar kontainer
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Warna border
                          width: 1, // Lebar border (misal: 1% dari lebar perangkat)
                        ),
                        borderRadius: BorderRadius.circular(8), // Border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Rp. ${_hargaDiskonController.text}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
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
                    CustomTextField(
                      controller: _deskBarang,
                      keyboardType: TextInputType.text,
                      hintText: "Deskripsi Barang",
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 100),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 75,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Show confirmation popup
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: const Text(
                                          'Apakah Anda yakin ingin menghapus semua field?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Clear all fields
                                            setState(() {
                                              _imageFile = null;
                                              _selectedQuantity = null;
                                              _selectedCategory = null;
                                              _selectedUnit = null;
                                              _selectedQuality = null;
                                              _hargaAsliController.clear();
                                              _hargaDiskonController.clear();
                                              _namaBarang.clear();
                                              _deskBarang.clear();
                                              _selectedDiscount = null;
                                            });
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE57373),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
              
                          const SizedBox(width: 20), // Space between the buttons
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading? null: ()=> saveProductData(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF92E3A9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            ),
                          ),
                           SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              ),
                      ),
            ),
                  if (_isLoading)
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.5),
                      dismissible: false,
                    ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
      ]
          ),
      
          bottomNavigationBar: widget.fromHome
              ? BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.upload),
                      label: 'Upload',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.history),
                      label: 'Activity',
                    ),
                  ],
                  currentIndex: 1, // Menetapkan indeks saat ini ke halaman Upload
                  onTap: (int index) {
                    switch (index) {
                      case 0:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                        break;
                      case 1:
                        break;
                      case 2:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HistoryPage()),
                        ); // Pindah ke halaman History
                        break;
                    }
                  },
                  selectedItemColor: const Color(
                      0xFF92E3A9), // Mengubah warna item yang dipilih menjadi hijau
                  unselectedItemColor: Colors
                      .grey, // Mengubah warna item yang tidak dipilih menjadi abu-abu
                )
              : null),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
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
          double.parse(_hargaAsliController.text.replaceAll('.', ''));
      double discountPercentage =
          double.parse(_selectedDiscount!.replaceAll('%', ''));
      double hargaSetelahDiskon =
          hargaAsli - (hargaAsli * (discountPercentage / 100));
      _hargaDiskonController.text = _formatter.format(hargaSetelahDiskon);
    }
  }
}