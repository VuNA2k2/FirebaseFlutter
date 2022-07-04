import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/coffee.dart';
import '../../Services/database.dart';

class BottomSheet extends StatefulWidget {
  String uId;
  Coffee? coffee;
  BottomSheet(this.uId, {Coffee? coffee}) {
    this.coffee = coffee;
  }
  @override
  State<StatefulWidget> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  var nameController = TextEditingController();
  var sugarController = TextEditingController();
  double strength = 0;
  @override
  void initState() {
    if(widget.coffee != null) {
      nameController.text = widget.coffee!.name;
      sugarController.text = widget.coffee!.sugars;
      strength = widget.coffee!.strength.toDouble();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: true,
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.brown[300],
                  filled: true,
                  hintText: "Enter Name",
                ),
                style: TextStyle(color: Colors.white70),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: sugarController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.brown[300],
                  filled: true,
                  hintText: "Enter Sugars",
                ),
                style: TextStyle(color: Colors.white70),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16,),
              Slider(
                value: strength,
                min: 0,
                max: 100,
                label: strength.round().toString(),
                onChanged: (val) {
                  setState(() {
                    strength = val;
                  });
                },
              ),
              SizedBox(
                child: widget.coffee == null ? ElevatedButton(
                  child: Text("Add"),
                  onPressed: () {
                    DatabaseService(widget.uId).addUserData(sugarController.text, nameController.text, strength.toInt());
                    Navigator.pop(context);
                  },
                ) : ElevatedButton(
                  child: Text("Save"),
                  onPressed: () {
                    DatabaseService(widget.uId).updateUserData(widget.coffee!.id, sugarController.text, nameController.text, strength.toInt());
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}