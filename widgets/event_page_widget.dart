import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsTile extends StatelessWidget {
  const EventsTile({
    Key? key,
    required this.title,
    required this.date,
    required this.participants,
    required this.path,
  }) : super(key: key);

  final String title;
  final String date;
  final String path;
  final List<String> participants;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(12, 12, 18, 12),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF2E2340),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(child: Image.network(path, fit: BoxFit.fill)),
          AppNetworkImage(
            url: path,
            width: 96,
            height: 96,
            fit: BoxFit.cover,
            borderRadius: 8,
          ),

          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 11),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              date,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: const Color(0xffFFFFFF).withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
