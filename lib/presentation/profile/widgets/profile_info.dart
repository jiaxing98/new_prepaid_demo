import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_prepaid_demo/core/extensions/build_context.dart';
import 'package:new_prepaid_demo/domain/models/profile.dart';
import 'package:new_prepaid_demo/router/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileInfo extends StatelessWidget {
  final Profile profile;
  final bool isLoading;

  const ProfileInfo({super.key, required this.profile}) : isLoading = false;

  ProfileInfo.loading({super.key})
      : isLoading = true,
        profile = Profile(
          name: "Vanessa Lim Mei Ngoh",
          email: "whysoserious@redone.com.my",
          plan: "Pack Ultra",
          accountNumber: "395873295",
        );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (ctx, index) => SizedBox(height: 16.0),
      itemBuilder: (ctx, index) {
        return [
          _ProfileInfoItem(
            title: "Name",
            description: profile.name,
            isLoading: isLoading,
          ),
          _ProfileInfoItem(
            title: "E-mail",
            description: profile.email,
            isLoading: isLoading,
            action: _ProfileInfoAction(
              label: 'Edit',
              onTap: isLoading
                  ? null
                  : () {
                      context.pushNamed(
                        Routes.changeEmail,
                        queryParameters: {"current_email": profile.email},
                      );
                    },
            ),
          ),
          _ProfileInfoItem(
            title: "Password",
            description: "********",
            isLoading: isLoading,
            action: _ProfileInfoAction(
              label: 'Edit',
              onTap: () {
                context.pushNamed(Routes.changePassword);
              },
            ),
          ),
          _ProfileInfoItem(
            title: "Plan",
            description: profile.plan,
            isLoading: isLoading,
          ),
          _ProfileInfoItem(
            title: "Account Number",
            description: profile.accountNumber,
            isLoading: isLoading,
          ),
        ][index];
      },
    );
  }
}

//region _ProfileInfoItem
class _ProfileInfoItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isLoading;
  final Widget? action;

  const _ProfileInfoItem({
    super.key,
    required this.title,
    required this.description,
    required this.isLoading,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        border: Border.all(color: context.colorScheme.primaryContainer),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Skeletonizer(
                enabled: isLoading,
                child: Text(
                  description,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
//endregion

//region _ProfileInfoAction
class _ProfileInfoAction extends StatelessWidget {
  final String label;
  final void Function()? onTap;

  const _ProfileInfoAction({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: context.colorScheme.primaryContainer,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
//endregion
