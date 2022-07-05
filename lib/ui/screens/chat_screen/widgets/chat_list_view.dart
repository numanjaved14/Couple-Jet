import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_jet/ui/reusable/profile_image.dart';
import 'package:couple_jet/ui/screens/chat_screen/widgets/comment_input_container.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:couple_jet/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
// import 'package:mime/mime.dart';
// import 'package:open_file/open_file.dart';
// import 'package:uuid/uuid.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';


class ChatListView extends StatefulWidget {

   ChatListView({Key? key}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(String msg) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: msg,
    );

    _addMessage(textMessage);
    controller.clear();
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/message.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();
    setState(() {
      _messages = messages;
    });
  }



  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return Chat
      (
      messages: _messages
      ,
      onAttachmentPressed: _handleAtachmentPressed,
      onMessageTap: _handleMessageTap,
      onPreviewDataFetched: _handlePreviewDataFetched,
      onSendPressed: (msg){},
      user: _user,
      customBottomWidget: CommentInputContainer(
        onSendPress: (){
          _handleSendPressed(controller.text);
        },
        textController: controller,
      ),
      bubbleBuilder: _bubbleBuilder,
      showUserAvatars: true,
      avatarBuilder: (userId){
        return Padding(padding:EdgeInsets.only(right: 12),child:ProfileImage(radius:
        (17), profileImg: 'images/dummy_profile.png', onPress: (){}));
      },
      dateHeaderBuilder: (header){
        return Center(
          child: Container(
            width: 150,
            height: 35,
            margin: EdgeInsets.all(16),
            // padding: EdgeInsets.only(top: 4,right: 15,left: 15,bottom:4 ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor == kLightBg ? Colors.black : kLightBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(header.text,style:GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15,color: Theme.of(context).scaffoldBackgroundColor == kLightBg ? Colors.white : Colors.black,))),
          ),
        );
      },
      theme: DefaultChatTheme(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          secondaryColor: kTeal,
          primaryColor: Theme.of(context).primaryColor,
          sentMessageBodyTextStyle: GoogleFonts.outfit(color:Theme.of(context).iconTheme.color,fontSize: 15),
          receivedMessageBodyTextStyle: GoogleFonts.outfit(color:Colors.white,fontSize: 15)
      ),
    );
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.any,
    // );
    //
    // if (result != null && result.files.single.path != null) {
    //   final message = types.FileMessage(
    //     author: _user,
    //     createdAt: DateTime.now().millisecondsSinceEpoch,
    //     id: const Uuid().v4(),
    //     mimeType: lookupMimeType(result.files.single.path!),
    //     name: result.files.single.name,
    //     size: result.files.single.size,
    //     uri: result.files.single.path!,
    //   );
    //
    //   _addMessage(message);
    // }
  }

  void _handleImageSelection() async {
    // final result = await ImagePicker().pickImage(
    //   imageQuality: 70,
    //   maxWidth: 1440,
    //   source: ImageSource.gallery,
    // );
    //
    // if (result != null) {
    //   final bytes = await result.readAsBytes();
    //   final image = await decodeImageFromList(bytes);
    //
    //   final message = types.ImageMessage(
    //     author: _user,
    //     createdAt: DateTime.now().millisecondsSinceEpoch,
    //     height: image.height.toDouble(),
    //     id: const Uuid().v4(),
    //     name: result.name,
    //     size: bytes.length,
    //     uri: result.path,
    //     width: image.width.toDouble(),
    //   );
    //
    //   _addMessage(message);
    // }
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    // if (message is types.FileMessage) {
    //   await OpenFile.open(message.uri);
    // }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  Widget _bubbleBuilder(
      Widget child, {
        required message,
        required nextMessageInGroup,
      }) {
    return Container(
      child: child,
      decoration: _user.id != message.author.id ||
          message.type == types.MessageType.image ? BoxDecoration(
        gradient: const LinearGradient(
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
  }
}
