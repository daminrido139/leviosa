import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leviosa/router_constants.dart';

class DynamicCvPreview extends StatefulWidget {
  const DynamicCvPreview({super.key});

  @override
  State<DynamicCvPreview> createState() => _DynamicCvPreviewState();
}

class _DynamicCvPreviewState extends State<DynamicCvPreview> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      radius: 0,
      onTap: () {
        context.push(RouterConstants.reportView);
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(2.5, 2.5),
                colors: [Colors.white, Color.fromRGBO(153, 153, 153, 1)],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Streak: ',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF434343),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '07 days ',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    Image.asset("assets/img/growth-up.png"),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'HOURS LEARNT',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6F6F6F),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '106 Hrs',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF343434),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'POINTS EARNED',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6F6F6F),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '2005',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF343434),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            right: 30,
            bottom: 35,
            child: SizedBox(
                height: 90,
                width: 90,
                child: Image.asset("assets/img/diamond.png")),
          ),
          Positioned(
            right: 40,
            bottom: 35,
            child: Text(
              'LEVEL 100',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B3B3B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TopPercent extends StatelessWidget {
  const _TopPercent();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 56,
      height: 27,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFBFBFBF)),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: Text(
        'Top 07%',
        style: GoogleFonts.inter(
          color: const Color(0xFFF7AB16),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
