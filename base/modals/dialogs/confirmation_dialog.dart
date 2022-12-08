import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/_base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(children: [
      Image.asset(
        AppAssets.question,
        width: 81.74,
        height: 74.3,
        color: const Color(0xff686666),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8.9, 0, 9.37),
        child: Text(
          'Confirmation',
          style: GoogleFonts.inter(
            color: const Color(0xff686666),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xff808080),
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 14.8),
      SizedBox(
        height: 37,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(37),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(
                    color: Color(0xFF0B002A),
                    width: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.81),
                  ),
                ),
                child: Text(
                  'Yes',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.64,
                    color: const Color(0xFF0B002A),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF0B002A),
                  minimumSize: const Size.fromHeight(37),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.81),
                  ),
                ),
                child: Text(
                  'No',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.64,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => this,
        ) ??
        false;
  }
}

// class ConfirmationDialog extends StatelessWidget {
//   ConfirmationDialog({
//     Key? key,
//     required this.text,
//   }) : super(key: key);
//
//   final String text;
//   var fontStyle = GoogleFonts.poppins(color: Colors.indigo);
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentTextStyle: const TextStyle(color: Colors.black),
//       content: Text(text),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(true),
//           child: Text(
//             'Yes',
//             style: fontStyle,
//           ),
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           child: Text(
//             'No',
//             style: fontStyle,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<bool> show(BuildContext context) async {
//     return await showDialog<bool>(
//           context: context,
//           builder: (_) => this,
//         ) ??
//         false;
//   }
// }
