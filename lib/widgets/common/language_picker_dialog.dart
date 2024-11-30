import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/services/user_service.dart';

class LanguagePickerDialog extends StatelessWidget {
  const LanguagePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> changeLanguage(Language language) async {
      context.read<UserCubit>().changeLanguage(language);
      await UserService.setLanguage(language);
      context.pop();
    }

    return SizedBox(
      width: 600,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Item(
              text: 'English',
              onTap: () => changeLanguage(Language.english),
            ),
            _Item(
              text: 'ગુજરાતી',
              onTap: () => changeLanguage(Language.gujarati),
            ),
            _Item(
              text: 'हिन्दी',
              onTap: () => changeLanguage(Language.hindi),
            ),
            _Item(
              text: 'தமிழ்',
              onTap: () => changeLanguage(Language.tamil),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const _Item({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 400,
        alignment: const Alignment(-1, 0),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
