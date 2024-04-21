import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _selectedCategory = 'All';
  bool _searching = false; // Untuk melacak apakah sedang dalam mode pencarian
  bool _isFavorite = false; // Untuk melacak apakah toko ini merupakan favorit

  TextEditingController _searchController = TextEditingController();

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