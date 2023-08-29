import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_x_algolia/constants/product_backgroud_colors.dart';
import 'package:flutter_firebase_x_algolia/widgets/product_widget/product_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'search_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ProductCardBackgroundColors _productCardBackgroundColors =
      ProductCardBackgroundColors();

  @override
  Widget build(BuildContext context) {
    final CollectionReference fashionProductCollection =
        FirebaseFirestore.instance.collection('fashion_products');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: Text('Z U V E C ',
            style: GoogleFonts.quicksand(color: Colors.grey[900])),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello There',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            Text('What are you buying today?',
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_search_regular,
                          size: 26, color: Colors.grey[900]),
                      const SizedBox(width: 8),
                      Text(
                        'Search products...',
                        style: GoogleFonts.quicksand(
                            fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 15),
            Expanded(
                child: StreamBuilder(
                    stream: fashionProductCollection.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: Colors.deepPurple[600]),
                        );
                      } else if (streamSnapshot.hasData) {
                        return SizedBox.expand(
                            child: MasonryGridView.builder(
                                itemCount: streamSnapshot.data!.docs.length,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  return ProductCard(
                                      productCardBackgroundColor:
                                          _productCardBackgroundColors
                                              .randomColorGenerator(),
                                      productName:
                                          documentSnapshot['product_name'],
                                      productPrice:
                                          documentSnapshot['product_price'],
                                      productImage:
                                          documentSnapshot['product_image']);
                                }));
                      }
                      return const Text('An error occured');
                    }))
          ],
        ),
      ),
    );
  }
}
