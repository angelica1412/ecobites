import 'package:ecobites/Widgets/payment_detail_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    Key? key,
    required this.totalPrice, required this.isDelivery,

  }) : super(key: key);

  final double totalPrice;
  final bool isDelivery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Rincian Pembayaran', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Divider(),
        PaymentDetailRow(
          title: 'Subtotal',
          value: 'Rp ${totalPrice.toStringAsFixed(2)}',
        ),
        if (isDelivery) ...[
          PaymentDetailRow(
            title: 'Ongkos Kirim',
            value: 'Rp 20,000', // Example shipping fee
          ),
          PaymentDetailRow(
            title: 'Diskon',
            value: '-Rp 10,000', // Example discount
          ),
          Divider(),
          PaymentDetailRow(
            title: 'Total',
            value: 'Rp ${(totalPrice + 20000 - 10000).toStringAsFixed(2)}',
            isTotal: true,
          ),
        ] else ...[
          PaymentDetailRow(
            title: 'Diskon Pick Up',
            value: '-Rp 5,000', // Example discount for pick up
          ),
          Divider(),
          PaymentDetailRow(
            title: 'Total',
            value: 'Rp ${(totalPrice - 5000).toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
        // PaymentDetailRow(
        //   title: 'Ongkos Kirim',
        //   value: 'Rp 20,000', // Example shipping fee
        // ),
        // PaymentDetailRow(
        //   title: 'Diskon',
        //   value: '-Rp 10,000', // Example discount
        // ),
        // Divider(),
        // PaymentDetailRow(
        //   title: 'Total',
        //   value: 'Rp ${(totalPrice + 20000 - 10000).toStringAsFixed(2)}',
        //   isTotal: true,
        // ),
      ],
    );
  }
}
