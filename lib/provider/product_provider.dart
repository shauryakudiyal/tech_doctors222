import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class ProductProvider with ChangeNotifier{
  DocumentSnapshot productData;
  DocumentSnapshot sellerData;

  getProductDetails(details){
    this.productData = details;
    notifyListeners();
  }
  getSellerDetails(details){
    this.sellerData = details;
    notifyListeners();
  }
}