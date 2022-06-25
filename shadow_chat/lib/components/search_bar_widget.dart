import '../themes/theme.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';


class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key key}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: AppTheme.of(context).dark900,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 10,
                child: TextFormField(
                  controller: textController,
                  onChanged: (_) => EasyDebounce.debounce(
                    'textController',
                    Duration(milliseconds: 2000),
                    () => setState(() {}),
                  ),
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Search for friends...',
                    labelStyle: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Mukta',
                          color: Color(0xFF82878C),
                        ),
                    hintText: 'Find your friend by na',
                    hintStyle: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Mukta',
                          color: Color(0xFF95A1AC),
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x004B39EF),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x004B39EF),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppTheme.of(context).grayIcon,
                    ),
                    suffixIcon: textController.text.isNotEmpty
                        ? InkWell(
                            onTap: () => setState(
                              () => textController?.clear(),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: AppTheme.of(context).grayIcon,
                              size: 16,
                            ),
                          )
                        : null,
                  ),
                  style: AppTheme.of(context).bodyText1.override(
                        fontFamily: 'Mukta',
                        color: Color(0xFF151B1E),
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
