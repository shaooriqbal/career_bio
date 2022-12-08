import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Text(
        'OR',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: const Color(0xFF9D9898),
        ),
      ),
    );
  }
}
