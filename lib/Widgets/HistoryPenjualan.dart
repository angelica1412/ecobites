import 'package:ecobites/detailhistory.dart';
import 'package:flutter/material.dart';

class SalesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailHistoryPage(
                  invoice: 'INV00754',
                  paymentMethod: 'Kartu Kredit',
                  totalPrice: 200000,
                  totalShipping: 15000,
                  totalPromo: 25000,
                  totalSpending: 190000,
                  productName: 'Produk Penjualan',
                  productQuantity: 3,
                  productImage: 'assets/product2.png',
                ),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('2021-12-01'),
                        Text('Done'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Image.asset(
                        'assets/product2.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Produk $index'),
                            Text('Jumlah: 10'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
