import 'package:ecobites/Widgets/Payment_method.dart';
import 'package:ecobites/Widgets/Secondarytabbar.dart';
import 'package:ecobites/Widgets/Voucher.dart';
import 'package:flutter/material.dart';
import 'Widgets/ProductCard.dart';
import 'Widgets/Payment_summary.dart';

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
  

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          padding:  EdgeInsets.all(20.0),
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
                      if(index == 0){
                        setState(() {
                          isDelivery=true;
                        });
                      }
                      else{
                        setState(() {
                          isDelivery=false;
                        });
                      }
                    });
                  },
                  title: 'Deliver',
                  title2: 'Pick Up'),
              SizedBox(height: 20),
              Divider(),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Nama Toko',
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
              Voucher(),
              SizedBox(height: 10),

              Divider(),
              SizedBox(height: 20),
              PaymentSummary(totalPrice: widget.totalprice, isDelivery: isDelivery ,),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              PaymentMethod(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),


              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle checkout action
                  },
                  child: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18),
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
