import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        centerTitle: true,
        backgroundColor: const Color(0xFF92E3A9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/product1.png',
                height: 200,
                width: 700,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Makanan Enakss',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Food Category',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi malesuada velit eu est bibendum, sit amet ultricies nisi hendrerit.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Color.fromARGB(255, 255, 230, 0)),
                    SizedBox(width: 5),
                    Text(
                      '4.0', // Rating value
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  'In Stock: 100', // Stock information
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 60),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add navigation to edit product page
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF92E3A9)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit Product'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
