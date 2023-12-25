import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_doctors/screens/product_details.dart';
import 'package:tech_doctors/services/firebase_sevices.dart';

import '../provider/product_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object> data;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  FirebaseServices _services=FirebaseServices();

  String address = '';
  @override
  void initState() {
    _services.getSellerData(widget.data['sellerUid']).then((value){
      setState(() {
        address = value['address'];
      });
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    var _provider = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: (){
        _provider.getProductDetails(widget.data);
        Navigator.pushNamed(context, ProductDetailsScreen.id);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                child: Center(child: Image.network(widget.data['images'][0]),),
              ),
              SizedBox(height: 10,),
              Text('Rs. '+widget.data['diag'],style: TextStyle(fontWeight: FontWeight.bold),),
              Text(widget.data['title'],maxLines: 1,overflow: TextOverflow.ellipsis,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.location_pin,size: 14, color: Colors.black38,),
                  Flexible(child: Text(address,maxLines: 1,style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,)),
                ],
              ),

            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.8)
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
