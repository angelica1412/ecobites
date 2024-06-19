import 'package:ecobites/Widgets/payment_method_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  final Function(String?) onPaymentMethodSelected; // Tambahkan ini

  const PaymentMethod({
    Key? key,
    required this.onPaymentMethodSelected, // Tambahkan ini
  }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedPaymentIndex = -1;
  List<String> paymentMethodTitles = [
    'Shopeepay',
    'Gopay',
    'Dana',
    'OVO',
    'LinkAja',
    'MasterCard'
  ];
  List<String> paymentMethodPictures = [
    'assets/shopeepay.png',
    'assets/gopay.jpg',
    'assets/dana.png',
    'assets/ovo.png',
    'assets/linkaja.png',
    'assets/master.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Metode Pembayaran', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Divider(),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: paymentMethodTitles.length,
          itemBuilder: (context, index) {
            return PaymentMethodBox(
              title: paymentMethodTitles[index], // Menggunakan judul dari daftar
              imageURL: '${paymentMethodPictures[index]}',
              onPressed: () {
                setState(() {
                  selectedPaymentIndex = index;
                });
                widget.onPaymentMethodSelected(paymentMethodTitles[index]); // Panggil callback
              },
              isSelected: selectedPaymentIndex == index,
            );
          },
        ),
      ],
    );
  }
}