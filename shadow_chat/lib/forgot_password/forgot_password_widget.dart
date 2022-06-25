import '../auth/auth_util.dart';
import '../themes/theme.dart';
import '../themes/widgets.dart';
import 'package:flutter/material.dart';


class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key key}) : super(key: key);

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  TextEditingController emailAddressController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController(text: currentUserEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: AppTheme.of(context).alternate,
            size: 32,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: AppTheme.of(context).subtitle1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: TextFormField(
                controller: emailAddressController,
                readOnly: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your Email Address',
                  hintText: 'Please enter a email...',
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
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                ),
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: AppTheme.of(context).tertiaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: AppButtonWidget(
                onPressed: () async {
                  if (emailAddressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Email required!',
                        ),
                      ),
                    );
                    return;
                  }
                  await resetPassword(
                    email: emailAddressController.text,
                    context: context,
                  );
                  Navigator.pop(context);
                },
                text: 'Send Reset Link',
                options: AppButtonOptions(
                  width: 230,
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
          ],
        ),
      ),
    );
  }
}
