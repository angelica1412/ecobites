import 'package:ecobites/Widgets/payment_method.dart';
import 'package:ecobites/Widgets/secondarytabbar.dart';
import 'package:ecobites/Widgets/Voucher.dart';
import 'package:ecobites/aftercheckout.dart';
import 'package:ecobites/voucherPage.dart';
import 'package:flutter/material.dart';
import 'Widgets/ProductCard.dart';
import 'Widgets/payment_summary.dart';
import 'aftercheckout.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.productsWithQuantity,
    required this.totalprice,
  });

  final List<Product> productsWithQuantity;
  final double totalprice;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _addressController = TextEditingController();
  String _searchedAddress = '';
  bool isDelivery = true;
  Voucher? selectedVoucher;
  String? _selectedPaymentMethod; // Add this line

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _onVoucherUsed(Voucher? voucher) {
    setState(() {
      selectedVoucher = voucher;
    });
  }

  void _onPaymentMethodSelected(String? paymentMethod) {
    setState(() {
      _selectedPaymentMethod = paymentMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Alamat...',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              SizedBox(height: 20),
              SecondaryTabbar(
                onTabSelected: (index) {
                  setState(() {
                    if (index == 0) {
                      setState(() {
                        isDelivery = true;
                      });
                    } else {
                      setState(() {
                        isDelivery = false;
                      });
                    }
                  });
                },
                title: 'Deliver',
                title2: 'Pick Up',
              ),
              SizedBox(height: 20),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'KFC Rumah Makan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Handle tambah action
                    },
                    child: Text(
                      'Tambah',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.productsWithQuantity.length,
                itemBuilder: (context, index) {
                  final product = widget.productsWithQuantity[index];
                  return ProductCard(
                    product: product,
                    isCheckout: true,
                  );
                },
              ),
              SizedBox(height: 20),
              Divider(),
              VoucherState(
                fromCheckout: true,
                onVoucherUsed: _onVoucherUsed,
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 20),
              PaymentSummary(
                totalPrice: widget.totalprice,
                isDelivery: isDelivery,
                selectedVoucher: selectedVoucher,
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              PaymentMethod(
                onPaymentMethodSelected: _onPaymentMethodSelected,
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 167, // Lebar yang diinginkan
                  height: 50, // Tinggi yang diinginkan
                  child: ElevatedButton(
                    onPressed: _selectedPaymentMethod == null ? null : () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage(isDelivery: isDelivery)),
                      ); // Pindah ke halaman Upload
                      print('$isDelivery');
                    },
                    child: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPaymentMethod == null ? Colors.grey : const Color(0xFF92E3A9),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

