// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test/provider/comment_provider.dart';
// import 'package:test/provider/post_provider.dart';
// import 'package:test/provider/user_provider.dart';

// class CommentWidget extends StatefulWidget {
//   const CommentWidget(
//       {Key? key, required this.id,required this.isCmt, required this.name})
//       : super(key: key);
//   final String id;
//   final String name;
//   final bool isCmt;
//   @override
//   State<CommentWidget> createState() => _CommentWidgetState();
// }

// class _CommentWidgetState extends State<CommentWidget> {
//   String? names = '';
//   bool _isCmt = true;
//   bool isLoad = false;
  
//   TextEditingController controller = TextEditingController();
//   TextEditingController controller2 = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _user = context.watch<UserProvider>().user;
//     var comment = context.watch<CommentProvider>();

//     controller.selection = TextSelection.fromPosition(
//         TextPosition(offset: controller.text.length));
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         widget.isCmt
//             ? Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: Row(
//                   children: [
//                     RichText(
//                         text: TextSpan(
//                             style: TextStyle(color: Colors.black, fontSize: 16),
//                             children: [
//                           TextSpan(text: 'Reply to '),
//                           TextSpan(
//                               text: widget.name,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           TextSpan(
//                             text: "'s comment",
//                           )
//                         ])),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                       this.widget.isCmt = false;
//                         });
//                       },
//                       child: Icon(Icons.cancel_outlined),
//                     )
//                   ],
//                 ),
//               )
//             : Container(),
//         SizedBox(
//           height: 5,
//         ),
//         Container(
//           height: 60,
//           margin: EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(width: 2, color: Colors.grey),
//               borderRadius: BorderRadius.circular(30)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 10,
//                   ),
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(_user.avatarImage!),
//                   ),
//                   Container(
//                     width: 160,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: TextFormField(
//                       controller: controller,
//                       decoration: InputDecoration(
//                           hintText: "Write a comment...",
//                           border: InputBorder.none),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                       splashColor: Colors.transparent,
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.attach_file,
//                         color: Colors.grey,
//                       )),
//                   IconButton(
//                       splashColor: Colors.transparent,
//                       onPressed: () async {
//                         if (controller.text.isNotEmpty) {
//                           setState(() {
//                             isLoad = true;
//                           });
//                           await comment.addComment(
//                               widget.id, _user.token!, controller.text);
//                           controller.clear();
//                           setState(() {
//                             isLoad = false;
//                           });
//                         }
//                       },
//                       icon: isLoad
//                           ? Icon(
//                               Icons.send_outlined,
//                               color: Colors.blue,
//                             )
//                           : Icon(
//                               Icons.send_outlined,
//                               color: Colors.grey,
//                             ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
