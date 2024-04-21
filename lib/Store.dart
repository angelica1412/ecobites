import 'package:flutter/material.dart';
class Product {
  final String name;
  final String description;
  final double price;
  final String imageURL;

  Product({required this.name, required this.description, required this.price, required this.imageURL});
}

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    widget.product.imageURL,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(widget.product.description),
                        SizedBox(height: 5),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: double.infinity, // Batasi lebar Column sesuai dengan batas card
                        height: 40, // Tinggi Column sama dengan tinggi gambar
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _quantity == 0 ? _buildAddButton() : _buildQuantityButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (_quantity > 0) {
                _quantity--;
              }
            });
          },
        ),
        Text(
          _quantity.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _quantity++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
        ),
      ],
    );
  }
}



class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _selectedCategory = 'All';
  int qty = 0;
  bool _searching = false; // Untuk melacak apakah sedang dalam mode pencarian
  bool _isFavorite = false; // Untuk melacak apakah toko ini merupakan favorit

  TextEditingController _searchController = TextEditingController();

  List<Product> products = [
    Product(
      name: 'Product 1',
      description: 'Description for Product 1',
      price: 10.99,
      imageURL: 'assets/login.png',
    ),
    Product(
      name: 'Product 2',
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
      body: Column(
        children: [
          // Bagian atas
          // ...
          // Foto full-width dalam bentuk kotak
          Container(
            height: MediaQuery.of(context).size.height * 0.2, // Tinggi 1/10 dari layar
            width: double.infinity, // Lebar penuh
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login.png'), // Ganti dengan path foto Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height:10),
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
              mainAxisSize: MainAxisSize.min, // Menyesuaikan tinggi dengan konten
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
                                fontSize: MediaQuery.of(context).size.height * 0.03,
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.info_outline),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          //Tombol kategori
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('All'),
              _buildButton('Food'),
              _buildButton('Bahan'),
              _buildButton('Daur'),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
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
            _showShareBottomSheet(context);
          },
        ),
      ];
    }
  }

// Fungsi untuk menampilkan modal bottom sheet untuk berbagi
  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // Mengatur jarak yang merata antara elemen-elemen
                children: [
                  _buildShareItem('WhatsApp', Icons.share, Colors.green.withOpacity(0.3), () {
                    // Tindakan berbagi ke WhatsApp
                    print('Berbagi ke WhatsApp');
                  }),
                  _buildShareItem('Instagram', Icons.share, Colors.pinkAccent.withOpacity (0.3), () {
                    // Tindakan berbagi ke Instagram
                    print('Berbagi ke Instagram');
                  }),
                  // Anda dapat menambahkan item berbagi lainnya di sini
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk membangun item berbagi
// Fungsi untuk membangun item berbagi
  Widget _buildButton(String category) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (_selectedCategory == category) {
            return Colors.greenAccent;
            // Warna hijau untuk tombol yang dipilih
          }
          return Colors.white; // Warna default untuk tombol lainnya
        }),
      ),
      child: Text(category),
    );
  }


  Widget _buildShareItem(String text, IconData icon, Color backgroundColor, Function onTap) {
    return InkWell(
      onTap:(){},
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor, // Mengatur warna latar belakang bulat
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    color: Colors
                        .black, // Anda juga dapat menyesuaikan warna ikon jika perlu
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}