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

  ProductCard({required this.product, this.onQuantityChanged}); // Perbarui konstruktor

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

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
            SizedBox(width: 10),
            // Informasi produk
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
                  _quantity == 0 ? _buildAddButton() : _buildQuantityButton(),
                ],
              ),
            ),
            SizedBox(width: 10),
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
                widget.product.quantity = _quantity; // Update quantity di sini
                widget.onQuantityChanged?.call();
                // Panggil callback di sini
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
        icon: Icon(Icons.add),
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
}
