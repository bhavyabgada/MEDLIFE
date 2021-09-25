import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medstore/components/cart_products.dart';
import 'package:medstore/components/horizontal_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:medstore/medicine.dart';
import 'package:medstore/profile_view.dart';
import 'package:medstore/signin.dart';
import 'aboutus.dart';
import 'auth.dart';
import 'package:medstore/components/cart.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medstore/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget{
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  Future<String> getCurrentUserEmail() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await _firebaseAuth.currentUser();
      print('Hello ' + user.displayName.toString());
    print('Email ' + user.email.toString());
    final String email = user.email.toString();
    print(email);
    return email;
  }
  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    Widget image_corousel = new Container(
      height: 210.0,
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      // child: new Carousel(
      //   boxFit: BoxFit.fill,
      //   images: [
      //     AssetImage('images/carousel/c1.jpg'),
      //     AssetImage('images/carousel/c2.jpg'),
      //     AssetImage('images/carousel/c3.jpg'),
      //     AssetImage('images/carousel/c4.jpg'),
      //   ],
      //   autoplay: true,
      //   animationCurve: Curves.fastOutSlowIn,
      //   animationDuration: Duration(milliseconds: 1000),
      //   dotSize: 5.0,
      //   indicatorBgPadding: 12.0,
      //
      // ),
      child: CarouselSlider(
        items: [
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black54,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage("images/carousel/c1.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black54,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage("images/carousel/c2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black54,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage("images/carousel/c3.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black54,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage("images/carousel/c4.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 180.0,
          enlargeCenterPage: false,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          viewportFraction: 0.8,
        ),
      )
    );
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: Text('MedStore', style: TextStyle(fontSize: 24.0, color: Colors.black54),),
        actions: <Widget>[
         // IconButton(icon: Icon(Icons.search, color: Colors.white,),onPressed: (){}),
          GestureDetector(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_basket, color: Colors.black54,),
                  onPressed: (){
                    if(cart.itemCount != null)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => new Pay()));
                  },
                ),
                if(cart.itemCount > 0)
                  Padding(padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        cart.itemCount.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,),
                      ),
                    ),)
              ],
            ),)
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text('Welcome', style: TextStyle(fontSize: 22.0),),
              accountEmail: FutureBuilder<String>(
                future: auth.getCurrentUserEmail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data, style: TextStyle(fontSize: 22.0),);
                  }
                  else {
                    return Text("Loading user data...");
                  }
                }),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black54,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.green
              ),
            ),

            InkWell(
                onTap: (){
                  navigateToProfilePage(context);
                },
                child: ListTile(
                  title: Text('My Account', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.person, color: Colors.lightBlue,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),

            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new Pay()));
                },
                child: ListTile(
                  title: Text('Shopping Basket', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.shopping_basket, color: Colors.lightBlue,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),

            InkWell(
                onTap: _signOut,
                child: ListTile(
                  title: Text('Log Out', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.settings, color: Colors.lightBlue,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),

            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                },
                child: ListTile(
                  title: Text('About Us', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.help, color: Colors.lightBlue,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),


          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          getBanner(),
          Container(
            margin: EdgeInsets.only(left: 22.0, top: 5.0),
            width: 150.0,
            height: 30.0,
            child: Text('Products to look for', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          //HorizontalList1(),
          OtherMed(),
          image_corousel,
          Container(
              margin: EdgeInsets.only(left: 18.0, top: 5.0),
              width: 150.0,
              height: 30.0,
              child: Text('Categories', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Container(
                            width: 175.0,
                            height: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                )
                            ),
                            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getImageAsset3(),
                                  FlatButton(
                                      onPressed: (){
                                        //navigateToSearchPage(context);
                                        navigateToMedicinePage(context);
                                      },
                                      child: Text('Pharmacy', style: TextStyle(fontSize: 20.0, color: Colors.green),))
                                ])),
                      ]
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Container(
                            width: 175.0,
                            height: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                ),
                            ),
                            margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getGadCatAsset(),
                                  FlatButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GadgetsPage()));
                                  },
                                      child: Text('HealthCare Gadgets', style: TextStyle(fontSize: 20.0, color: Colors.green), textAlign: TextAlign.center,))
                                ])),
                      ]
                  )
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Column(
                      children: <Widget>[
                        Container(
                            width: 175.0,
                            height: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                color: Colors.green,
                                width: 2,
                                ),
                            ),
                            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getSkinCatAsset(),
                                  FlatButton(
                                      onPressed: (){
                                        //navigateToSearchPage(context);
                                        navigateToMedicinePage(context);
                                      },
                                      child: Text('Skin Care', style: TextStyle(fontSize: 20.0, color: Colors.green),))
                                ])),
                      ]
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Column(
                      children: <Widget>[
                        Container(
                            width: 175.0,
                            height: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                ),
                            ),
                            margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getVSCatAsset(),
                                  FlatButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GadgetsPage()));
                                  },
                                      child: Text('Vitamins', style: TextStyle(fontSize: 20.0, color: Colors.green), textAlign: TextAlign.center,))
                                ])),
                      ]
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget getBanner(){
  Image image = Image(image: AssetImage('images/carousel/banner.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
  );
}

Widget getGadCatAsset() {
  Image image = Image(image: AssetImage('images/categories/gad_cat.png'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
  );
}

Widget getSkinCatAsset() {
  Image image = Image(image: AssetImage('images/categories/skin_care_cat.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
  );
}

Widget getVSCatAsset() {
  Image image = Image(image: AssetImage('images/categories/vs_cat.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
  );
}

Widget getImageAsset() {
  Image image = Image(image: AssetImage('images/m9.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
  );
}

Widget getImageAsset1() {
  Image image = Image(image: AssetImage('images/m8.jpg'), width: 160.0, height: 140.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
  );
}

Widget getImageAsset2() {
  Image image = Image(image: AssetImage('images/m7.webp'), width: 160.0, height: 145.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
  );
}

Widget getImageAsset3() {
  Image image = Image(image: AssetImage('images/d9.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 5.0, top: 4.0, right: 5.0),
  );
}


Future navigateToHomePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

Future navigateToMedicinePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicinePage()));
}

Future navigateToProfilePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
}

