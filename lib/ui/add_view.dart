import 'package:cryto_wallet/net/flutter_fire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({ Key? key }) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "Bitcoin",
    "Tether",
    "Ethereum"
  ];
  String dropDownValue = "Bitcoin";
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropDownValue,
              onChanged: (String? value){
                setState(() {
                  dropDownValue = value!;
                });
              },
              items: coins.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value),
                );
              }).toList(),
              ),

            SizedBox(
              width: MediaQuery.of(context).size.width/1.3,
              child: TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Coin Amount",
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue
              ),
              child: MaterialButton(
                onPressed: () async {
                  await addCoins(dropDownValue, amountController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
       ),
    );
  }
}