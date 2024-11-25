import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';

class NewChatBox extends StatelessWidget {
  final Widget leading;
  final String receiverName;
  final String? receiverId;
  final void Function() onTap;
  final void Function()? onCheckboxTap;
  final String? rollNo;
  final bool? isChecked;

  const NewChatBox({
    super.key,
    required this.leading,
    this.receiverId,
    required this.receiverName,
    required this.onTap,
    this.rollNo,
    this.isChecked,
    this.onCheckboxTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListTile(
        onTap: onTap,
        minTileHeight: 67,
        leading: leading,
        subtitle: Text(rollNo ??
            context.read<UserCubit>().state.role.toString().split(".")[1]),
        title: Text(
          receiverName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isChecked == null
            ? null
            : Checkbox(
                value: isChecked!,
                onChanged: (val) => onCheckboxTap!(),
                shape: const CircleBorder(),
                activeColor: leviosaColor,
                side: const BorderSide(width: 0.5),
              ),
      ),
    );
  }
}
