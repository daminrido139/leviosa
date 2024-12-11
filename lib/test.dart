import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leviosa/widgets/common/gradient_text.dart';

class DynamicCV extends StatefulWidget {
  const DynamicCV({super.key});

  @override
  State<DynamicCV> createState() => _DynamicCVState();
}

class _DynamicCVState extends State<DynamicCV> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Theme(
      data: ThemeData(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: const Color.fromRGBO(236, 228, 215, 0.85),
          child: Container(
            width: width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    header(),
                    const SizedBox(height: 30),
                    intro(),
                    const SizedBox(height: 20),
                    expertise(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 30),
                    achievementSection(),
                    const SizedBox(height: 40),
                    workExperience(),
                    const SizedBox(height: 30),
                    educationSection(),
                    const SizedBox(height: 30),
                    skillsetRepository(),
                    const SizedBox(height: 30),
                    contactProfile(),
                    const SizedBox(height: 35),
                    contactDetails(),
                    const SizedBox(height: 35),
                    footerButtons(),
                    const SizedBox(height: 30),
                    footer(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset("assets/img/ui_test/dp.png"),
            const SizedBox(width: 14),
            Text(
              "Mr. Damin Rido JV",
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 150,
              height: 29,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffb17600), Color(0xff4b3200)],
                ),
              ),
              child: Text(
                "Coding Ninja",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GradientText(
              "Made with Lica's Dynamic CV ",
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.81),
                  Color.fromRGBO(158, 129, 71, 0.81),
                  Color.fromRGBO(247, 171, 22, 0.81),
                ],
                stops: [0, 0.3, 1],
              ),
              style: GoogleFonts.inter(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(
              'assets/img/common/lica.png',
              height: 33,
            ),
          ],
        ),
      ],
    );
  }

  Widget intro() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Product Interaction Head',
            style: GoogleFonts.inter(
              color: const Color(0xFF4D4D4D),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text:
                ' at Licaverse and pre-final year Electrical and Electronics Engineering student at Kumaraguru College of Technology. highly accomplished competitive programmer and athlete, recognized for academic excellence, significant sports and coding awards as ',
            style: GoogleFonts.inter(
              color: const Color(0xFF4D4D4D),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'Programming from 13 years Old',
            style: GoogleFonts.inter(
              color: const Color(0xFF4D4D4D),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '. ',
            style: GoogleFonts.inter(
              color: const Color(0xFF4D4D4D),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget expertise() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/img/dynamic_cv/sparkle.png"),
            const SizedBox(width: 4),
            Text(
              'My Expertise: ',
              style: GoogleFonts.inter(
                color: const Color(0xFF535353),
                fontSize: 21,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.21,
              ),
            )
          ],
        ),
        const SizedBox(width: 8),
        expertiseItem("Python", "assets/img/ui_test/expertise1.png"),
        const SizedBox(width: 50),
        expertiseItem("Django", "assets/img/ui_test/expertise2.png"),
        const SizedBox(width: 50),
        expertiseItem("C++", "assets/img/ui_test/expertise3.png"),
        const SizedBox(width: 50),
        expertiseItem("Flutter", "assets/img/ui_test/expertise4.png"),
      ],
    );
  }

  Widget expertiseItem(String label, String path) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(path),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget achievementSection() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: achievementBox("assets/img/ui_test/ach1.png",
            "My Portfolio Link: 24 Hours Coding & More...",
            redirectUrl: "https://damin-rido.web.app/"),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: achievementBox(
          "assets/img/ui_test/ach2.png",
          "Leetcode: Top 500 Programmer in Global",
          redirectUrl: "https://leetcode.com/u/daminrido2112/",
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: achievementBox(
          "assets/img/ui_test/ach3.png",
          'Got \$1607 for Winning Silver Medal in KIYG',
          redirectUrl: "https://damin-rido.web.app/",
        ),
      ),
    ]);
  }

  Widget achievementBox(String url, String title, {String? redirectUrl}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (redirectUrl == null) return;
        },
        child: AspectRatio(
          aspectRatio: 2,
          child: Column(
            children: [
              Expanded(
                flex: 12,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 14),
                      const SizedBox(width: 4),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF167BE9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget workExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Work Experience',
            style: GoogleFonts.inter(
              color: const Color(0xFF535353),
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.25,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0x7CA6A6A6)),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              horizontalTile(
                "assets/img/ui_test/lica.png",
                'Co-Founder, Licaverse.',
                'I handles interaction component of the product such as testing/debugging and motion design.',
                'Jul 2024 - present',
              ),
              // horizontalTile(
              //   "assets/img/ui_test/lica.png",
              //   'Product Interaction Head, Licaverse.',
              //   'I handles interaction component of the product such as testing/debugging and motion design.',
              //   'Jul 2024 - present',
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget educationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Education',
            style: GoogleFonts.inter(
              color: const Color(0xFF535353),
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.25,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0x7CA6A6A6)),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              horizontalTile(
                "assets/img/ui_test/kct.png",
                'Pre-Final Year B.E-EEE, Kumaraguru College of Technology.',
                'Activities and societies: Athlete, fencing, Project Based leaning crew, yoga, coding competitions.',
                'Jul 2022 - present',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget horizontalTile(
      String imagePath, String title, String subTitle, String timeLine) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Row(
        children: [
          Image.asset(imagePath),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF393939),
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/img/dynamic_cv/calendar.png"),
                        const SizedBox(width: 4),
                        Text(
                          timeLine,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4B4C4E),
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subTitle,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget skillsetRepository() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Skillset Repository',
            style: GoogleFonts.inter(
              color: const Color(0xFF535353),
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.32,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Honors, Awards, Achievement and Projects  ',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2D2D2D),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  skillsetBullet(
                      "Nov  2017", "Sealed Silver medal & ₹150K at 63rd SGFI"),
                  skillsetBullet("SEP  2022",
                      "One of the 5000 UGrads received RF scholarship in India upto ₹200K"),
                  skillsetBullet(
                      "OCT  2023", "Ranked 661st in IEEExtreme 17.0 Challenge"),
                  skillsetBullet(
                      "JAN  2024", "Top 5% & Knight Leetcode Programmer"),
                  skillsetBullet(
                      "FEB  2024", "Bagged Bronze medal & ₹50K at KIYG"),
                  skillsetBullet(
                      "APRIL  2024", "Mahatma Gandhi Merit Scholarship Win"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 2,
                        color: const Color(0xFFB0B0B0),
                      )),
                      showAllButton(12),
                      Expanded(
                          child: Container(
                        height: 2,
                        color: const Color(0xFFB0B0B0),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 2,
                  height: 496,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color.fromRGBO(117, 117, 117, 0.3),
                ),
                Transform.rotate(
                  angle: 0.785,
                  child: Container(
                      width: 8,
                      height: 8,
                      color: const Color.fromRGBO(117, 117, 117, 0.3)),
                )
              ],
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Skillset Certification & Recognitions',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2D2D2D),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.25,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    const _SkillSetChip(
                      "assets/img/ui_test/flutter.png",
                      "Flutter",
                    ),
                    const _SkillSetChip(
                      "assets/img/ui_test/file.png",
                      "MVP Masterclass",
                    ),
                    const _SkillSetChip(
                        "assets/img/ui_test/python.png", "Python"),
                    const _SkillSetChip(
                        "assets/img/ui_test/figma.png", "Figma"),
                    const _SkillSetChip(
                        "assets/img/ui_test/python.png", "Leetcode"),
                    const _SkillSetChip(
                        "assets/img/ui_test/file.png", "InnoMaster's 24"),
                    const _SkillSetChip(
                        "assets/img/ui_test/firebase.png", "Google Firebase"),
                    const _SkillSetChip("assets/img/ui_test/motion.png",
                        "Motion Design Advanced"),
                    const _SkillSetChip(
                        "assets/img/ui_test/django.png", "Django"),
                    const _SkillSetChip(
                        "assets/img/ui_test/ss.png", "Database Management"),
                    const _SkillSetChip("assets/img/ui_test/cpp.png", "C++"),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 2,
                          color: const Color(0xFFB0B0B0),
                        )),
                        showAllButton(12),
                        Expanded(
                            child: Container(
                          height: 2,
                          color: const Color(0xFFB0B0B0),
                        )),
                      ],
                    )
                  ],
                )
              ],
            )),
          ],
        )
      ],
    );
  }

  Widget skillsetBullet(String date, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• $date:',
            style: GoogleFonts.inter(
              color: const Color(0xFF2D2D2D),
              fontSize: 21,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.45,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(child: _LinkText(text: label)),
        ],
      ),
    );
  }

  Widget showAllButton(int count) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(23),
      child: Container(
        alignment: Alignment.center,
        width: 227,
        height: 36,
        decoration: ShapeDecoration(
          color: const Color.fromRGBO(232, 231, 231, 0.518),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x44B7B7B7)),
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        child: Text(
          'Show all $count+',
          style: GoogleFonts.inter(
            color: const Color.fromRGBO(22, 123, 233, 1),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.45,
          ),
        ),
      ),
    );
  }

  Widget contactProfile() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: ShapeDecoration(
        color: const Color(0x00E4E4E4),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x7CA6A6A6)),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  contactProfileText(
                    "Nationality",
                    Text(
                      '🇮🇳 Indian',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF676363),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ).copyWith(
                          fontFamilyFallback: const ['Apple Color Emoji']),
                    ),
                  ),
                  contactProfileText(
                    "Passport No",
                    Text(
                      'W7432020',
                      style: GoogleFonts.dmMono(
                        color: const Color(0xFF676363),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                height: 23,
                width: 1,
                color: const Color.fromRGBO(173, 173, 173, 0.7),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  contactProfileText(
                    "Sex",
                    Text(
                      'Male',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF676363),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  contactProfileText(
                    "Experience",
                    Text(
                      '7 yrs',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF676363),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  contactProfileText(
                    "DOB",
                    Text(
                      '13ᵗʰ, Sep 2004',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF676363),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: contactProfileText(
                    "Languages Known",
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text(
                        //   'Hindi',
                        //   style: GoogleFonts.inter(
                        //     color: const Color.fromRGBO(103, 99, 99, 1),
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w500,
                        //     backgroundColor: const Color.fromRGBO(113, 109, 109, 0.098),
                        //   ),
                        // ),
                        const SizedBox(width: 6),
                        Text(
                          'Thamizh',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(103, 99, 99, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                const Color.fromRGBO(113, 109, 109, 0.098),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'English',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(103, 99, 99, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                const Color.fromRGBO(113, 109, 109, 0.098),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Malayalam',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(103, 99, 99, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                const Color.fromRGBO(113, 109, 109, 0.098),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Text(
                        //   '+2',
                        //   style: GoogleFonts.inter(
                        //     color: const Color(0xFF166EE9),
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 23,
                width: 1,
                color: const Color.fromRGBO(173, 173, 173, 0.7),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: contactProfileText(
                    "Leisure Activities",
                    Row(
                      children: [
                        Text(
                          'Flute🪈',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(103, 99, 99, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                const Color.fromRGBO(113, 109, 109, 0.098),
                          ).copyWith(
                            fontFamilyFallback: const ['Apple Color Emoji'],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Fencing🤺',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(103, 99, 99, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                const Color.fromRGBO(113, 109, 109, 0.098),
                          ).copyWith(
                            fontFamilyFallback: const ['Apple Color Emoji'],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Listening Music🎼',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(103, 99, 99, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                const Color.fromRGBO(113, 109, 109, 0.098),
                          ).copyWith(
                            fontFamilyFallback: const ['Apple Color Emoji'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget contactDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        contactDetailWidget(
            "assets/img/dynamic_cv/location.png", "Chennai, TN, India."),
        const SizedBox(width: 40),
        contactDetailWidget(
            "assets/img/dynamic_cv/phone.png", "+91 93619 63089"),
        const SizedBox(width: 40),
        contactDetailWidget(
            "assets/img/dynamic_cv/mail.png", "Damin@licaverse.com"),
      ],
    );
  }

  Widget contactProfileText(String leadText, Widget trailing) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$leadText: ',
          style: GoogleFonts.inter(
            color: const Color(0xFF636260),
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing,
      ],
    );
  }

  Widget contactDetailWidget(String iconPath, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconPath),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            color: const Color(0xFF3C3C3C),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.45,
          ),
        )
      ],
    );
  }

  Widget footerButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        footerButtonWidget(
            "assets/img/dynamic_cv/website.png",
            "Damin Rido JV",
            const Color(0x117C3AED),
            const Color(0xFF7C3AED),
            const Color(0xFF7C3AED),
            "https://damin-rido.web.app/"),
        footerButtonWidget(
          "assets/img/dynamic_cv/figma_outlined.png",
          "/daminrido139",
          const Color(0x11F24E1E),
          const Color(0xFFF24E1E),
          const Color(0xFFF24E1E),
          "https://www.figma.com/files/team/1344188664546652657/user/1344188662451155572",
        ),
        footerButtonWidget(
          "assets/img/dynamic_cv/linkedIn.png",
          "/daminrido",
          const Color(0x110A66C2),
          const Color(0xFF0A66C2),
          Colors.black,
          "https://www.linkedin.com/in/daminrido/",
        ),
        footerButtonWidget(
          "assets/img/dynamic_cv/github.png",
          "/daminrido139",
          const Color(0x11292929),
          const Color(0xFF222222),
          Colors.black,
          "https://github.com/daminrido139",
        ),
      ],
    );
  }

  Widget footerButtonWidget(String iconPath, String text, Color bgColor,
      Color sideColor, Color textColor, String? launchUrl) {
    return InkWell(
      borderRadius: BorderRadius.circular(70),
      onTap: () {
        if (launchUrl == null) return;
      },
      child: Container(
        width: 253,
        height: 50,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: sideColor),
            borderRadius: BorderRadius.circular(70),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath),
            const SizedBox(width: 9),
            Text(
              text,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.45,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget footer() {
    return Container(
      height: 33,
      decoration: ShapeDecoration(
        color: const Color.fromRGBO(158, 158, 158, 0.059),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x44B7B7B7)),
          borderRadius: BorderRadius.circular(23),
        ),
      ),
    );
  }
}

class _LinkText extends StatefulWidget {
  final String text;
  const _LinkText({required this.text});

  @override
  State<_LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<_LinkText> {
  static const Color defaultColor = Color.fromRGBO(85, 85, 85, 1);
  static const Color blueColor = Color.fromRGBO(22, 123, 233, 1);
  late Color curColor;

  @override
  void initState() {
    curColor = defaultColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        curColor = blueColor;
      }),
      onExit: (_) => setState(() {
        curColor = defaultColor;
      }),
      cursor: SystemMouseCursors.click,
      child: Text(
        widget.text,
        style: GoogleFonts.inter(
          color: curColor,
          fontSize: 21,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.45,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _SkillSetChip extends StatefulWidget {
  final String label;
  final String path;
  const _SkillSetChip(this.path, this.label);

  @override
  State<_SkillSetChip> createState() => __SkillSetChipState();
}

class __SkillSetChipState extends State<_SkillSetChip> {
  static const defaultBorderColor = Color.fromRGBO(183, 183, 183, 0.267);
  static const blueBorderColor = Color.fromRGBO(22, 123, 233, 1);
  late Color curColor;

  @override
  void initState() {
    curColor = __SkillSetChipState.defaultBorderColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          curColor = blueBorderColor;
        });
      },
      onExit: (_) {
        setState(() {
          curColor = defaultBorderColor;
        });
      },
      child: Opacity(
        opacity: 0.8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(115, 115, 115, 0.7),
                Color.fromRGBO(217, 217, 217, 0.7),
              ],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: curColor,
              ),
              borderRadius: BorderRadius.circular(23),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(widget.path),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  color: const Color.fromRGBO(25, 25, 25, 1),
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
