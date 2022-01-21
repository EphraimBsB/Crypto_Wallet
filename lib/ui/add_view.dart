import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({ Key? key }) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
        ),
        child: Text("Add view")
       ),
    );
  }
}