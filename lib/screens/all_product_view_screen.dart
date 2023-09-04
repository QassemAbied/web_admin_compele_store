import 'package:flutter/material.dart';

import '../widget/product_grid_widget.dart';
import '../widget/responsive_widget.dart';

class AllProductViewScreen extends StatefulWidget {
  static const String routeName = '\ AllProductViewScreen';

  const AllProductViewScreen({super.key});

  @override
  State<AllProductViewScreen> createState() => _AllProductViewScreenState();
}

class _AllProductViewScreenState extends State<AllProductViewScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ResponsiveWidget(
                  mobile: ProductGridWidget(
                      crossAxisCount: size.width < 950 ? 2 : 4 ,
                      childAspectRatio: size.width < 950  && size.width < 550  ? 1.1 : 0.8 ,
                     //itemCount: 15
                  ),
                  desktop: ProductGridWidget(
                      crossAxisCount: 4 ,
                      childAspectRatio: size.width < 1400 ? 0.8 : 1.08 ,
                     // itemCount: 15
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}