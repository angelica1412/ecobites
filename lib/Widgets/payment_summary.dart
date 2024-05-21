import 'package:ecobites/Widgets/payment_detail_row.dart';
import 'package:ecobites/voucherPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    Key? key,
    required this.totalPrice,
    required this.isDelivery,
    required this.selectedVoucher,
  }) : super(key: key);

  final double totalPrice;
  final bool isDelivery;
  final Voucher? selectedVoucher;

  @override
  Widget build(BuildContext context) {
    double productDiscount = 0;
    double deliveryDiscount = 0;
    double shippingFee = 10000; // Ongkos kirim contoh
    double discountedTotalPrice = totalPrice;

    if (selectedVoucher != null) {
      // Calculate product discount
      if (selectedVoucher!.productDiscount > 0) {
        productDiscount = (selectedVoucher!.productDiscount / 100) * totalPrice;
        if (productDiscount > selectedVoucher!.maxDiscount) {
          productDiscount = selectedVoucher!.maxDiscount;
        }
      }
      // Calculate delivery discount
      if (isDelivery && selectedVoucher!.deliveryDiscount > 0) {
        deliveryDiscount = (selectedVoucher!.deliveryDiscount / 100) * shippingFee;
        if (deliveryDiscount > selectedVoucher!.maxDiscount) {
          deliveryDiscount = selectedVoucher!.maxDiscount;
        }
      }
      discountedTotalPrice = totalPrice - productDiscount;
    }

    double finalTotalPrice = isDelivery
        ? discountedTotalPrice + shippingFee - deliveryDiscount
        : discountedTotalPrice;

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
            value: 'Rp ${shippingFee.toStringAsFixed(2)}',
          ),
          if (selectedVoucher != null && productDiscount > 0)
            PaymentDetailRow(
              title: 'Diskon Produk',
              value: '-Rp ${productDiscount.toStringAsFixed(2)}',
            ),
          if (selectedVoucher != null && deliveryDiscount > 0)
            PaymentDetailRow(
              title: 'Diskon Ongkir',
              value: '-Rp ${deliveryDiscount.toStringAsFixed(2)}',
            ),
          Divider(),
          PaymentDetailRow(
            title: 'Total',
            value: 'Rp ${finalTotalPrice.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ] else ...[
          if (selectedVoucher != null && productDiscount > 0)
            PaymentDetailRow(
              title: 'Diskon Produk',
              value: '-Rp ${productDiscount.toStringAsFixed(2)}',
            ),
          Divider(),
          PaymentDetailRow(
            title: 'Total',
            value: 'Rp ${finalTotalPrice.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ],
    );
  }
}
