import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Saya'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Foto toko dan informasi
              _buildStoreInfo(),

              SizedBox(height: 20),

              // Tombol kategori
              _buildCategoryButtons(),

              SizedBox(height: 20),

              // Kartu produk
              _buildProductCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Foto toko
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey, // Ganti dengan foto toko
          ),
        ),

        SizedBox(width: 20),

        // Nama toko dan informasi lainnya
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Toko',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Deskripsi Toko',
                style: TextStyle(fontSize: 16),
              ),
              // Informasi lainnya bisa ditambahkan di sini
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: Text('All')),
        ElevatedButton(onPressed: () {}, child: Text('Food')),
        ElevatedButton(onPressed: () {}, child: Text('Bahan')),
        ElevatedButton(onPressed: () {}, child: Text('Daur')),
      ],
    );
  }

  Widget _buildProductCards() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Semua Produk',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Center( // Tambahkan widget Center di sekitar Wrap
            child: Wrap(
              spacing: 10, // Jarak antar kartu produk secara horizontal
              runSpacing: 10, // Jarak antar baris kartu produk
              children: List.generate(
                10, // Ganti dengan jumlah produk yang sesuai
                    (index) => _buildProductCard('Produk $index'),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildProductCard(String productName) {
    return SizedBox(
      width: 150, // Lebar kartu produk
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian kiri: Gambar produk
              Container(
                width: double.infinity,
                height: 100,// Tinggi gambar produk
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey, // Ganti dengan foto produk
                ),
              ),
              SizedBox(height: 8),
              // Bagian kanan: Detail produk dan informasi lainnya
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Harga: \$10'), // Ganti dengan harga produk
                  Text('Stok: 100'), // Ganti dengan informasi stok produk
                  // Informasi lainnya bisa ditambahkan di sini
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}