import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';
import '../screens/header_screen.dart';
import '../screens/main_screen.dart';
import '../widget/text_widget.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({super.key, required this.id, required this.image,
    required this.price, required this.productCategory, required this.title,
    required this.isPices, required this.isOnSale, required this.salePrice});
   final String id, image, price, productCategory, title;
   final bool isPices,isOnSale;
   final double salePrice;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  List<String> dropMenu = [
    'Computers',
    'LabTop',
    'Smart watches',
    'Electronic devices',
    'Smart phones',
    'electronics',
  ];
  late  TextEditingController titleController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  String? selectValue;
  int groupValue = 0;


  String? salePercent;
  late String showToPerc;
  bool isPrice = false;
 late double salePrice;
  bool isOnSale=false;
  late int val;


  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  dynamic _image;
  String? imageName;

  String imageProduct='';
  String nameProduct='';
  String priceProduct='';
 // String imageProduct='';


  bool isLoading = false;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void formClear(){
    titleController.clear();
    priceController.clear();
    selectValue =null;
    imageName=null;
    isOnSale= false;
    isPrice = false;
    setState(() {

    });
  }
  // _uploadProductImage(dynamic image)async{
  //   final _uuid= Uuid().v4();
  //   Reference reference = _storage.ref().child('productimage').child(_uuid +'png');
  //   UploadTask uploadTask = reference.putData(image);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   String downLoad = await taskSnapshot.ref.getDownloadURL();
  //   return downLoad;
  // }
  // _uploadProduct()async{
  //   final isValid = fromKey.currentState!.validate();
  //   FocusScope.of(context).unfocus();
  //   if(isValid){
  //
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final _uuid= Uuid().v4();
  //
  //     String imageUrl = await _uploadProductImage(_image);
  //     try{
  //       await fireStore.collection('product').doc(_uuid).set({
  //         'id' : _uuid,
  //         'title':titleController .text,
  //         'price' : priceController.text,
  //         'salePrice': salePrice,
  //         'imageUrl':imageUrl,
  //         'productCategoryName': selectValue,
  //         'isOnSale': false,
  //         'isPrice': isPrice,
  //
  //         'createAt': Timestamp.now(),
  //       });
  //       formClear();
  //       Fluttertoast.showToast(
  //           msg: 'Product Uploaded Succefuly',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 5
  //       );
  //     }on FirebaseException catch (error){
  //       showAlertDialogProduct(
  //           context: context,
  //           text: 'An Error occured',
  //           contentText: '${error.code}'
  //       );
  //       setState(() {
  //         isLoading = false;
  //       });
  //     } catch (error){
  //       showAlertDialogProduct(
  //           context: context,
  //           text: 'An Error occured',
  //           contentText: '$error'
  //       );
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }finally{
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //
  //   }
  //
  // }


  @override
  void initState() {
    titleController= TextEditingController(text: widget.title);
    priceController= TextEditingController(text: widget.price);
    selectValue=widget.productCategory;
    isOnSale=widget.isOnSale;
    isPrice=widget.isPices;
    salePrice=widget.salePrice;
    val=isPrice?2:1;
    imageName=widget.image;
    showToPerc=(100-(salePrice * 100)/double.parse(widget.price)).round().toStringAsFixed(1)+ '%';


    super.initState();
  }
  // _uploadProductImage(dynamic image)async{
  //
  //   Reference reference = _storage.ref().child('productimage').child(widget.id +'png');
  //   UploadTask uploadTask = reference.putData(image);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   String downLoad = await taskSnapshot.ref.getDownloadURL();
  //   return downLoad;
  // }
  _uploadProduct()async{
    final isValid = fromKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){

      setState(() {
        isLoading = true;
      });

      //String imageUrl = await _uploadProductImage(_image);
      try{
        await fireStore.collection('product').doc(widget.id).update({
          'title':titleController .text,
          'price' : priceController.text,
          'salePrice': salePrice,
          //'imageUrl':imageUrl,
          'productCategoryName': selectValue,
          'isOnSale': isOnSale,
          'isPrice': isPrice,
        });
        Fluttertoast.showToast(
            msg: 'Product Uploaded Succefuly',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5
        );
      }on FirebaseException catch (error){
        showAlertDialogProduct(
            context: context,
            text: 'An Error occured',
            contentText: '${error.code}'
        );
        setState(() {
          isLoading = false;
        });
      } catch (error){
        showAlertDialogProduct(
            context: context,
            text: 'An Error occured',
            contentText: '$error'
        );
        setState(() {
          isLoading = false;
        });
      }finally{
        setState(() {
          isLoading = false;
        });
      }

    }

  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          height: 700,
          width: size.width < size.width * 0.5
              ? size.width * 0.4
              : size.width * 1.2,
          color: Colors.deepPurple.shade50,
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: 'product Title*',
                    textSize: 22,
                    maxLines: 1,
                    isText: true,
                    color: Colors.black),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pleas enter Text';
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    filled: true,
                    hintText: titleController.text,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: size.width < size.width * 0.5
                            ? size.width * 3
                            : size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: 'price in \$*',
                                textSize: 22,
                                maxLines: 1,
                                isText: true,
                                color: Colors.black),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pleas enter price';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: priceController.text,
                                fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextWidget(
                                text: 'product Category*',
                                textSize: 22,
                                maxLines: 1,
                                isText: true,
                                color: Colors.black),
                            SizedBox(
                              height: 15.0,
                            ),
                           // dropDownCategory(),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextWidget(
                                text: 'measure Unit*',
                                textSize: 22,
                                maxLines: 1,
                                isText: true,
                                color: Colors.black),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            TextWidget(
                                                text: 'kg',
                                                textSize: 20,
                                                maxLines: 1,
                                                color: Colors.black),
                                            Radio(
                                                value: 1,
                                                groupValue: val,
                                                onChanged: (value) {
                                                  setState(() {
                                                    val = 1;
                                                    isPrice = false;
                                                  });
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            TextWidget(
                                                text: 'pices',
                                                textSize: 20,
                                                maxLines: 1,
                                                color: Colors.black),
                                            Radio(
                                                value: 2,
                                                groupValue: val,
                                                onChanged: (value) {
                                                  setState(() {
                                                    val = 2;
                                                    isPrice = true;
                                                  });
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Sale ?' , style: TextStyle(
                                    color: Colors.grey
                                ),),
                                value: isOnSale,
                                tristate: true,
                                // isThreeLine: true,
                                onChanged: (value){
                                  setState(() {
                                    isOnSale= value!;

                                  });
                                }
                            ),
                            if(isOnSale==true)
                              Row(
                                children: [
                                  TextWidget(text: '\$'+salePrice.toStringAsFixed(2),
                                      textSize: 20,
                                      maxLines: 1,
                                      color: Colors.grey
                                  ),
                                  saleDropdown(),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Flexible(
                      flex: 4,
                      child: SizedBox(
                        width: size.width < size.width * 0.6
                            ? size.width * 2
                            : size.width * 0.8,
                        child: Row(
                          children: [
                            Container(
                                height: 250,
                                width: size.width < 700 ? 150 : 350,
                                color: Theme.of(context).scaffoldBackgroundColor,
                                // child: DottedBorder(
                                //   dashPattern: [6, 7],
                                //   borderType: BorderType.RRect,
                                //   radius: Radius.circular(12),
                                //   padding: EdgeInsets.all(6),
                                //   child: ClipRRect(
                                //       borderRadius:
                                //       BorderRadius.all(Radius.circular(12)),
                                //       child:
                                //       _image !=null?
                                //       Image.memory(_image ,): Column(
                                //         crossAxisAlignment:
                                //         CrossAxisAlignment.center,
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         children: [
                                //           Center(
                                //               child: Icon(
                                //                 Icons.image,
                                //                 size: 50,
                                //               )),
                                //           Center(
                                //             child: TextButton(
                                //               onPressed: (){
                                //                 pickImage();
                                //               },
                                //               child:TextWidget(
                                //                   text: 'Chose an image',
                                //                   textSize: 22,
                                //                   maxLines: 1,
                                //                   isText: true,
                                //                   color: Colors.blue),
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //   ),
                                // )
                              child: Image(image: NetworkImage(imageName!)),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        // imageFile=null;
                                        // images= Uint8List(8);
                                      });
                                    },
                                    child: TextWidget(
                                        text: 'Clear',
                                        textSize: 18,
                                        maxLines: 1,
                                        isText: true,
                                        color: Colors.red),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: TextWidget(
                                        text: 'Upload image',
                                        textSize: 18,
                                        maxLines: 1,
                                        isText: true,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade300),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)))),
                      onPressed: ()async {
                        await fireStore.collection('product').doc(widget.id).delete();
                        formClear();
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>SamplePage(),),);
                      },
                      child: Row(
                        children: [
                          Icon( IconlyBold.danger,color: Colors.white,),
                          SizedBox(
                            width: 10,
                          ),
                          TextWidget(
                              text: 'Delete',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    isLoading? CircularProgressIndicator():  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.deepPurple.shade300),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)))),
                      onPressed: () {
                          _uploadProduct();
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>SamplePage(),),);
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconlyBold.upload,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextWidget(
                              text: 'Upload',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage()async{
    FilePickerResult? result = await
    FilePicker.platform.pickFiles(allowMultiple: false , type: FileType.image);
    if(result !=null){
      setState(() {
        _image = result.files.first.bytes;
        imageName = result.files.first.name;
      });
    }
  }
  // Widget dropDownCategory() {
  //   return Container(
  //     color: Theme.of(context).scaffoldBackgroundColor,
  //     child: DropdownButtonFormField(
  //       borderRadius: BorderRadius.circular(2),
  //       value: selectValue,
  //       hint: Text('Select Category'),
  //       items: dropMenu.map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem(
  //             value: value,
  //             child: TextWidget(
  //                 text: value, textSize: 15, maxLines: 1, color: Colors.black));
  //       }).toList(),
  //       onChanged: (value) {
  //         setState(() {
  //           selectValue = value;
  //         });
  //       },
  //       validator: (value) {
  //         if (value!.isEmpty ) {
  //           return 'Please select value';
  //         }
  //       },
  //     ),
  //   );
  // }
  Future<void>  showAlertDialogProduct({required BuildContext context, required String text,required String contentText,
  })async{
    return  await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            //  backgroundColor: Colors.deepPurple.shade50,
            title: Row(
              children: [
                Icon(Icons.error, color: Colors.red,size: 35,),
                TextWidget(
                  text: text,
                  textSize: 22,
                  maxLines: 1,
                  isText: true,
                  color: Colors.black,
                ),
              ],
            ),
            content:TextWidget(
              text: contentText,
              textSize: 18,
              maxLines: 5,
              isText: true,
              color: Colors.black,
            ),
            actions: [

              TextWidget(
                text: 'Cancel',
                textSize: 18,
                maxLines: 1,
                isText: true,
                color: Colors.white,
              ),
            ],
          );
        }
    );
  }

  DropdownButtonHideUnderline saleDropdown(){
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
                child: Text('10%'),
              value: '10',
            ),
            DropdownMenuItem<String>(
              child: Text('15%'),
              value: '15',
            ),
            DropdownMenuItem<String>(
              child: Text('25%'),
              value: '25',
            ),
            DropdownMenuItem<String>(
              child: Text('50%'),
              value: '50',
            ),
            DropdownMenuItem<String>(
              child: Text('75%'),
              value: '75',
            ),
            DropdownMenuItem<String>(
              child: Text('0%'),
              value: '0',
            ),
          ],
          onChanged: (value){
            if(value =='0'){
              return;
            }else{
              setState(() {
                salePercent= value;
                salePrice =double.parse(widget.price)-(double.parse(value!) *double.parse(widget.price) /100);
              });

            }
          },
          value: salePercent,
          hint: Text(salePercent?? showToPerc),
        ),
    );
  }
}
