import 'package:ecobites/Widgets/scheduleStore.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/Widgets/ProductCard.dart';
import 'package:ecobites/Widgets/category_button.dart';
import 'package:ecobites/Widgets/share_widget.dart';
import 'Widgets/MapsContainer.dart';


class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _selectedCategory = 'All';
  bool _searching = false; // Untuk melacak apakah sedang dalam mode pencarian
  bool _isFavorite = false; // Untuk melacak apakah toko ini merupakan favorit
  bool _showCheckoutButton = false;// Untuk melacak apakah harus menampilkan tombol checkout

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
    ),
    Product(
      name: 'Product 3',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/product2.png',
    ),
    Product(
      name: 'Product 2',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/product3.png',
    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
    ),
    Product(
      name: 'Product 4',
      description: 'Description for Product 2',
      price: 19.99,
      imageURL: 'assets/login.png',
    ),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          '',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: _buildActions(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0), // Tinggi bayangan
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Warna dan opacity bayangan
                  spreadRadius: 1, // Radius penyebaran bayangan
                  blurRadius: 5, // Radius blur bayangan
                  offset: const Offset(0, 3), // Perubahan posisi bayangan (horizontal, vertical)
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
                                  child: Icon(Icons.location_on),
                                ),
                                Text('Alamat'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        
                        // Panggil fungsi untuk menampilkan informasi toko
                        _showStoreInformation(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.info_outline),
                      ),
                    ),
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
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onQuantityChanged: () {
                      // Panggil fungsi untuk menampilkan/menyembunyikan tombol checkout
                      _handleShowCheckoutButton();
                    },
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0.0, // Atur posisi vertical container
            left: 0.0, // Atur posisi horizontal container
            right: 0.0, // Atur lebar container agar sesuai dengan parent
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _showCheckoutButton ? 60.0 : 0.0,
              color: Colors.transparent,
              child: _showCheckoutButton
                  ? InkWell(
                onTap: () {
                  // Lakukan tindakan saat container diklik
                  // Misalnya, tampilkan dialog, navigasi ke halaman checkout, dll.
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0), // Membuat sudut agak bulat dengan radius 12.0
                    ),
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: const Row(
                      children: [
                        // Icon keranjang
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Icon(Icons.shopping_cart, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: VerticalDivider(
                            color: Colors.white, // Warna garis pembatas vertikal
                            thickness: 2, // Ketebalan garis
                            indent: 16, // Jarak dari tepi kiri ikon keranjang
                            endIndent: 16, // Jarak dari tepi kanan ikon keranjang
                          ),
                        ),
                        Text(
                          '5 Produk',
                          style: TextStyle(color: Colors.white),
                        ),
                        // Spacer untuk memberi jarak
                        Spacer(),
                        // Total harga
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Text(
                            'Total: \$50.00', // Ganti dengan total harga sesuai dengan logika aplikasi Anda
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              )
                  : null,
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
          icon: _isFavorite ? const Icon(Icons.favorite, color: Colors.red) : const Icon(
              Icons.favorite_border),
          color: Colors.black,
          onPressed: () {
            // Toggle status favorit
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
        ),
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
  // Fungsi untuk menangani penampilan tombol checkout
  void _handleShowCheckoutButton() {
    bool hasProductWithQuantity = false;
    for (var product in products) {
      if (product.quantity > 0) {
        hasProductWithQuantity = true;
        break;
      }
    }
    setState(() {
      _showCheckoutButton = hasProductWithQuantity;
    });
  }
  void _showStoreInformation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const MapsContainer(storeName: 'gohanku sangir'),
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
                    Padding(
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
                            child:Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.location_on),
                                ),
                                Text('Alamat'),
                              ],
                            ),

                          ),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.route, color: Colors.greenAccent),
                              ),
                              Text('Jarak'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const scheduleStore(day: "Senin", time: "4.00 - 16.00"),
              const scheduleStore(day: "Selasa", time: "4.00 - 16.00"),
              const scheduleStore(day: "Rabu", time: "4.00 - 16.00"),
              const scheduleStore(day: "Kamis", time: "4.00 - 16.00"),
              const scheduleStore(day: "Jumat", time: "4.00 - 16.00"),
              const scheduleStore(day: "Sabtu", time: "4.00 - 16.00"),
              const scheduleStore(day: "Minggu", time: "4.00 - 16.00"),
            ],
          ),
        );
      },
    );
  }
}