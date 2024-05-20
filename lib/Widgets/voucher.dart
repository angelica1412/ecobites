import 'package:ecobites/voucher.dart';
import 'package:flutter/material.dart';

class Voucher extends StatefulWidget {
  final bool fromCheckout;
  const Voucher({super.key, required this.fromCheckout});

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  String? usedVoucherCode;
  bool isVoucherUsed = false;
  void _handleVoucherUsed(String code) {
    setState(() {
      isVoucherUsed = true;
      usedVoucherCode=code;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.discount,
              color: Colors.red, // Icon color
              size: 24.0, // Icon size
            ),
            SizedBox(width: 8.0),
            Container(
              child:
              isVoucherUsed?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' $usedVoucherCode',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text(
                    ' 50% Discount',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              )
                  : Text(
                'Voucher',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )

            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                isVoucherUsed?
                setState(() {
                  isVoucherUsed=false;
                })
                    :
                Navigator.push(context, MaterialPageRoute(builder: (context)=> VoucherPage(fromCheckout: widget.fromCheckout, onVoucherUsed: _handleVoucherUsed,)));

                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
              ),
              child: isVoucherUsed?  Text('Remove Voucher'):Text('Use Voucher'),
            ),
          ],
        ),
      ),
    );
  }
}