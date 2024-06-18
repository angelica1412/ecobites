import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobites/Widgets/Payment_method.dart';
import 'package:ecobites/Widgets/secondarytabbar.dart';
import 'package:ecobites/Widgets/Voucher.dart';
import 'package:ecobites/aftercheckout.dart';
import 'package:ecobites/authenticate/Controller/historyController.dart';
import 'package:ecobites/voucherPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Widgets/ProductCard.dart';
import 'Widgets/payment_summary.dart';
import 'aftercheckout.dart';
import 'authenticate/Controller/storeController.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.productsWithQuantity,
    required this.totalprice,
    required this.storeID,
  });

  final List<Product> productsWithQuantity;
  final double totalprice;
  final String storeID;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _addressController = TextEditingController();
  String _searchedAddress = '';
  bool isDelivery = true;
  Voucher? selectedVoucher;
  String? _selectedPaymentMethod; // Add this line
  bool _isLoading = false;
  Map<String, dynamic> historyData = {};
  List<Voucher> _filteredVoucherCodes = [];



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
  Future<void> prepareHistoryData() async {
    // Get current date
    final now = DateTime.now();
    final formatter = DateFormat('dd MMMM yyyy HH:mm:ss');
    final formattedDate = formatter.format(now);

    // Get store data
    final storeData = await getStorebyID(widget.storeID);

    // Prepare product list
    final productList = widget.productsWithQuantity.map((product) {
      return {
        'id': product.id,
        'namaBarang': product.name,
        'quantity': product.quantity,
        'satuanBarang': product.satuanBarang,
        'kualitasBarang': product.quality,
        'hargaAsliBarang': product.hargaAsliBarang,
        'discount': product.discount,
        'hargaAkhirBarang': product.hargaAkhirBarang,
        'kategoriBarang': product.category,
        'deskripsiBarang': product.description,
        'productImageURL': product.imageURL,
      };
    }).toList();
    final voucherList = selectedVoucher != null ? [
      {
        'code': selectedVoucher!.code,
        'imageName': selectedVoucher!.imageName,
        'description': selectedVoucher!.description,
        'productDiscount': selectedVoucher!.productDiscount,
        'deliveryDiscount': selectedVoucher!.deliveryDiscount,
        'maxDiscount': selectedVoucher!.maxDiscount,
      }
    ] : [];
    final voucherList2 = [
      {
        'code': selectedVoucher?.code,
        'imageName': selectedVoucher?.imageName,
        'description': selectedVoucher?.description,
        'productDiscount': selectedVoucher?.productDiscount,
        'deliveryDiscount': selectedVoucher?.deliveryDiscount,
        'maxDiscount': selectedVoucher?.maxDiscount,
      }
    ];


    // Update historyData
    historyData = {
      'storeID': widget.storeID,
      'storeName': storeData?['namaToko'] ?? 'No store name',
      'Products': productList,
      'totalPrice': widget.totalprice,
      'address': _addressController.text,
      'isDelivery': isDelivery,
      'voucher': voucherList, // Assuming Voucher has a toMap() method
      'paymentMethod': _selectedPaymentMethod,
      'date': formattedDate,
    };
  }

  Future<void> saveHistorytoUser() async{
    setState(() {
      _isLoading = true;
    });

    await addHistorytoUsersFirestore(historyData);
  }
  Future<void> saveHistorytoStore() async{
    setState(() {
      _isLoading = true;
    });
    await addHistorytoStoresFirestore(widget.storeID, historyData);
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
              FutureBuilder<Map<String, String>?>(
                future: getStorebyID(widget.storeID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading store data');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text('Store not found');
                  } else {
                    final storeData = snapshot.data!;
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            storeData['namaToko'] ?? 'No store name',
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
                    );
                  }
                },
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
                child: _isLoading
                    ? CircularProgressIndicator() // Show loading indicator when isLoading is true
                    : Container(
                  width: 167, // Lebar yang diinginkan
                  height: 50, // Tinggi yang diinginkan
                  child:  ElevatedButton(
                    onPressed: _selectedPaymentMethod == null || _isLoading
                        ? null // Disable button if no payment method selected or while loading
                        : () async {
                      setState(() {
                        _isLoading = true; // Set isLoading to true when checkout button is pressed
                      });
                      await prepareHistoryData();
                      await saveHistorytoUser();
                      await saveHistorytoStore();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage(isDelivery: isDelivery)),
                      );
                    },
                    child: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedPaymentMethod == null || _isLoading
                          ? Colors.grey // Disable button color
                          : const Color(0xFF92E3A9), // Enable button color
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

