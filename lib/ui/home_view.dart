import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryto_wallet/net/api_methodes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues()async{
    bitcoin = await getPrice('bitcoin');
    ethereum = await getPrice('ethereum');
    tether = await getPrice('tether');
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if(id == 'Bitcoin'){
        return bitcoin * amount;
      }else if(id == 'Ethereum'){
        return ethereum * amount;
      }else{
        return tether * amount;
      }
    }
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Coins').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }

            return ListView(
              children: snapshot.data!.docs.map((document){
                return SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Coin Name: ${document.id}"),
                      Text("Amount Owned: ${getValue(document.id,(document.data()as Map<String, dynamic>)['Amount']).toString()}",
                      overflow: TextOverflow.visible,
                      maxLines: 5,
                      )
                    ]
                  ),
                );
              }).toList(),
            );
          },
          )
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const AddView()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}