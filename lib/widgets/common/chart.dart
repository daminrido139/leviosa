import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningsChart extends StatefulWidget {
  const LearningsChart({super.key});

  static List<Color> gradientColors = [
    const Color.fromRGBO(245, 206, 99, 0.72),
    const Color.fromRGBO(245, 206, 99, 0.1),
  ];

  @override
  State<LearningsChart> createState() => _LearningsChartState();
}

class _LearningsChartState extends State<LearningsChart> {
  // Initial Selected Value
  String currentPeriod = 'Weekly';

  // List of items in our dropdown menu
  var periodOptions = [
    'Weekly',
    'Monthly',
    '6 Months',
    'Annually',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 13, right: 11, bottom: 19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.1,
        ),
      ),
      child: Column(
        children: [
          chartLeading(),
          const SizedBox(height: 20),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: LineChart(
              mainData(),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      color: const Color(0xFFA2A7AB),
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Su', style: style);
        break;
      case 1:
        text = Text('Mo', style: style);
        break;
      case 2:
        text = Text('Tu', style: style);
        break;
      case 3:
        text = Text('We', style: style);
        break;
      case 4:
        text = Text('Th', style: style);
        break;
      case 5:
        text = Text('Fr', style: style);
        break;
      case 6:
        text = Text('Sa', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      color: const Color(0xFFA2A7AB),
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 25:
        text = '25';
        break;
      case 50:
        text = '50';
        break;
      case 75:
        text = '75';
        break;
      case 100:
        text = '100';
        break;
      case 125:
        text = '125';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        horizontalInterval: 25,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 6,
      minY: 25,
      maxY: 125,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 50),
            FlSpot(0.5, 55),
            FlSpot(1, 52),
            FlSpot(1.5, 80),
            FlSpot(2, 78),
            FlSpot(2.5, 60),
            FlSpot(3, 58),
            FlSpot(3.5, 100),
            FlSpot(4, 104),
            FlSpot(4.5, 78),
            FlSpot(5, 88),
            FlSpot(5.5, 80),
            FlSpot(6, 84),
          ],
          isCurved: true,
          color: const Color.fromRGBO(247, 171, 22, 1),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.5],
              colors: LearningsChart.gradientColors,
            ),
          ),
        ),
      ],
    );
  }

  Widget chartLeading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Learnings',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4E4941),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Text(
                    '(In Minutes)',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6E6E6E),
                      fontSize: 11.5,
                      letterSpacing: -0.15,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '(250 Minutes required for next level)',
              style: GoogleFonts.inter(
                color: const Color(0xFF4E4941),
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.17,
              ),
            ),
          ],
        ),
        const Spacer(),
        dropMenuButton(),
        const SizedBox(
          width: 4,
        )
      ],
    );
  }

  Widget dropMenuButton() {
    return Container(
      padding: const EdgeInsets.only(right: 2),
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB6B1B1)),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerRight,
      child: DropdownButton(
        padding: const EdgeInsets.only(left: 13, top: 6, bottom: 6, right: 8),
        underline: const SizedBox(),
        dropdownColor: Colors.white,
        value: currentPeriod,
        iconSize: 19,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: periodOptions.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                items,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF4E4941),
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            currentPeriod = newValue!;
          });
        },
      ),
    );
  }
}
