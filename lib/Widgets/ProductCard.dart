
import 'package:ecobites/UploadBarang.dart';
import 'package:ecobites/detailproduk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageURL;
  final String category;
  final int jumlah;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.category,
    required this.jumlah,
    this.quantity = 0,
  });
  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    double parseDouble(dynamic value) {
      if (value is String) {
        // Hapus titik pemisah ribuan sebelum parsing
        value = value.replaceAll('.', '').replaceAll(',', '.');
        return double.tryParse(value) ?? 0.0;
      } else if (value is num) {
        return value.toDouble();
      } else {
        return 0.0;
      }
    }

    int parseInt(dynamic value) {
      if (value is String) {
        return int.tryParse(value) ?? 0;
      } else if (value is num) {
        return value.toInt();
      } else {
        return 0;
      }
    }

    return Product(
      id: documentId,
      name: data['namaBarang'] ?? '',
      description: data['deskripsiBarang'] ?? '',
      price: parseDouble(data['hargaAkhirBarang']),
      imageURL: data['productImageURL'] ?? 'assets/shop.png',
      category: data['kategoriBarang'] ?? 'Other',
      jumlah: parseInt(data['jumlahBarang']),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onQuantityChanged;// Tambahkan properti ini
  final VoidCallback? onProductUpdated;
  final bool isUserStore;
  final bool isCheckout;
  final String? storeID;

  const ProductCard({Key? key, required this.product, this.onQuantityChanged,this.onProductUpdated, this.isUserStore = false, this.isCheckout = false,  this.storeID}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Widget _buildImage(String imageUrl) {
    return imageUrl.startsWith('http')
        ? SizedBox(
      height: 120,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        height: 120,
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
    )
        : Image.asset(
      imageUrl,
      height: 120,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
  void _showProductDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ProductDetailPage(product: widget.product, isUserStore: widget.isUserStore,storeID: widget.storeID,onQuantityChanged: widget.onQuantityChanged, );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(widget.product.price);
    return GestureDetector(
      onTap: (){
          _showProductDetail(context);
        },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              Expanded(
                flex: 2,
                child: _buildImage(widget.product.imageURL),
              ),
              const SizedBox(width: 10),
              // Informasi produk
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.product.description),
                    const SizedBox(height: 5),
                    Text(
                      formattedPrice,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // _buildEditButton()
                    if (widget.isUserStore)
                      _buildEditButton()
                    else if (widget.product.quantity == 0)
                      _buildAddButton()
                    else if (widget.isCheckout)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('qty : ${widget.product.quantity}', style: const TextStyle(fontWeight: FontWeight.bold )),
                          ],
                        ),
                      )
                    else
                      _buildQuantityButton(),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (widget.product.quantity > 0) {
                widget.product.quantity--;
                widget.onQuantityChanged?.call();
                // Panggil callback di sini
              }
            });
          },
        ),
        Text(
          widget.product.quantity.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.product.quantity++;
              widget.onQuantityChanged?.call();// Panggil callback di sini
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            widget.product.quantity++;
            widget.onQuantityChanged?.call();// Panggil callback di sini
          });
        },
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Atur padding sesuai kebutuhan Anda
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async{
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadBarang(fromHome: false, fromUserToko: true, isEdit: true,product: widget.product, storeID:widget.storeID ,)
              )
              );
              // Tindakan yang akan dijalankan ketika tombol di klik
              // Misalnya, tampilkan dialog edit, navigasi ke halaman edit, dll.
              if(result == true){
                widget.onProductUpdated?.call();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit),
                const SizedBox(width: 4), // Spasi antara ikon dan teks
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 16, // Atur ukuran teks sesuai kebutuhan Anda
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
