import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodBox extends StatefulWidget {
  const PaymentMethodBox({
    Key? key,
    required this.title,
    required this.imageURL,
    required this.onPressed, // Tambahkan properti callback onPressed
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final String imageURL;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  State<PaymentMethodBox> createState() => _PaymentMethodBoxState();
}

class _PaymentMethodBoxState extends State<PaymentMethodBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: widget.onPressed,
      child: Container(
        child: Card(
          elevation: 2,
          color: widget.isSelected? Colors.greenAccent : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    widget.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                      widget.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
