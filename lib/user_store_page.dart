import 'package:flutter/material.dart';
import 'package:ecobites/Widgets/ProductCard.dart';
import 'package:ecobites/Widgets/category_button.dart';
import 'package:ecobites/Widgets/share_widget.dart';


class userStorePage extends StatefulWidget {
  const userStorePage({super.key});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<userStorePage> {
  String _selectedCategory = 'All';
  bool _searching = false;// Untuk melacak apakah sedang dalam mode pencarian

  void _setSelectedCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  final TextEditingController _searchController = TextEditingController();

  List<Product> products = [
    Product(
      name: 'Product 1',
      description: 'Description for Product 1',
      price: 10.99,
      imageURL: 'assets/product1.png',
      category: 'Food',
    ),
    Product(
      name: 'Product 3',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/product2.png',
      category: 'Bahan',
    ),
    Product(
      name: 'Product 2',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/product3.png',
      category: 'Daur',

    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
      category: 'Bahan',

    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
      category: 'Daur',
    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
      category: 'Daur',
    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
      category: 'Daur',
    ),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    List<Product> _getProductsByCategory(String category) {
      return products.where((product) => product.category == category).toList();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Remove shadow
        leading: _searching
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // Keluar dari mode pencarian
            setState(() {
              _searching = false;
            });
          },
        )
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // Kembali ke halaman sebelumnya
            Navigator.of(context).pop();
          },
        ),
        title: _searching
            ? TextField(
          controller: _searchController,
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
        actions: _buildActions(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // Tinggi bayangan
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Warna dan opacity bayangan
                  spreadRadius: 1, // Radius penyebaran bayangan
                  blurRadius: 5, // Radius blur bayangan
                  offset: Offset(0, 3), // Perubahan posisi bayangan (horizontal, vertical)
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2, // Tinggi 1/10 dari layar
                width: double.infinity, // Lebar penuh
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login.png'), // Ganti dengan path foto Anda
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
                  mainAxisSize: MainAxisSize
                      .min, // Menyesuaikan tinggi dengan konten
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.03,
                                    height: 1.5,
                                  ),
                                  children: const [
                                    TextSpan(text: 'Nama '),
                                    TextSpan(text: 'Toko', style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  Text('5.0 | Jarak'),
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
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              //Tombol kategori
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryButton(
                    category: 'All',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                  CategoryButton(
                    category: 'Food',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                  CategoryButton(
                    category: 'Bahan',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                  CategoryButton(
                    category: 'Daur',
                    selectedCategory: _selectedCategory,
                    onPressed: _setSelectedCategory,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedCategory == 'All' ? products.length : _getProductsByCategory(_selectedCategory).length,
                itemBuilder: (context, index) {
                  final product = _selectedCategory == 'All' ? products[index] : _getProductsByCategory(_selectedCategory)[index];
                  return ProductCard(
                    product: product,
                    isUserStore: true,
                  );
                },
              ),

            ],

          ),
          Positioned(
            bottom: 16.0, // Atur posisi vertikal dari bawah layar
            right: 16.0, // Atur posisi horizontal dari kanan layar
            child: FloatingActionButton(
              onPressed: () {
                print("menuju ke form upload page");
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