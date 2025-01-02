// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_prepaid_demo/core/theme/theme_cubit.dart';
//
// class ThemeDialog extends StatelessWidget {
//   const ThemeDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.secondary,
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: BlocBuilder<ThemeCubit, ThemeState>(
//           builder: (context, state) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Theme",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 ChangeThemeButton(
//                   label: "COLD STONE",
//                   onPressed: () {
//                     context.read<ThemeCubit>().changeTheme(AppTheme.coldStoneKey);
//                   },
//                   primary: AppTheme.coldStone.value.primaryColor,
//                   onPrimary: AppTheme.coldStone.value.colorScheme.onPrimary,
//                 ),
//                 SizedBox(height: 8.0),
//                 ChangeThemeButton(
//                   label: "VOLCANO",
//                   onPressed: () {
//                     context.read<ThemeCubit>().changeTheme(AppTheme.volcanoKey);
//                   },
//                   primary: AppTheme.volcano.value.primaryColor,
//                   onPrimary: AppTheme.volcano.value.colorScheme.onPrimary,
//                 ),
//                 SizedBox(height: 8.0),
//                 ChangeThemeButton(
//                   label: "FOREST",
//                   onPressed: () {
//                     context.read<ThemeCubit>().changeTheme(AppTheme.forestKey);
//                   },
//                   primary: AppTheme.forest.value.primaryColor,
//                   onPrimary: AppTheme.forest.value.colorScheme.onPrimary,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// //region ChangeThemeButton
// class ChangeThemeButton extends StatelessWidget {
//   final String label;
//   final Color primary;
//   final Color onPrimary;
//   final void Function()? onPressed;
//
//   const ChangeThemeButton({
//     super.key,
//     required this.label,
//     required this.primary,
//     required this.onPrimary,
//     this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//         ),
//         foregroundColor: MaterialStateProperty.resolveWith(
//           (states) {
//             return states.contains(MaterialState.disabled) ? null : onPrimary;
//           },
//         ),
//         side: MaterialStateProperty.resolveWith(
//           (states) {
//             return states.contains(MaterialState.disabled)
//                 ? null
//                 : BorderSide(color: primary, width: 2.0);
//           },
//         ),
//       ),
//       onPressed: onPressed,
//       child: Text(label),
//     );
//   }
// }
// //endregion
