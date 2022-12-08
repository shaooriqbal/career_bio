// import 'dart:ui';
//
// import 'package:be_ready_app/src/base/assets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class VideoWidget extends StatelessWidget {
//   const VideoWidget(
//       {Key? key,
//       required this.path,
//       required this.title,
//       required this.shareWithFriend,
//       required this.likeButton})
//       : super(key: key);
//   final String path;
//   final String title;
//   final VoidCallback shareWithFriend;
//   final VoidCallback likeButton;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       margin: const EdgeInsets.only(bottom: 15),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: const DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage(AppAssets.videoBg),
//         ),
//       ),
//       child: Column(
//         children: [
//           _clipRect(
//               child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Text(
//               title,
//               style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w300),
//             ),
//           )),
//           Expanded(
//             child: Container(
//               width: 63,
//               height: 63,
//               padding: const EdgeInsets.all(15),
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   stops: [0.1, 0.8],
//                   end: Alignment.bottomRight,
//                   begin: Alignment.centerLeft,
//                   colors: [
//                     Color(0xFFF0D781),
//                     Color(0xFFDA8B6D),
//                     // Color(0xff56528E),
//                   ],
//                 ),
//               ),
//               child: Image.asset(AppAssets.videoIcon),
//             ),
//           ),
//           _clipRect(
//             borderRadius: bottomBorder,
//             child: Row(children: [
//               TextButton(
//                 onPressed: shareWithFriend,
//                 child: Text(
//                   "Share with Friend",
//                   style: GoogleFonts.poppins(
//                     fontSize: 11,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               TextButton(
//                 onPressed: likeButton,
//                 child: Text(
//                   'Like',
//                   style: GoogleFonts.poppins(
//                     fontSize: 11,
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             ]),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _clipRect({required Widget child, BorderRadius? borderRadius}) {
//     return ClipRRect(
//       borderRadius: borderRadius ?? topBorder,
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 10,
//           sigmaY: 10,
//         ),
//         child: Container(
//             width: double.infinity,
//             // padding: const EdgeInsets.all(15),
//             margin: const EdgeInsets.only(bottom: 1),
//             decoration: BoxDecoration(
//                 color: Colors.transparent.withOpacity(0.4),
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromRGBO(210, 135, 111, 1),
//                     Color.fromRGBO(82, 48, 114, 1),
//                   ],
//                 ),
//                 shape: BoxShape.rectangle,
//                 borderRadius: borderRadius ?? topBorder),
//             child: child),
//       ),
//     );
//   }
//
//   final topBorder = const BorderRadius.only(
//     topLeft: Radius.circular(15),
//     topRight: Radius.circular(15),
//   );
//   final bottomBorder = const BorderRadius.only(
//     bottomLeft: Radius.circular(15),
//     bottomRight: Radius.circular(15),
//   );
// }
