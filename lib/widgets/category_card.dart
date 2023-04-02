import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget getCategoryCard(BuildContext context, String name, String? imageUrl, int sumOfItemsInCategory, int sumOfItemsInInventory) {

  return Padding(
    padding: const EdgeInsets.only(top:8.0, left: 4.0, right: 4.0),
    child: Card(
      child: Container(
        color: Color(0xFFFEEAE6),
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Text(name, style: TextStyle(fontSize: 20.0, color: Colors.indigo, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text('Sum of items in category: '),
                  Text(sumOfItemsInCategory.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text('Sum of items in inventory: '),
                  Text(sumOfItemsInInventory.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8),
              imageUrl == null
                ? SizedBox(width: 0,)
                : Flexible(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>  CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>  Icon(Icons.error),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}