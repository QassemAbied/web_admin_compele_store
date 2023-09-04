import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/product_order_widget.dart';
import '../widget/text_widget.dart';

class ViewAllOrderScreen extends StatefulWidget {
  static const String routeName = '\ ViewAllOrderScreen';
  const ViewAllOrderScreen({super.key});

  @override
  State<ViewAllOrderScreen> createState() => _ViewAllOrderScreenState();
}

class _ViewAllOrderScreenState extends State<ViewAllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
      )
    );
  }
}