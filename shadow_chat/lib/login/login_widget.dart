import '../auth/auth_util.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../themes/widgets.dart';
import '../forgot_password/forgot_password_widget.dart';
import '../main.dart';
import '../register/register_widget.dart';
import 'package:flutter/material.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
            child: Image.asset(
              'assets/images/schat.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
            child: TextFormField(
              controller: emailTextController,
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
            padding: EdgeInsetsDirectional.fromSTEB(12, 10, 20, 0),
            child: TextFormField(
              controller: passwordTextController,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
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
                    () => passwordVisibility = !passwordVisibility,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    passwordVisibility
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
                final user = await signInWithEmail(
                  context,
                  emailTextController.text,
                  passwordTextController.text,
                );
                if (user == null) {
                  return;
                }

                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: NavBarPage(initialPage: 'chatMain'),
                  ),
                );
              },
              text: 'Log In',
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
                    'Don\'t have an account?',
                    style: AppTheme.of(context).bodyText1,
                  ),
                ),
                AppButtonWidget(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 150),
                        reverseDuration: Duration(milliseconds: 150),
                        child: RegisterWidget(),
                      ),
                    );
                  },
                  text: 'Create Account',
                  options: AppButtonOptions(
                    width: 140,
                    height: 35,
                    color: AppTheme.of(context).secondaryBackground,
                    textStyle: AppTheme.of(context).bodyText1,
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: AppButtonWidget(
              onPressed: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 250),
                    reverseDuration: Duration(milliseconds: 250),
                    child: ForgotPasswordWidget(),
                  ),
                );
              },
              text: 'Forgot Password?',
              options: AppButtonOptions(
                width: 200,
                height: 40,
                color: AppTheme.of(context).secondaryBackground,
                textStyle: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Mukta',
                      color: AppTheme.of(context).tertiaryColor,
                    ),
                elevation: 1,
                borderSide: BorderSide(
                  color: AppTheme.of(context).primaryText,
                  width: 1,
                ),
                borderRadius: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
