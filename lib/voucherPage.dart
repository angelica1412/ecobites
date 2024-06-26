import 'package:flutter/material.dart';

class Voucher {
  String code;
  String imageName;
  String description;
  double productDiscount;
  double deliveryDiscount;
  double maxDiscount;

  Voucher(
      {required this.code,
      required this.imageName,
      required this.description,
      required this.deliveryDiscount,
      required this.productDiscount,
      required this.maxDiscount});
}

class VoucherPage extends StatefulWidget {
  final bool fromCheckout;
  final void Function(Voucher) onVoucherUsed;

  const VoucherPage(
      {Key? key, required this.fromCheckout, required this.onVoucherUsed})
      : super(key: key);

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  Voucher? usedVoucherCode; // Deklarasi variabel di sini
  bool isVoucherUsed = false;
  Voucher? selectedVoucher;
  final TextEditingController _searchController = TextEditingController();
  final List<Voucher> _voucherCodes = [
    Voucher(
        code: 'VOUCHER123',
        imageName: 'voucher.png',
        description: 'Discount 50% Product',
        deliveryDiscount: 0,
        productDiscount: 50,
        maxDiscount: 10000),
    Voucher(
        code: 'ECO456',
        imageName: 'voucher25.png',
        description: 'Discount 25% Product',
        deliveryDiscount: 30,
        productDiscount: 20,
        maxDiscount: 10000),
    Voucher(
        code: 'SAVE50',
        imageName: 'voucher45.png',
        description: 'Discount 45% Product',
        deliveryDiscount: 0,
        productDiscount: 30,
        maxDiscount: 20000),
    Voucher(
        code: 'SPRINGSALE',
        imageName: 'voucherchinese.png',
        description: 'Discount 40% Product',
        deliveryDiscount: 0,
        productDiscount: 40,
        maxDiscount: 10000),
    Voucher(
        code: 'FREEDELIVERY',
        imageName: 'freedelivery.png',
        description: 'Free Delivery',
        deliveryDiscount: 100,
        productDiscount: 0,
        maxDiscount: 100000),
  ];
  List<Voucher> _filteredVoucherCodes = [];

  @override
  void initState() {
    super.initState();
    _filteredVoucherCodes = List.from(_voucherCodes);
  }

  void _filterVouchers(String query) {
    _filteredVoucherCodes.clear();
    for (var voucher in _voucherCodes) {
      if (voucher.code.toLowerCase().contains(query.toLowerCase())) {
        _filteredVoucherCodes.add(voucher);
      }
    }
    setState(() {});
  }

  void _useVoucher(Voucher voucher) {
    setState(() {
      isVoucherUsed = true;
      usedVoucherCode = voucher;
      selectedVoucher = voucher;
    });
    widget.onVoucherUsed(voucher);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voucher Page',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFAFAFA),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for voucher code...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _filterVouchers(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredVoucherCodes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/${_filteredVoucherCodes[index].imageName}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_filteredVoucherCodes[index].code),
                                  const SizedBox(height: 5),
                                  Text(_filteredVoucherCodes[index].description,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            if (widget.fromCheckout)
                              ElevatedButton(
                                onPressed: () {
                                  _useVoucher(_filteredVoucherCodes[index]);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF92E3A9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Pakai',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    onTap: () {
                      // Add functionality when a voucher is tapped
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
