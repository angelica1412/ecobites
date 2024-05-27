import 'package:ecobites/Store.dart';
import 'package:flutter/material.dart';

class Store {
  final String name;
  final String description;
  final String imageURL;

  Store({
    required this.name,
    required this.description,
    required this.imageURL,
  });
}

class StoreCard extends StatefulWidget {
  final Store store;
  final bool imageOnTop;

  const StoreCard({
    Key? key,
    required this.store,
    this.imageOnTop = false,
  }) : super(key: key);

  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StorePage(),
            ),
          );
        },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.imageOnTop
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    widget.store.imageURL,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.store.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                    widget.store.description,
                  overflow: TextOverflow.ellipsis,

                ),
              ],
            )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 2,
              child: Image.asset(
                widget.store.imageURL,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            // Text information
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.store.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.store.description,
                    overflow: TextOverflow.ellipsis,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}