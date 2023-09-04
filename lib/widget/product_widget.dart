import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_compele_store/widget/text_widget.dart';
import '../consts/firebase_consts.dart';
import '../inner_screen/edit_product.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String price;
  final String title;
  final bool isonSale;
  final bool isPices;
  final double salePrice;
  final String idProduct;
  final String productCategoryName;
  const ProductWidget({super.key, required this.image, required this.price,
    required this.title, required this.isonSale, required this.isPices,
    required this.salePrice, required this.idProduct, required this.productCategoryName});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurple.shade50,
      child: InkWell(
        onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>
          //     EditProductScreen(
          //       image: image,
          //       price: price,
          //       title: title,
          //       isonSale: isonSale,
          //       isPices: isPices,
          //       salePrice: salePrice,
          //       idProduct:idProduct,
          //       productCategoryName:productCategoryName ,
          //     ),
          // ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                      child: Image(image: NetworkImage(image),
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 60,
                      )
                  ),
                  Spacer(),
                  Flexible(
                    flex: 1,
                    child: PopupMenuButton(
                        itemBuilder: (context){
                          return [
                          PopupMenuItem(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  EditProductScreen(id: idProduct,
                                    image: image,
                                    price: price,
                                    productCategory: productCategoryName,
                                    title: title,
                                    isPices: isPices,
                                    isOnSale: isonSale,
                                    salePrice: salePrice,
                                  ),
                              ),
                              );
                            },
                            child:TextWidget(
                              text: 'Edit',
                              textSize: 18,
                              maxLines: 1,
                              color: Colors.black,
                            ),

                          ),
                            PopupMenuItem(
                              onTap: ()async{
                                await
                                FirebaseFirestore.instance.collection('product').doc(idProduct).delete();
                              },
                              child:TextWidget(
                                text: 'Delete',
                                textSize: 18,
                                maxLines: 1,
                                color: Colors.black,
                              ),

                            ),

                          ];
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextWidget(
                    text:isonSale? '\$${salePrice.toStringAsFixed(2)}':'\$$price',
                    textSize: 18,
                    maxLines: 1,
                    isText: true,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Visibility(
                    visible: isonSale,
                    child: TextWidget(
                        text: '\$$price',
                        textSize: 16,
                        maxLines: 1,
                        isunderline: true,
                        color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                text: title,
                textSize: 22,
                maxLines: 1,
                isText: true,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
