import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_jet/ui/screens/chat_screen/widgets/chat_app_bar.dart';
import 'package:couple_jet/ui/screens/chat_screen/widgets/chat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'widgets/comment_input_container.dart';

class ChatScreen extends StatefulWidget {
  String receiverImage;
  String recieverName;
  String receiverId;
   ChatScreen({Key? key,required this.receiverId,required this.receiverImage,required this.recieverName}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver{
final scrollController=ScrollController();
  final TextEditingController controller = TextEditingController();
  String groupChatId="";
  String senderName="";
// String receiverToken="";
  String status="";
  @override
  void initState() {
    // TODO: implement initState
    if (firebaseAuth.currentUser!.uid.hashCode <= widget.receiverId.hashCode) {
      groupChatId = "${firebaseAuth.currentUser!.uid}-${widget.receiverId}";
    } else {
      groupChatId = "${widget.receiverId}-${firebaseAuth.currentUser!.uid}";
    }
    super.initState();
    // print(widget.receiverToken);
    print("hdgddddddddddddddd");
    WidgetsBinding.instance.addObserver(this);
    setStatus("online");
    super.initState();

    firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get().then((value){
      senderName= value.get("UserName");
      status=value.get("status");
    });
    // print(_messageCount);
  }
  void setStatus(String status )async{
    await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).update({
      "status":status
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state==AppLifecycleState.resumed){
      setStatus("online");
    }
    else{
      setStatus("offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    final mysize=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChatAppBar(
            title: widget.recieverName,
            subTitle: 'from Essme,DE',
            onBackPress: (){Navigator.pop(context);},
            profileImg: widget.receiverImage,
            // 'images/dummy_profile3.png',
            leftMsg: '',
            onAddPress: (){},
            onMorePress: (){},
          ),
          // Expanded(
          //   child: ChatListView(),
          // ),
          Expanded(
            child: SizedBox(
            // height: MediaQuery.of(context).size.height*0.74,
            //   width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream:firebaseFirestore
                      .collection('messages')
                      .doc(groupChatId)
                      .collection(groupChatId).orderBy("time",descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.length==0?Center(child: Text("No Messages",style: GoogleFonts.outfit(color:Theme.of(context).iconTheme.color,fontSize: 15),)): ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context,index){
                            var ds=snapshot.data!.docs[index];
                            return Container(

                        margin: EdgeInsets.only(left: mysize.width*0.2,right: mysize.width*0.2,
                        top: mysize.height*0.02,bottom: mysize.height*0.01
                        ),
                              padding: EdgeInsets.only(left: mysize.width*0.012,right: mysize.width*0.012,top: mysize.height*0.015,bottom: mysize.height*0.015),
                              child: Text(ds.get("content"),style: GoogleFonts.outfit(color:Theme.of(context).iconTheme.color,fontSize: 15),),
                              decoration: firebaseAuth.currentUser!.uid==widget.receiverId ? BoxDecoration(
                                                          gradient:  LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    kBlue,
                                    kTeal
                                  ],
                                ),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(16),topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                              ):BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(0),topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                              ),

                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error_outline));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
          CommentInputContainer(textController: controller, onSendPress: (){
            sendMessage(controller.text, 0);
          })
        ],
      ),
    );
  }
  void sendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      controller.clear();

      var documentReference = firebaseFirestore
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      firebaseFirestore.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": firebaseAuth.currentUser!.uid,
            "receiverId": widget.receiverId,
            "time": DateTime.now(),
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }
}
