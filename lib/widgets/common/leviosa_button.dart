import 'package:flutter/material.dart';

class LeviosaButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final double? width;
  final double? height;
  const LeviosaButton({
    super.key,
    required this.onTap,
    required this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 60,
        width: width ?? 150,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(228, 212, 156, 1),
              Color(0xffad9c00),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 253, 249, 227),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 241, 228, 190).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
