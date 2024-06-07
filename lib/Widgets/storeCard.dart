import 'package:ecobites/store.dart';
import 'package:flutter/material.dart';

class Store {
  final String storeID;
  final String name;
  final String description;
  final String imageURL;

  Store({
    required this.storeID,
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
  Widget _buildImage(String imageUrl) {
    return imageUrl.startsWith('http')
        ? SizedBox(
      height: 120,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 120,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return const Icon(Icons.error);
        },
      ),
    )
        : Image.asset(
      imageUrl,
      height: 120,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StorePage(storeID: widget.store.storeID,),
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
                  child: _buildImage(widget.store.imageURL),
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
              child: _buildImage(widget.store.imageURL),
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
