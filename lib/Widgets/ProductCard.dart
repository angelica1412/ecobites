import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageURL;
  final String category;
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.category,
    this.quantity = 0,
  });
}

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onQuantityChanged;// Tambahkan properti ini
  final bool isUserStore;

  const ProductCard({Key? key, required this.product, this.onQuantityChanged, this.isUserStore = false}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Expanded(
              flex: 2,
              child: Image.asset(
                widget.product.imageURL,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
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
                    '\Rp.${widget.product.price.toInt()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // _buildEditButton()
                  if (widget.isUserStore)
                    _buildEditButton()
                  else if (widget.product.quantity == 0)
                    _buildAddButton()
                  else
                    _buildQuantityButton(),
                ],
              ),
            ),
            const SizedBox(width: 10),
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
            onTap: () {
              // Tindakan yang akan dijalankan ketika tombol di klik
              // Misalnya, tampilkan dialog edit, navigasi ke halaman edit, dll.
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
