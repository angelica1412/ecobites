  import 'package:flutter/material.dart';
import 'package:get/get.dart';

  import 'UploadBarang.dart';
import 'Widgets/ProductCard.dart';

  class ProductDetailPage extends StatefulWidget {
    final Product product;
    final bool isUserStore;
    final String? storeID;
    final VoidCallback? onQuantityChanged;// Tambahkan properti ini


    const ProductDetailPage({super.key, required this.product, required this.isUserStore,  this.storeID, this.onQuantityChanged});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
    @override
    Widget build(BuildContext context) {
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
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 240,
                width: double.infinity,
                child: _buildImage(widget.product.imageURL)
            ),
            const SizedBox(height: 20),
            Text(
              '${widget.product.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Category:',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.product.category,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Description:',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Stock:',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.product.jumlah.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star_border, color: Colors.yellow),
                const SizedBox(width: 5),
                Text(
                  'rating.toString()', // Rating value
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
              Center(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      // Add navigation to edit product page
                      if (widget.isUserStore) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadBarang(
                              fromHome: false,
                              fromUserToko: true,
                              isEdit: true,
                              product: widget.product,
                              storeID: widget.storeID,
                            ),
                          ),
                        );
                        if (result == true) {
                          Navigator.pop(context,true);
                        }
                      } else {
                        setState(() {
                          widget.product.quantity++;
                          widget.onQuantityChanged?.call();
                        });
                        Navigator.pop(context);
                        // Logic to add product to cart
                      }
                    },
                    child: widget.isUserStore? Text('Edit Product'):Text('Tambah ke Keranjang'),
                  ),
                ),
              ),
          ],
        ),
      );
    }
}