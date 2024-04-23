import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageURL;
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageURL,
    this.quantity = 0,
  });
}

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onQuantityChanged; // Tambahkan properti ini

  const ProductCard({super.key, required this.product, this.onQuantityChanged}); // Perbarui konstruktor

  @override
  _ProductCardState createState() => _ProductCardState(false);
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;
  bool _isStore = false;

  _ProductCardState(this._isStore);

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
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // _buildEditButton()
                  if (_quantity == 0) _buildAddButton() else _buildQuantityButton(),
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
              if (_quantity > 0) {
                _quantity--;
                widget.product.quantity = _quantity; // Update quantity di sini
                widget.onQuantityChanged?.call();
                // Panggil callback di sini
              }
            });
          },
        ),
        Text(
          _quantity.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _quantity++;
              widget.product.quantity = _quantity; // Update quantity di sini
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
            _quantity++;
            widget.product.quantity = _quantity; // Update quantity di sini
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
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
            },
          ),
          const Text('Edit'),
        ],
      ),
    );
  }




}
