import 'dart:async';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tech_doctors/provider/product_provider.dart';
import 'package:url_launcher/url_launcher.dart';
class ProductDetailsScreen extends StatefulWidget {

  static const String id = 'product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _loading = true;
  @override
  void initState() {

    Timer(Duration(seconds: 2),(){
      setState(() {
        _loading = false;
      });
    });
    super.initState();
  }

  _callSeller(number){
    launch(number);
  }

  @override
  Widget build(BuildContext context) {

    var _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(
                   Icons.share_outlined,
                   color: Colors.black,
          ))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.grey.shade300,
              child: _loading ? Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 10,),
                  Text("Loading"),
                ],

              ),
              ):

             Image.network(_productProvider.productData['images'][0]),

            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(children: [
                    Text(_productProvider.productData['title'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('(',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(_productProvider.productData['year'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(')',style: TextStyle(fontWeight: FontWeight.bold),),
                  ],),
                  SizedBox(height: 30,),
                  Text('Diagnosis Charges. : Rs. '+ _productProvider.productData['diag'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            ),

            Container(

              color: Colors.black12,
              child: Column(
                children: [
                  Text('Description',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(_productProvider.productData['description'],),
                ],
              ),),


          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Row(
            children: [
              Expanded(child: NeumorphicButton(
                onPressed: (){
                  _callSeller('tel:${_productProvider.productData['number']}');

                },
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone,size: 16,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Call",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),),
              SizedBox(width: 10,),
              Expanded(child: NeumorphicButton(
                onPressed: (){
                  MapsLauncher.launchQuery(_productProvider.productData['address']);

                },
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share_location_sharp,size: 16,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Direction",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
