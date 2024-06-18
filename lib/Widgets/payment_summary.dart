import 'package:ecobites/Widgets/payment_detail_row.dart';
import 'package:ecobites/voucherPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp. ',decimalDigits: 0);
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
          value: currencyFormatter.format(totalPrice),
        ),
        if (isDelivery) ...[
          PaymentDetailRow(
            title: 'Ongkos Kirim',
            value: currencyFormatter.format(shippingFee),
          ),
          if (selectedVoucher != null && productDiscount > 0)
            PaymentDetailRow(
              title: 'Diskon Produk',
              value: '-${currencyFormatter.format(productDiscount)}',
            ),
          if (selectedVoucher != null && deliveryDiscount > 0)
            PaymentDetailRow(
              title: 'Diskon Ongkir',
              value: '-${currencyFormatter.format(deliveryDiscount)}',
            ),
          Divider(),
          PaymentDetailRow(
            title: 'Total',
            value: currencyFormatter.format(finalTotalPrice),
            isTotal: true,
          ),
        ] else ...[
          if (selectedVoucher != null && productDiscount > 0)
            PaymentDetailRow(
              title: 'Diskon Produk',
              value: '-${currencyFormatter.format(productDiscount)}',
            ),
          Divider(),
          PaymentDetailRow(
            title: 'Total',
            value: currencyFormatter.format(finalTotalPrice),
            isTotal: true,
          ),
        ],
      ],
    );
  }
}
