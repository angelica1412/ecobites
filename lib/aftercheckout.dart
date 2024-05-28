import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final bool isDelivery;
  const CheckoutPage({super.key, required this.isDelivery});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isDelivery ? "Delivery" : "Pickup",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF92E3A9),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: widget.isDelivery ? _buildDeliveryContent() : _buildPickupContent(),
    );
  }

  Widget _buildDeliveryContent() {
    return Stack(
      children: [
        // Map image
        Positioned.fill(
          child: Image.asset(
            'assets/maps.png', // Path to your map image
            fit: BoxFit.cover,
          ),
        ),
        // Driver details and communication options
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(
                          'assets/driver.png'), // Add your driver image asset
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DD6396PR',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('Hasrul Muhammad'),
                        Row(
                          children: const [
                            Icon(Icons.star,
                                color: Colors.yellow, size: 16.0),
                            Text('5.0'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Text('4 mnt'),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Oke'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Saya di depan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Ya'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Oke, ditunggu'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickupContent() {
    return Center(
      child: Text(
        'Your order is ready for pickup!',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
