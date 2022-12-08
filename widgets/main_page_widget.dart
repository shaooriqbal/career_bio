import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
    required this.path,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String path;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 16,
            right: 16,
            bottom: -24,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
                gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    const Color(0xFF916DDD).withOpacity(0.2),
                    const Color(0xFF512E73).withOpacity(0.12),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            // top: 16,
            left: 8,
            right: 8,
            bottom: -12,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
                gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    const Color(0xFF916DDD).withOpacity(0.2),
                    const Color(0xFF512E73).withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                stops: [0.5, 1],
                end: Alignment.bottomRight,
                begin: Alignment.centerLeft,
                colors: [
                  Color(0xff6f55a0),
                  Color(0xFF4F2A98),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(path, width: 70, height: 70),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.5, 1],
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.2),
                      ],
                    )
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 9, 0, 15),
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
