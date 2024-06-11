import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/authenticate/Controller/storeController.dart';
import 'package:image_picker/image_picker.dart';

import 'Widgets/customTextfield.dart';

class EditStorePage extends StatefulWidget {
  final String storeID;

  const EditStorePage({Key? key, required this.storeID}) : super(key: key);

  @override
  _EditStorePageState createState() => _EditStorePageState();
}

class _EditStorePageState extends State<EditStorePage> {
  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  String? _imageURL;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchStoreData();
  }

  Future<void> _fetchStoreData() async {
    setState(() {
      _isLoading = true;
    });
    final storeData = await getStorebyID(widget.storeID);
    if (storeData != null) {
      setState(() {
        _storeNameController.text = storeData['namaToko'] ?? '';
        _addressController.text = storeData['alamat'] ?? '';
        _descriptionController.text = storeData['deskripsi'] ?? '';
        _imageURL = storeData['imageURL']?? 'assets/shop.png';
        _isLoading = false;
      });
    } else {
      // Handle the case where the store data could not be fetched
      print('Failed to fetch store data');
      setState(() {
        _isLoading = false;
      });
    }
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

  Future<void> _saveStoreData() async {
    setState(() {
      _isLoading = true;
    });
    await updateStorebyID(widget.storeID, {
      'namaToko': _storeNameController.text,
      'alamat': _addressController.text,
      'deskripsi': _descriptionController.text,
      // Add other fields as needed
    }, _imageFile);

    // Show a success message or navigate back to the previous screen
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Informasi Toko'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _isLoading ? null : _saveStoreData,
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Gambar Toko',
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
                )
              else if(_imageURL != null)
                Image.network(
                  _imageURL!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 120,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .white24, // Change background color as desired
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
                          .white24, // Change background color as desired
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
                'Nama Toko',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _storeNameController,
                hintText: "Masukkan Nama Toko",
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              const Text(
                'Alamat Toko',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _addressController,
                hintText: "Masukkan Alamat Toko",
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              const Text(
                'Deskripsi Toko',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _descriptionController,
                hintText: "Masukkan Deskripsi Toko",
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              // Add fields for other information (e.g., logo) if needed
            ],
          ),
        ),
      ),
    );
  }
}
