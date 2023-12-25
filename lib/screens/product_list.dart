import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_doctors/screens/product_card.dart';
import 'package:tech_doctors/services/firebase_sevices.dart';


class ProductList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    FirebaseServices _services=FirebaseServices();
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12,8,12,8),
        child: FutureBuilder<QuerySnapshot>(
          future: _services.centres.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(left: 140.0, right: 140.0),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  backgroundColor: Colors.grey.shade100,

                ),
              );
            }

            return Column(
              children: [

                Container(
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Nearby Repairing Centres",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2/2.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data.size,
                    itemBuilder: (BuildContext context, int i){
                    var data = snapshot.data.docs[i];
                    return ProductCard(data: data);

                    }
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

