import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Color productCardBackgroundColor;
  final String productImage;
  final String productName;
  final int productPrice;
  const ProductCard(
      {super.key,
      required this.productCardBackgroundColor,
      required this.productName,
      required this.productPrice,
      required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: productCardBackgroundColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(7.5)),
                  child: CachedNetworkImage(
                      imageUrl: productImage,
                      placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepPurple[600]),
                          ),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red)),
                ),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(productName,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[900])),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text('N',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough)),
                              Text('$productPrice',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ],
                          ),
                        ]),
                      ),
                      InkWell(
                        radius: 25,
                        splashColor: Colors.yellowAccent,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[600],
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.arrow_forward_ios_rounded,
                                size: 18, color: Colors.grey[100])),
                      )
                    ])
              ])
            ]));
  }
}
