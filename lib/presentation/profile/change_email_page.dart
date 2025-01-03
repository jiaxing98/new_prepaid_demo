import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:new_prepaid_demo/core/service_locator.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/dialogs/single_button_dialog.dart';
import 'package:new_prepaid_demo/presentation/_shared/widgets/stylish_scaffold.dart';
import 'package:new_prepaid_demo/presentation/profile/blocs/change_email_bloc.dart';
import 'package:new_prepaid_demo/presentation/profile/blocs/profile_bloc.dart';
import 'package:new_prepaid_demo/presentation/profile/formz/confirm_email_input.dart';
import 'package:new_prepaid_demo/presentation/profile/formz/email_input.dart';
import 'package:new_prepaid_demo/presentation/profile/widgets/update_button.dart';

class ChangeEmailPage extends StatefulWidget {
  final String? currentEmail;

  const ChangeEmailPage({super.key, required this.currentEmail});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late _ChangeEmailFormzState _state;

  late final TextEditingController _newEmailController;
  late final TextEditingController _confirmEmailController;

  @override
  void initState() {
    super.initState();
    _state = _ChangeEmailFormzState();

    _newEmailController = TextEditingController(text: _state.newEmail.value)
      ..addListener(_onNewEmailChanged);
    _confirmEmailController = TextEditingController(text: _state.confirmEmail.value)
      ..addListener(_onConfirmEmailChanged);
  }

  @override
  void dispose() {
    _newEmailController.removeListener(_onNewEmailChanged);
    _confirmEmailController.removeListener(_onConfirmEmailChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(
          value: sl.get(),
        ),
        BlocProvider<ChangeEmailBloc>(
          create: (context) => sl.get(),
        ),
      ],
      child: StylishScaffold(
        title: "Change Email",
        child: widget.currentEmail == null
            ? const Center(child: Text("Something went wrong."))
            : Column(
                children: [
                  Expanded(
                    child: _ChangeEmailForm(
                      formKey: _key,
                      formzState: _state,
                      currentEmail: widget.currentEmail!,
                      newEmailController: _newEmailController,
                      confirmEmailController: _confirmEmailController,
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

  void _onNewEmailChanged() {
    setState(() {
      _state = _state.copyWith(newEmail: EmailInput.dirty(_newEmailController.text));
      _state =
          _state.copyWith(confirmEmail: ConfirmEmailInput.pure(toVerify: _newEmailController.text));
    });
  }

  void _onConfirmEmailChanged() {
    setState(() {
      _state = _state.copyWith(
          confirmEmail: ConfirmEmailInput.dirty(
        toVerify: _newEmailController.text,
        value: _confirmEmailController.text,
      ));
    });
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    context.read<ChangeEmailBloc>().add(
          ChangeEmailRequested(
            newEmail: _newEmailController.text,
            confirmEmail: _confirmEmailController.text,
          ),
        );

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();
  }

  void _resetForm() {
    _key.currentState!.reset();
    _newEmailController.clear();
    _confirmEmailController.clear();
    setState(() => _state = _ChangeEmailFormzState());
  }
}

//region _ChangeEmailForm
class _ChangeEmailForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final _ChangeEmailFormzState formzState;
  final String currentEmail;
  final TextEditingController newEmailController;
  final TextEditingController confirmEmailController;
  final void Function() onReset;

  const _ChangeEmailForm({
    super.key,
    required this.formKey,
    required this.formzState,
    required this.currentEmail,
    required this.newEmailController,
    required this.confirmEmailController,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeEmailBloc, ChangeEmailState>(
      listener: _handleListener,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              key: const Key('changeEmailForm_currentEmailInput'),
              readOnly: true,
              initialValue: currentEmail,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Current Email',
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              key: const Key('changeEmailForm_newEmailInput'),
              controller: newEmailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'New Email',
                helperText: 'A valid email e.g. joe.doe@gmail.com',
              ),
              validator: (value) => formzState.newEmail.validator(value ?? '')?.text(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              key: const Key('changeEmailForm_confirmEmailInput'),
              controller: confirmEmailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Confirm Email',
                errorMaxLines: 2,
              ),
              validator: (value) => formzState.confirmEmail.validator(value ?? '')?.text(),
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  void _handleListener(BuildContext context, ChangeEmailState state) {
    switch (state) {
      case ChangeEmailLoading():
        context.loaderOverlay.show();
      case ChangeEmailSuccess():
        context.loaderOverlay.hide();
        onReset();
        showDialog(
          context: context,
          builder: (ctx) {
            return SingleButtonDialog(
              title: "Profile Update",
              message: "Email has been updated successfully!",
              label: 'OKAY',
              onPressed: () {
                context.read<ProfileBloc>().add(const ProfileFetch());
                context.pop(); // dismiss dialog
                context.pop(); // back to previous page
              },
            );
          },
        );
      case ChangeEmailFailure():
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

//region _ChangeEmailFormzState
class _ChangeEmailFormzState with FormzMixin {
  final EmailInput newEmail;
  final ConfirmEmailInput confirmEmail;

  _ChangeEmailFormzState({
    EmailInput? newEmail,
    ConfirmEmailInput? confirmEmail,
  })  : newEmail = newEmail ?? EmailInput.pure(),
        confirmEmail = confirmEmail ?? ConfirmEmailInput.pure();

  _ChangeEmailFormzState copyWith({
    EmailInput? newEmail,
    ConfirmEmailInput? confirmEmail,
  }) {
    return _ChangeEmailFormzState(
      newEmail: newEmail ?? this.newEmail,
      confirmEmail: confirmEmail ?? this.confirmEmail,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [newEmail, confirmEmail];
}
//endregion
