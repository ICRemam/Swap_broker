import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fire99/chat/cat.dart';
import 'package:fire99/posts.dart';
import 'package:fire99/swaping.dart';
import 'package:fire99/swapping2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add_post.dart';
import 'login.dart';

class showdetails extends StatefulWidget{
  final img;
  final img2;
  final product;
  final product2;



  showdetails(this.img, this.img2, this.product, this.product2);

  @override
  _Action_State createState() => _Action_State();
}

class _Action_State extends State<showdetails> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor:Colors.white,
        appBar: AppBar(
            backgroundColor:Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      // Colors.white,
                      Colors.white,
                      //Colors.lightBlueAccent,

                      // Colors.lightBlueAccent,
                      Colors.white,
                    ])),
                height:30,
                child: Center(child: Row(
                  children: [
                    Text("       Sw",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),
                    Text("ap",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:21)),
                    Text("  Broker",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),

                  ],
                ))
            ),
            //backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[
              IconButton(
                  color:Colors.cyanAccent,
                  icon: Icon(Icons.filter_5_outlined,size:34,),

                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return cat();
                        }));

                  })]
        ),
        body: Container(
          color:Colors.white,
          child: Column(
              children: [

                SizedBox(
                  height:16,
                ),
             /*   Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(

                      hintText:"ex : camera , t shirt , mobile",
                      prefixIcon: InkWell(child: Icon(Icons.search),
                        onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return cs(_searchController.text.toLowerCase());
                              }));
                          //   ),
                        },
                      ),

                    ),
                  ),
                ),*/
                SizedBox(
                  width:7,
                ) ,






                Flexible(

                  child: Expanded(

                    child: StreamBuilder(
                        stream:
                        Firestore.instance.collection('chat')
                       .where("product",isEqualTo:widget.product)
                         //   .orderBy("img",descending:true )
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return Center(child: Text('Loading'));
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
//.where("category", isEqualTo:"tec")
                            default:
                              return ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot posts = snapshot.data.documents[index];

                                    // (profile.imgUrl == null) ? AssetImage('images/user-avatar.png') : NetworkImage(profile.imgUrl)




                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          height: 220,
                                          color: Colors.white10,
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: InkWell(
                                            child: Card(
                                              child:
                                              Container(
                                                //backgroundImage: (profile.imgUrl == null) ? AssetImage('images/user-avatar.png') : NetworkImage(profile.imgUrl)
                                                child:
                                                Image.network(widget.img,
                                                    fit: BoxFit.fill),

                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          height: 220,
                                          color: Colors.white10,
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: InkWell(
                                            child: Card(
                                              child:
                                              Container(
                                                //backgroundImage: (profile.imgUrl == null) ? AssetImage('images/user-avatar.png') : NetworkImage(profile.imgUrl)
                                                child:
                                                Image.network(widget.img2,
                                                    fit: BoxFit.fill),

                                              ),
                                            ),

                                          ),
                                        ),
                                       Column(
                                         children:<Widget>[
                                           Row(
                                             children: [
                                               SizedBox(
                                                 width:5,
                                               ),
                                               Text('Location : ',style:TextStyle(color:Colors.black,fontSize:22,fontWeight:FontWeight.w900),),
                                               Text(posts.data()['location'] ??" ",style:TextStyle(color:Colors.black,fontSize:22,fontWeight:FontWeight.w900),),
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               SizedBox(
                                                 width:5,
                                               ),
                                               Text('time to swap  : ',style:TextStyle(color:Colors.black,fontSize:22,fontWeight:FontWeight.w900),),
                                               Text(posts.data()['time'] ??" ",style:TextStyle(color:Colors.black,fontSize:22,fontWeight:FontWeight.w900),),
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               SizedBox(
                                                 width:5,
                                               ),
                                               Text('mobile number : ',style:TextStyle(color:Colors.black,fontSize:22,fontWeight:FontWeight.w900),),
                                               Text(posts.data()['mob'] ??" ",style:TextStyle(color:Colors.black,fontSize:17,fontWeight:FontWeight.w900),),
                                             ],
                                           ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               //  SizedBox(width: 20.0/3),


                                               FlatButton.icon(onPressed: () {

                                                 var currentUser =
                                                     FirebaseAuth.instance.currentUser;
                                                 Firestore.instance.collection('save the deal').document()
                                                     .setData({
                                                   'location': posts.data()['location'] ,
                                                   'img': widget.img,
                                                   'img2':widget.img2,
                                                   'curent':currentUser.email,
                                                   'product': widget.product,
                                                   'product2': widget.product2,
                                                   'time':posts.data()['time'],
                                                   'mob':posts.data()['mob'],
                                                   'user': {
                                                     'uid': currentUser.uid,
                                                     'email': currentUser.email,
                                                   }
                                                 });

                                               },
                                                 icon: Icon(Icons.adjust_sharp, color: Colors.redAccent,size:32,),
                                                 height: 12,
                                                 // width:50,

                                                 label: Text(" save the deal" , style: TextStyle(color: Colors.red , fontSize: 21,fontStyle:FontStyle.italic),
                                                 ),
                                               ),

                                             ],

                                           ),
                                         ]
                                       )
                                      /*  Container(
                                          padding: EdgeInsets.all(10),
                                          child: ListTile(
                                            // leading: Image.network(posts.data()['img']),
                                            title: Text(posts.data()['location'] ,
                                                style: TextStyle(color: Colors.redAccent)),
                                            subtitle: Container(
                                                height:30,
                                                child: Text("DESCRIPTION:" + posts.data()['des'] )),
                                            trailing: Text(posts.data()['notes']),
                                          ),
                                        ),*/
                                      ],
                                    );
                                  });
                          }
                        }
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:40),
                  child: CurvedNavigationBar(

                      color:Colors.lightBlueAccent,
                      backgroundColor:Colors.white,
                      //buttonBackgroundColor:Colors.blue,
                      items:<Widget>[

                        Icon(Icons.home,size:24,color:Colors.white),
                        Icon(Icons.add_box,size:24,color:Colors.white),
                        Icon(Icons.messenger_rounded,size:24,color:Colors.white),
                        Icon(Icons.account_circle,size:24,color:Colors.white),
                      ],

                      animationCurve:Curves.bounceOut,
                      onTap:(index){

                        if(index==1)
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return AddPost();
                              }));


                        }


                      }


                  ),
                )

              ]),
        ),



    );

  }
}