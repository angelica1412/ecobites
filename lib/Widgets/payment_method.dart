import 'package:ecobites/Widgets/payment_method_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    Key? key,
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
    '-',
  ];
  List<String> paymentMethodPictures = [
    'assets/food.png',
    'assets/logo.png',
    'assets/login.png',
    'assets/food.png',
    'assets/logo.png',
    'assets/login.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8),
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
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
              },
              isSelected: selectedPaymentIndex == index,
            );
          },
        ),

      ],
    );
  }
}
