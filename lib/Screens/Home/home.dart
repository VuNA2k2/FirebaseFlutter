
import 'package:firebase_tutorial/Screens/loading.dart';
import 'package:firebase_tutorial/Services/auth.dart';
import 'package:firebase_tutorial/Services/database.dart';
import 'package:flutter/material.dart';
import '../../Models/coffee.dart';
import '../../Screens/Home/bottom_sheet.dart' as Custom;


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(_auth.currentUser.uId).coffee,
      builder: (context,AsyncSnapshot<List<Coffee>> snapshot) {
        if(snapshot.hasData) {
          List<Coffee> listCoffee = snapshot.data as List<Coffee>;
          var uId = _auth.currentUser.uId;
          return Scaffold(
            resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text("Home"),
                actions: [
                  FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Logout"),
                  )
                ],
              ),
              body: Center(
                  child: ListView.builder(
                    itemCount: listCoffee.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(listCoffee[index].id),
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.delete),
                        ),
                        onDismissed: (direction) {
                          DatabaseService(uId).deleteDocument(listCoffee[index].id);
                        },
                        child: GestureDetector(
                          child: ListTile(
                            title: Text(listCoffee[index].name),
                          ),
                          onTap: () {
                            showBottomSheet(context, uId, listCoffee[index]);
                          },
                        )
                      );
                    },
                  )
              ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showBottomSheet(context, uId, null);
              },
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("Home"),
              actions: [
                FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Logout"),
                )
              ],
            ),
            body: Loading(!snapshot.hasData),
          );
        }
      },
    );
  }

  void showBottomSheet(BuildContext context, String uId, Coffee? coffee) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Custom.BottomSheet(uId,coffee: coffee);
      }
    );
  }
}


