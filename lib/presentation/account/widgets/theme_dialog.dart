import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_prepaid_demo/core/extensions/extensions.dart';
import 'package:new_prepaid_demo/core/theme/theme.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Theme",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8.0),
                ...appThemes.keys.map(
                  (e) => ChangeThemeButton(
                    label: e.toUpperCase(),
                    onPressed: () {
                      context.read<ThemeCubit>().changeTheme(e);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//region ChangeThemeButton
class ChangeThemeButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const ChangeThemeButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          side: WidgetStateProperty.resolveWith(
            (states) {
              return states.contains(WidgetState.disabled)
                  ? null
                  : BorderSide(color: context.colorScheme.primary, width: 2.0);
            },
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
//endregion
