// import 'package:be_universe/src/base/assets.dart';
// import 'package:flutter/material.dart';
//
// class AppBarWidget extends StatelessWidget implements PreferredSize {
//   AppBarWidget({
//     Key? key,
//     this.showNotificationDot = true,
//     this.isCenterTitle = true,
//   }) : super(key: key);
//
//   final bool showNotificationDot;
//   final bool isCenterTitle;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: isCenterTitle,
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 15),
//           child: Stack(
//             children: [
//               Center(child: Image.asset(AppAssets.bellIcon)),
//               if (showNotificationDot)
//                 Positioned(
//                   right: 2,
//                   top: -15,
//                   bottom: 0,
//                   child: Container(
//                     height: 8,
//                     width: 8,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFF1D681),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: Image.asset(AppAssets.user),
//         ),
//       ],
//     );
//   }
//
//   final _appBar = AppBar();
//
//   @override
//   Widget get child => _appBar;
//
//   @override
//   Size get preferredSize => _appBar.preferredSize;
// }
