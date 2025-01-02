import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:new_prepaid_demo/core/service_locator.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/single_button_dialog.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/profile/blocs/change_password_bloc.dart';
import 'package:new_prepaid_demo/presentation/profile/formz/confirm_email_input.dart';
import 'package:new_prepaid_demo/presentation/profile/formz/password_input.dart';
import 'package:new_prepaid_demo/presentation/profile/widgets/update_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _key = GlobalKey<FormState>();
  late _ChangePasswordFormzState _state;

  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _state = _ChangePasswordFormzState();

    _currentPasswordController = TextEditingController(text: _state.newPassword.value)
      ..addListener(_onCurrentPasswordChanged);
    _newPasswordController = TextEditingController(text: _state.newPassword.value)
      ..addListener(_onNewPasswordChanged);
    _confirmPasswordController = TextEditingController(text: _state.confirmPassword.value)
      ..addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<ChangePasswordBloc>(),
      child: StylishScaffold(
        title: "Change Password",
        child: Column(
          children: [
            Expanded(
              child: _ChangeEmailForm(
                formKey: _key,
                formzState: _state,
                newEmailController: _newPasswordController,
                confirmEmailController: _confirmPasswordController,
                onReset: _resetForm,
              ),
            ),
            UpdateButton(
              label: "Update",
              onPressed: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  void _onCurrentPasswordChanged() {
    setState(() {
      _state = _state.copyWith(currentPassword: PasswordInput.dirty(_newPasswordController.text));
    });
  }

  void _onNewPasswordChanged() {
    setState(() {
      _state = _state.copyWith(newPassword: PasswordInput.dirty(_newPasswordController.text));
      _state = _state.copyWith(
          confirmPassword: ConfirmEmailInput.pure(toVerify: _newPasswordController.text));
    });
  }

  void _onConfirmPasswordChanged() {
    setState(() {
      _state = _state.copyWith(
          confirmPassword: ConfirmEmailInput.dirty(
        toVerify: _newPasswordController.text,
        value: _confirmPasswordController.text,
      ));
    });
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    context.read<ChangePasswordBloc>().add(
          ChangePasswordRequested(
            currentPassword: _currentPasswordController.text,
            newPassword: _newPasswordController.text,
          ),
        );

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();
  }

  void _resetForm() {
    _key.currentState!.reset();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    setState(() => _state = _ChangePasswordFormzState());
  }
}

//region _ChangeEmailForm
class _ChangeEmailForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final _ChangePasswordFormzState formzState;
  final TextEditingController newEmailController;
  final TextEditingController confirmEmailController;
  final void Function() onReset;

  const _ChangeEmailForm({
    super.key,
    required this.formKey,
    required this.formzState,
    required this.newEmailController,
    required this.confirmEmailController,
    required this.onReset,
  });

  @override
  State<_ChangeEmailForm> createState() => _ChangeEmailFormState();
}

class _ChangeEmailFormState extends State<_ChangeEmailForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: _handleListener,
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
              key: const Key('changePasswordForm_currentPasswordInput'),
              controller: widget.newEmailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                labelText: 'Current Password',
              ),
              validator: (value) => widget.formzState.newPassword.validator(value ?? '')?.text(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              key: const Key('changePasswordForm_newPasswordInput'),
              controller: widget.newEmailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                labelText: 'New Password',
                helperText: 'At least 8 characters including one letter and number',
                helperMaxLines: 2,
              ),
              validator: (value) => widget.formzState.newPassword.validator(value ?? '')?.text(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              key: const Key('changePasswordForm_confirmPasswordInput'),
              controller: widget.confirmEmailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                labelText: 'Confirm Password',
                errorMaxLines: 2,
              ),
              validator: (value) =>
                  widget.formzState.confirmPassword.validator(value ?? '')?.text(),
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  void _handleListener(BuildContext context, ChangePasswordState state) {
    switch (state) {
      case ChangePasswordLoading():
        context.loaderOverlay.show();
      case ChangePasswordSuccess():
        context.loaderOverlay.hide();
        widget.onReset();
        showDialog(
          context: context,
          builder: (ctx) {
            return SingleButtonDialog(
              title: "Profile Update",
              message: "Password has been updated. Please re-login again.",
              label: 'OKAY',
              onPressed: () {
                context.pop();
              },
            );
          },
        );
      case ChangePasswordFailure():
        context.loaderOverlay.hide();
        showDialog(
          context: context,
          builder: (ctx) {
            return SingleButtonDialog(
              title: "Profile Update",
              message: state.exception.toString(),
              label: 'OKAY',
              onPressed: () {
                context.pop();
              },
            );
          },
        );
      default:
        break;
    }
  }
}
//endregion

//region _ChangePasswordFormzState
class _ChangePasswordFormzState with FormzMixin {
  final PasswordInput currentPassword;
  final PasswordInput newPassword;
  final ConfirmEmailInput confirmPassword;

  _ChangePasswordFormzState({
    PasswordInput? currentPassword,
    PasswordInput? newPassword,
    ConfirmEmailInput? confirmPassword,
  })  : currentPassword = currentPassword ?? PasswordInput.pure(),
        newPassword = newPassword ?? PasswordInput.pure(),
        confirmPassword = confirmPassword ?? ConfirmEmailInput.pure();

  _ChangePasswordFormzState copyWith({
    PasswordInput? currentPassword,
    PasswordInput? newPassword,
    ConfirmEmailInput? confirmPassword,
  }) {
    return _ChangePasswordFormzState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [currentPassword, newPassword, confirmPassword];
}
//endregion
