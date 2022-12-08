import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/_base_dialog.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    required this.error,
  }) : super(key: key);

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    String t = '';
    String d = '';
    if (error is DioException) {
      t = error.title;
      d = error.description;
    } else {
      t = 'Error';
      d = error.toString();
    }
    return BaseDialog(children: [
      Image.asset(
        t == 'No Internet connection' ? AppAssets.noWifi : AppAssets.warning,
        width: 81.74,
        height: 74.3,
        color: const Color(0xff686666),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8.9, 0, 9.37),
        child: Text(
          t,
          style: GoogleFonts.inter(
            color: const Color(0xff686666),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Text(
        d,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xff808080),
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 14.8),
      TextButton(
        onPressed: Navigator.of(context).pop,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF0B002A),
          minimumSize: Size.zero,
          padding: const EdgeInsets.fromLTRB(55, 8.51, 55, 8.51),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.81),
          ),
        ),
        child: Text(
          'Okay',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 15.64,
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}

// class ErrorDialog extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(28),
//             color: Colors.white,
//           ),
//           width: min(280, MediaQuery.of(context).size.width),
//           padding: const EdgeInsets.all(24),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             Text(
//               d,
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 24),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: Navigator.of(context).pop,
//                 style: TextButton.styleFrom(
//                   foregroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text('Ok'),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
//
//   void show(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => this,
//     );
//   }
// }
