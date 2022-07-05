import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_jet/ui/reusable/card_container.dart';
import 'package:couple_jet/ui/reusable/gradient_points_container.dart';
import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/reusable/search_field.dart';
import 'package:couple_jet/ui/screens/chat_list_screen/widgets/list_view_one.dart';
import 'package:couple_jet/ui/screens/chat_screen/chat_screen.dart';
import 'package:couple_jet/ui/screens/profile_screen/profile_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'widgets/list_view_two.dart';

class ChatListScreen extends StatefulWidget {

  ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final list = [1,2,3];
String image="";
  @override
void initState(){
  super.initState();

}
  @override
  Widget build(BuildContext context) {

    if(Theme.of(context).scaffoldBackgroundColor == kLightBg) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }

    TextEditingController searchController=TextEditingController();
    String searchdata="";
    Stream<QuerySnapshot> streamQuery=firebaseFirestore.collection("users").where("id",isNotEqualTo: firebaseAuth.currentUser!.uid).snapshots();

    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: 49 * heightScale,
              left: 18 * widthScale,
              right: 22 * widthScale,
              bottom: 31 * heightScale),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const GradientPointsContainer(points: '1,500'),
                  SizedBox(width: 5 * widthScale),
                  GradientRoundButton(
                    icon: Icons.add_rounded,
                    onPress: () {},
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: ProfileImage(
                        radius: 25 * widthScale,
                        profileImg: firebaseAuth.currentUser!.photoURL.toString(),
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                        }),
                  ),
                  Image.asset(Theme.of(context).scaffoldBackgroundColor == kLightBg ? 'images/icons/notification.png' : 'images/icons/notification_black.png',width: 20*widthScale,height: 20*widthScale,)
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 18 * widthScale, right: 22 * widthScale, bottom: 20 * heightScale),
          child: SearchField(
              hint: "Suche nach einem User oder Thema...",
              textController: searchController,
              onChanged: (v){
                setState(() {
                  if(searchController.text.isNotEmpty){
                    searchdata = v;
                    streamQuery =
                        firebaseFirestore.collection("users")
                            .where("searchName",arrayContains: searchdata.toLowerCase()).
                        where(
                            "id",isNotEqualTo: firebaseAuth.currentUser!.uid
                        )
                            .snapshots();
                  }else{
                    searchController.clear();
                    streamQuery=firebaseFirestore.collection("users").where("id",isNotEqualTo:
                    firebaseAuth.currentUser!.uid).snapshots();
                  }

                });
              }
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ListViewOne(),
                Padding(
                  padding: EdgeInsets.only(top: 25.0 * heightScale),
                  child: ListViewTwo(),
                ),
                CardContainer(
                    paddingVertical: 15,
                    child: StreamBuilder(
                        stream: streamQuery,
                        builder:
                            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.docs.length==0?Center(child: Text("Emphty")): ListView.separated(
                              padding: list.length <= 3 ? EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 100*heightScale)  :EdgeInsets.zero,
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var ds=snapshot.data!.docs[index];
                                return GestureDetector(

                                  onTap: () {
                                    pushNewScreen(
                                      context,
                                      screen:  ChatScreen(
                                        receiverImage: ds.get("imageLink"),
                                        receiverId: ds.id,
                                        recieverName: ds.get("UserName"),
                                      ),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      //pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          ProfileImage(
                                              radius: 18,
                                              profileImg: ds.get("imageLink"),
                                             onPress: (){},
                                              // onPress: () {
                                              //   pushNewScreen(
                                              //     context,
                                              //     screen:  ChatScreen(
                                              //       receiverImage: ds.get("imageLink"),
                                              //       receiverId: ds.id,
                                              //       recieverName: ds.get("UserName"),
                                              //     ),
                                              //     withNavBar: false, // OPTIONAL VALUE. True by default.
                                              //     //pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                              //   );
                                              // }
                                              ),
                                          SizedBox(
                                            width: 10 * widthScale,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                ds.get("UserName"),
                                                style: GoogleFonts.outfit(
                                                    fontSize: 15.5 * widthScale,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text('Wow! Gestern war ein echt wundervoller Tag!',
                                                  style: GoogleFonts.outfit(
                                                      fontSize: 10.5 * widthScale,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color!
                                                          .withOpacity(0.5))),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text('20:01',
                                          style: GoogleFonts.outfit(
                                              fontSize: 10.5 * widthScale,
                                              color:
                                              Theme.of(context).iconTheme.color!.withOpacity(0.5))),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const Divider(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Icon(Icons.error_outline));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })),
                SizedBox(height: 24*heightScale,)
              ],
            ),
          ),
        )
      ]),
    );
  }
}
