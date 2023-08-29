import 'package:algolia/algolia.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_x_algolia/constants/product_backgroud_colors.dart';
import 'package:flutter_firebase_x_algolia/widgets/product_widget/product_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/algolia_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  final ProductCardBackgroundColors _productCardBackgroundColors =
      ProductCardBackgroundColors();
  String _searchTerm = '';
  final TextEditingController _searchTextController = TextEditingController();

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query =
        _algoliaApp.instance.index('fashion_products').query(input);
    AlgoliaQuerySnapshot querysnapshot = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querysnapshot.hits;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(FluentSystemIcons.ic_fluent_arrow_left_regular,
                color: Colors.grey[900]),
          ),
          title: Text('S E A R C H',
              style: GoogleFonts.quicksand(color: Colors.grey[900])),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  backgroundColor: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {
                      _searchTerm = value;
                    });
                  },
                  onSuffixTap: () {
                    _searchTextController.clear();
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  placeholder: 'Search products...',
                  placeholderStyle: GoogleFonts.quicksand(
                      fontSize: 14, color: Colors.grey[600]),
                  prefixIcon: Icon(FluentSystemIcons.ic_fluent_search_regular,
                      size: 26, color: Colors.grey[900]),
                  suffixIcon: const Icon(
                      FluentSystemIcons.ic_fluent_dismiss_circle_regular),
                ),
                const SizedBox(height: 15),
                StreamBuilder<List<AlgoliaObjectSnapshot>>(
                    stream: Stream.fromFuture(_operation(_searchTerm)),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('Start Typing');
                      } else {
                        List<AlgoliaObjectSnapshot> currentSearchResult =
                            snapshot.data!;
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator(
                                color: Colors.deepPurple[600]);
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              //debug purposes
                              print(
                                  'Number of hits: ${currentSearchResult.length}');
                              return Expanded(
                                child: MasonryGridView.builder(
                                    itemCount: currentSearchResult.length,
                                    gridDelegate:
                                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    itemBuilder: ((context, index) =>
                                        _searchTerm.isNotEmpty
                                            ? ProductCard(
                                                productCardBackgroundColor:
                                                    _productCardBackgroundColors
                                                        .randomColorGenerator(),
                                                productName:
                                                    currentSearchResult[index]
                                                        .data['product_name'],
                                                productPrice:
                                                    currentSearchResult[index]
                                                        .data['product_price'],
                                                productImage:
                                                    currentSearchResult[index]
                                                        .data['product_image'])
                                            : Container())),
                              );
                            }
                        }
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
