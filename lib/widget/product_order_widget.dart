
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_compele_store/widget/text_widget.dart';

class ProductOrderWidget extends StatefulWidget {
   ProductOrderWidget({super.key, required this.image, required this.userName,
     required this.orderId, required this.productId, required this.userId,
     required this.totePrice, required this.price, required this.quantity,
     required this.orderDate,});
 final String image, userName, orderId , productId, userId , totePrice;
 final double price , quantity;
 final Timestamp orderDate;
  @override
  State<ProductOrderWidget> createState() => _ProductOrderWidgetState();
}

class _ProductOrderWidgetState extends State<ProductOrderWidget> {
   late String orderDateToShow;


   @override
  void initState() {
     var date= widget.orderDate.toDate();
     orderDateToShow ='${date.day}/ ${date.month}/${date.year}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: 200,
        child: Row(
          children: [
            Image(image: NetworkImage(widget.image)),
            Column(
              children: [
                TextWidget(
                  text: '${widget.quantity} For \$${widget.price}',
                  textSize: 18,
                  maxLines: 1,
                  isText: true,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: '${widget.userName}',
                  textSize: 18,
                  maxLines: 1,
                  isText: true,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: '${orderDateToShow}',
                  textSize: 18,
                  maxLines: 1,
                  isText: true,
                  color: Colors.black,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
