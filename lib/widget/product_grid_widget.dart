import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_compele_store/widget/product_widget.dart';
import 'package:web_admin_compele_store/widget/text_widget.dart';

class ProductGridWidget extends StatelessWidget {
  final int crossAxisCount;
//  final int itemCount;
  final double childAspectRatio;
  const ProductGridWidget({super.key, required this.crossAxisCount,
    required this.childAspectRatio, });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('product').snapshots() ,
      builder: (context , snapshot){
        if(snapshot.connectionState ==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.connectionState ==ConnectionState.active){
          if(snapshot.data!.docs.isNotEmpty){
            return snapshot.data!.docs.length==0?
                TextWidget(text: 'You didn\'t add any product yet', textSize: 22, maxLines: 1, color: Colors.black):
            InkWell(
              onTap: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProductScreen()));
              },
              child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context , index){
                    final items= snapshot.data!.docs[index];
                    return ProductWidget(
                      image:items['imageUrl'],
                      price: items['price'],
                      title: items['title'],
                      isonSale: items['isOnSale'],
                      isPices: items['isPrice'],
                      salePrice: items['salePrice'],
                      idProduct: items['id'],
                      productCategoryName: items['productCategoryName'],
                    );
                  }
              ),
            );
          }else{
            return  TextWidget(text: 'Your Store is Empty', textSize: 22, maxLines: 1, color: Colors.black);
          }

        }
        return TextWidget(text: 'Some thing wait wrrong', textSize: 22, maxLines: 1, color: Colors.black);
      },
    );

  }
}
