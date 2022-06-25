import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../complete_profile/complete_profile_widget.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../themes/widgets.dart';
import '../login/login_widget.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController confirmPasswordController;
  bool confirmPasswordVisibility;
  TextEditingController emailAddressController;
  TextEditingController passwordController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    confirmPasswordController = TextEditingController();
    confirmPasswordVisibility = false;
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 110),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
              child: Image.asset(
                'assets/images/schat.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 10),
              child: TextFormField(
                controller: emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.of(context).primaryText,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.of(context).primaryText,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Mukta',
                      color: AppTheme.of(context).tertiaryColor,
                    ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 10),
              child: TextFormField(
                controller: passwordController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Choose Password',
                  hintText: 'Choose Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.of(context).primaryText,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.of(context).primaryText,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Mukta',
                      color: AppTheme.of(context).tertiaryColor,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: !confirmPasswordVisibility,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.of(context).primaryText,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.of(context).primaryText,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                      () => confirmPasswordVisibility =
                          !confirmPasswordVisibility,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      confirmPasswordVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.of(context).grayDark,
                      size: 24,
                    ),
                  ),
                ),
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Mukta',
                      color: AppTheme.of(context).tertiaryColor,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: AppButtonWidget(
                onPressed: () async {
                  if (passwordController?.text !=
                      confirmPasswordController?.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Passwords don\'t match!',
                        ),
                      ),
                    );
                    return;
                  }

                  final user = await createAccountWithEmail(
                    context,
                    emailAddressController.text,
                    passwordController.text,
                  );
                  if (user == null) {
                    return;
                  }

                  final usersCreateData = createUsersRecordData(
                    email: emailAddressController.text,
                  );
                  await UsersRecord.collection
                      .doc(user.uid)
                      .update(usersCreateData);

                  await Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: CompleteProfileWidget(),
                    ),
                    (r) => false,
                  );
                },
                text: 'Create Account',
                options: AppButtonOptions(
                  width: 300,
                  height: 45,
                  color: AppTheme.of(context).secondaryBackground,
                  textStyle: AppTheme.of(context).subtitle2,
                  elevation: 1,
                  borderSide: BorderSide(
                    color: AppTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: 4,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                    child: Text(
                      'Already have an account?',
                      style: AppTheme.of(context).bodyText1,
                    ),
                  ),
                  AppButtonWidget(
                    onPressed: () async {
                      await Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 150),
                          reverseDuration: Duration(milliseconds: 150),
                          child: LoginWidget(),
                        ),
                        (r) => false,
                      );
                    },
                    text: 'Login',
                    options: AppButtonOptions(
                      width: 100,
                      height: 40,
                      color: AppTheme.of(context).secondaryBackground,
                      textStyle:
                          AppTheme.of(context).subtitle2.override(
                                fontFamily: 'Mukta',
                                color: AppTheme.of(context).primaryText,
                              ),
                      elevation: 1,
                      borderSide: BorderSide(
                        color: AppTheme.of(context).primaryText,
                        width: 1,
                      ),
                      borderRadius: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
