import 'package:ecobites/UploadBarang.dart';
import 'package:ecobites/authenticate/Controller/userController.dart';
import 'package:ecobites/editStorePage.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/Widgets/ProductCard.dart';
import 'package:ecobites/Widgets/category_button.dart';
import 'package:ecobites/Widgets/share_widget.dart';

import 'authenticate/Controller/storeController.dart';

class userStorePage extends StatefulWidget {
  final String storeID;
  const userStorePage({super.key, required this.storeID});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<userStorePage> {
  String _selectedCategory = 'Food';
  bool _searching = false;
  String searchQuery= "";
  final FocusNode _searchFocusNode = FocusNode();// Untuk melacak apakah sedang dalam mode pencarian
  bool _isLoading = true;
  Map<String, String> _storeData = {};



  void _setSelectedCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  Future<void> _fetchStoreData() async {
    setState(() {
      _isLoading = true; // Mulai memuat data
    });
    final storeData = await getStorebyID(widget.storeID);
    if (storeData != null) {
      setState(() {
        _storeData = storeData;
        _isLoading = false; // Data selesai dimuat
      });
    } else {
      // Handle the case where the store data could not be fetched
      print('Failed to fetch store data');
      setState(() {
        _isLoading = false; // Gagal memuat data
      });
    }
  }

  final TextEditingController _searchController = TextEditingController();

  List<Product> products = [
    Product(
      name: 'Martabak',
      description: 'Makanan yang terbuat dari telur dan daun bawang',
      price: 15000,
      imageURL: 'assets/martabak.jpg',
      category: 'Food',
    ),
    Product(
      name: 'Terang Bulan',
      description: 'Makanan yang manis dapat menambahkan mood',
      price: 20000,
      imageURL: 'assets/terangbulan.jpg',
      category: 'Food',
    ),
    Product(
      name: 'Pupuk Urea',
      description: 'Pupuk ini dapat mempercepat pertumbuhan tanaman',
      price: 5000,
      imageURL: 'assets/pupukurea.jpg',
      category: 'Hasil Daur',

    ),
    Product(
      name: 'Roti Berjamur',
      description: 'Bahan ini dapat digunakan sebagai bahan daur pupuk untuk tanaman tomat ',
      price: 7000,
      imageURL: 'assets/rotiberjamur.jpg',
      category: 'Bahan Daur',

    ),
    Product(
      name: 'Pisang Goreng',
      description: 'Description for Product 2',
      price: 2000,
      imageURL: 'assets/product1.png',
      category: 'Food',
    ),
    Product(
      name: 'Pupuk',
      description: 'Pupuk yang tinggi kualitas karbon',
      price: 1000,
      imageURL: 'assets/pupuk.png',
      category: 'Hasil Daur',
    ),
    Product(
      name: 'Sosis Bakar',
      description: 'Sosis ini berkhasiat tinggi',
      price: 2305,
      imageURL: 'assets/sosis.jpg',
      category: 'Food',
    ),
    // Add more products as needed
  ];

  @override
  void initState() {
    super.initState();
    _fetchStoreData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _getProductsByCategory(String category) {
      return products.where((product) => product.category == category).toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: _buildActions(),
        leading: _searching?
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            setState(() {
              _searching=false;
            }); // Kembali ke halaman sebelumnya
          },
        )
            :
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: _searching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (value){
                  setState(() {
                    searchQuery = value;
                  });
                  _searchFocusNode.requestFocus();
                },
                decoration: const InputDecoration(
                  hintText: 'Cari...',
                  border: InputBorder.none,
                ),
              )
            : const Text(
                'Toko Saya',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0), // Tinggi bayangan
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Warna dan opacity bayangan
                  spreadRadius: 1, // Radius penyebaran bayangan
                  blurRadius: 5, // Radius blur bayangan
                  offset: const Offset(
                      0, 3), // Perubahan posisi bayangan (horizontal, vertical)
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _isLoading
          ?Center(child: CircularProgressIndicator())
          : ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height *
                    0.25, // Tinggi 1/10 dari layar
                width: double.infinity, // Lebar penuh
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _storeData['imageURL'] != null
                        ? NetworkImage(_storeData['imageURL']!)
                        : const AssetImage('assets/shop.png')
                    as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //card toko
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Menyesuaikan tinggi dengan konten
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.height * 0.03,
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: _storeData['namaToko']?? '-',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.star, color: Colors.yellow),
                                      ),
                                      Text('5.0'),
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.rate_review_outlined),
                                    ),
                                    Text('128 reviews'),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditStorePage(storeID: widget.storeID),
                                  ),
                                );
                                if (result == true) {
                                  // If data was saved, reload the store data
                                  _fetchStoreData();
                                }
                              },
                              child: Container(
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_note_outlined,
                                        ),
                                        Text('Edit'),
                                      ],
                                    ),
                                  )
                              ) ,

                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )

              ),

              const SizedBox(height: 20),
              //Tombol kategori
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryButton(
                    category: 'Food',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                  CategoryButton(
                    category: 'Bahan Daur',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                  CategoryButton(
                    category: 'Hasil Daur',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if(searchQuery.isEmpty)...[
                ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _getProductsByCategory(_selectedCategory).length,
                itemBuilder: (context, index) {
                  final product = _getProductsByCategory(_selectedCategory)[index];
                  return ProductCard(
                    product: product,
                    isUserStore: true,
                  );
                },
              ),
              ]
              else...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _getProductsByCategory(_selectedCategory).length,
                  itemBuilder: (context, index) {
                    final product = _getProductsByCategory(_selectedCategory)[index];
                    if(product.name.toLowerCase().contains(searchQuery.toLowerCase()))
                      return ProductCard(
                        product: product,
                        isUserStore: true,
                      );
                  },
                ),
              ],
              const SizedBox(height: 60),
            ],
          ),
          Positioned(
            bottom: 16.0, // Atur posisi vertikal dari bawah layar
            right: 16.0, // Atur posisi horizontal dari kanan layar
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadBarang(
                              fromHome: false,
                              fromUserToko: true,
                              isEdit: false,
                            )));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              shape: CircleBorder(), // Membuat FAB bundar

              // Warna latar belakang tombol
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun actions sesuai dengan mode pencarian
  List<Widget> _buildActions() {
    if (_searching) {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // Tindakan pencarian
            print('Melakukan pencarian: ${_searchController.text}');
            // Lakukan pencarian sesuai dengan teks yang dimasukkan dalam _searchController
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // Aktifkan mode pencarian
            setState(() {
              _searching = true;
            });
            _searchFocusNode.requestFocus();
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.black,
          onPressed: () {
            // Tampilkan modal bottom sheet untuk berbagi
            ShareWidget.showShareBottomSheet(context);
          },
        ),
      ];
    }
  }
  // Fungsi untuk menangani penampilan tombol checkou
}