import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../inner_screen/add_product.dart';
import '../widget/product_grid_widget.dart';
import '../widget/product_order_widget.dart';
import '../widget/responsive_widget.dart';
import '../widget/text_widget.dart';
import 'all_product_view_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '\ MainScreen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: TextWidget(
                      text: 'Latest Product',
                      textSize: 22,
                      maxLines: 1,
                      color: Colors.black
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade300),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          )
                      ),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>AllProductViewScreen(),),);
                      },
                      child:Row(
                        children: [
                          Icon(Icons.image),
                          SizedBox(
                            width: 20,
                          ),
                          TextWidget(
                              text: 'View All',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white
                          ),

                        ],
                      ),

                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade300),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          )
                      ),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>UploadProductFrom(),),);
                      },
                      child:Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 20,
                          ),
                          TextWidget(
                              text: 'Add Product',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white
                          ),
                        ],
                      ),

                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ResponsiveWidget(
                    mobile: ProductGridWidget(
                        crossAxisCount: size.width < 950 ? 2 : 4 ,
                        childAspectRatio: size.width < 950  && size.width < 550  ? 1.1 : 0.8 ,
                       // itemCount: 4
                    ),
                    desktop: ProductGridWidget(
        crossAxisCount: 4 ,
              childAspectRatio: size.width < 1400 ? 0.8 : 1.08 ,
             // itemCount: 4
        ),
                ),
                SizedBox(
                  height: 20,
                ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('order').snapshots(),
                builder: (context, snapShot){
                  if(snapShot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }else if(snapShot.connectionState==ConnectionState.active){
                    if(snapShot.data!.docs.isNotEmpty){
                      return Container(
                        //height: 2000,
                        width: double.infinity,
                        color: Colors.deepPurple.shade50,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context , index){
                            final item = snapShot.data!.docs[index];

                            return ProductOrderWidget(
                              image: snapShot.data!.docs[index]['imageUrl'],
                              userName: snapShot.data!.docs[index]['userName'],
                              orderId: snapShot.data!.docs[index]['orderId'],
                              productId: snapShot.data!.docs[index]['productId'],
                              userId: snapShot.data!.docs[index]['userId'],
                              totePrice: snapShot.data!.docs[index]['totalPrice'],
                              price: snapShot.data!.docs[index]['price'],
                              quantity: snapShot.data!.docs[index]['quantity'],
                              orderDate: snapShot.data!.docs[index]['orderDate'],
                            );
                          },
                          separatorBuilder: (context , index){
                            return Divider(height: 2,color: Colors.black,);
                          },
                          itemCount: snapShot.data!.docs.length,
                        ),
                      );

                    }
                  }
                  return Center(
                    child: TextWidget(
                      text: 'IS EMPTY',
                      textSize: 20,
                      maxLines: 1,
                      color: Colors.black,
                    ),
                  );
                }
            ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
