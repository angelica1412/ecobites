import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
//   final bool? isObscureText;
//   final String? obscureCharacter;
//   final String hintText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.keyboardType,
//     this.isObscureText = false,
//     this.obscureCharacter = "*",
//     required this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//     required Null Function(dynamic value) onChanged,

//   });

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: isObscureText!,
//       obscuringCharacter: obscureCharacter!,
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.only(top: 12.0, left: 12.0),
//           constraints: BoxConstraints(
//             maxHeight: height * 0.9,
//             maxWidth: width,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           hintText: hintText,
//           // hintStyle: ,
//           prefixIcon: prefixIcon,
//           suffixIcon: suffixIcon,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(
//               color: Colors.black,
//               width: 1.0,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(
//               color: Colors.black,
//               width: 1.0,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: const BorderSide(
//                 color: Colors.black,
//                 width: 1.0,
//               ))
//           ),
//     );
//   }
// }

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacter;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? prefixText;
  final bool enableCurrencyFormatter; // Tambahkan properti ini


  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.isObscureText = false,
    this.obscureCharacter = "*",
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.prefixText,
    this.enableCurrencyFormatter = false, // Defaultnya false
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText!,
      obscuringCharacter: obscureCharacter!,
      inputFormatters: enableCurrencyFormatter ? [CurrencyInputFormatter()] : null, // Terapkan formatter jika diperlukan
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 12.0, left: 12.0),
        prefix: Text(prefixText ?? ""),
        constraints: BoxConstraints(
          maxHeight: height * 0.9,
          maxWidth: width,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );
  final Function(String)? onChanged;
  CurrencyInputFormatter({this.onChanged});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Format text
    String formattedText = _formatter.format(int.parse(newText));
    if (onChanged != null) {
      onChanged!(formattedText);
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
