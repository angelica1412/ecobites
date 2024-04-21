import 'package:flutter/material.dart';
import 'package:ecobites/Widgets/ProductCard.dart';
import 'package:ecobites/Widgets/category_button.dart';
import 'package:ecobites/Widgets/share_widget.dart';


class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _selectedCategory = 'All';
  bool _searching = false; // Untuk melacak apakah sedang dalam mode pencarian
  bool _isFavorite = false; // Untuk melacak apakah toko ini merupakan favorit
  bool _showCheckoutButton = false; // Untuk melacak apakah harus menampilkan tombol checkout

  void _setSelectedCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  TextEditingController _searchController = TextEditingController();

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
        // Remove shadow
        leading: _searching
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // Keluar dari mode pencarian
            setState(() {
              _searching = false;
            });
          },
        )
            : IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // Kembali ke halaman sebelumnya
            Navigator.of(context).pop();
          },
        ),
        title: _searching
            ? TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari...',
            border: InputBorder.none,
          ),
        )
            : Text(
          'Toko Saya',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: _buildActions(),
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login.png'), // Ganti dengan path foto Anda
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //card toko
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
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
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
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
                                  children: [
                                    TextSpan(text: 'Nama '),
                                    TextSpan(text: 'Toko', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
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
                            Row(
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
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // Panggil fungsi untuk menampilkan informasi toko
                        _showStoreInformation(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.info_outline),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
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
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
              duration: Duration(milliseconds: 300),
              height: _showCheckoutButton ? 60.0 : 0.0,
              color: Colors.transparent,
              child: _showCheckoutButton
                  ? InkWell(
                onTap: () {
                  // Lakukan tindakan saat container diklik
                  // Misalnya, tampilkan dialog, navigasi ke halaman checkout, dll.
                },
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
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
          icon: Icon(Icons.search),
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
          icon: _isFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(
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
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // Aktifkan mode pencarian
            setState(() {
              _searching = true;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.share),
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
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

}
