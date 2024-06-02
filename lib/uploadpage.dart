import 'dart:io';

import 'package:ecobites/Widgets/customTextfield.dart';
import 'package:ecobites/historypage.dart';
import 'package:ecobites/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  String? _selectedQuality;
  final List<String> _quality = [
    'Sangat Baik',
    'Baik',
    'Kurang Baik',
    'Buruk',
  ];

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

  String? _selectedUnit;
  final List<String> _unitOptions = ['Kg', 'g'];

  final _hargaAsliController = TextEditingController();
  final _hargaDiskonController = TextEditingController();
  final _namaBarang = TextEditingController();
  final _deskBarang = TextEditingController();

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
        title: const Text('Upload Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Upload Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'History',
          ),
        ],
        currentIndex: 1, // Set the current index to indicate the Upload tab
        onTap: (int index) {
          if (index == 0) {
            // Navigate to Home page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Ganti HomePage dengan halaman yang sesuai
            );
          } else if (index == 2) {
             // Navigate to Home page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()), // Ganti HomePage dengan halaman yang sesuai
            );
          }
        },
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
