import '../chat/index.dart';
import '../themes/icon_button.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../themes/widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:text_search/text_search.dart';

class AddMemberWidget extends StatefulWidget {
  const AddMemberWidget({
    Key key,
    this.chat,
  }) : super(key: key);

  final ChatsRecord chat;

  @override
  _AddMemberWidgetState createState() => _AddMemberWidgetState();
}

class _AddMemberWidgetState extends State<AddMemberWidget> {
  Map<UsersRecord, bool> checkboxListTileValueMap = {};
  List<UsersRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  List<UsersRecord> simpleSearchResults = [];
  TextEditingController textController;
  ChatsRecord groupChat;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 24,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppTheme.of(context).alternate,
            size: 24,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Friends to chat',
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Mukta',
                    fontSize: 16,
                  ),
            ),
            Text(
              'Select the friends to add to chat.',
              style: AppTheme.of(context).bodyText2,
            ),
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
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
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: textController,
                            onChanged: (_) => EasyDebounce.debounce(
                              'textController',
                              Duration(milliseconds: 900),
                              () => setState(() {}),
                            ),
                            onFieldSubmitted: (_) async {
                              await queryUsersRecordOnce()
                                  .then(
                                    (records) => simpleSearchResults =
                                        TextSearch(
                                      records
                                          .map(
                                            (record) => TextSearchItem(record, [
                                              record.email,
                                              record.displayName,
                                              record.userRole
                                            ]),
                                          )
                                          .toList(),
                                    )
                                            .search(textController.text)
                                            .map((r) => r.object)
                                            .toList(),
                                  )
                                  .onError((_, __) => simpleSearchResults = [])
                                  .whenComplete(() => setState(() {}));
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Search for teammates...',
                              hintText: 'Find your teammates',
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
                                color: AppTheme.of(context).alternate,
                              ),
                              suffixIcon: textController.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () => setState(
                                        () => textController?.clear(),
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        color: AppTheme.of(context)
                                            .alternate,
                                        size: 16,
                                      ),
                                    )
                                  : null,
                            ),
                            style:
                                AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Mukta',
                                      color: Color(0xFF151B1E),
                                    ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final searchResults = simpleSearchResults?.toList() ?? [];
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: searchResults.length,
                    itemBuilder: (context, searchResultsIndex) {
                      final searchResultsItem =
                          searchResults[searchResultsIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                color: Color(0xFFDBE2E7),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color:
                                      AppTheme.of(context).primaryText,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 2, 2, 2),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          searchResultsItem.photoUrl,
                                          'https://media.discordapp.net/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 0, 0, 0),
                                    child: CheckboxListTile(
                                      value: checkboxListTileValueMap[
                                              searchResultsItem] ??=
                                          widget.chat.users.toList().contains(
                                              searchResultsItem.reference),
                                      onChanged: (newValue) => setState(() =>
                                          checkboxListTileValueMap[
                                              searchResultsItem] = newValue),
                                      title: Text(
                                        searchResultsItem.displayName,
                                        style: AppTheme.of(context)
                                            .subtitle1,
                                      ),
                                      subtitle: Text(
                                        searchResultsItem.userRole,
                                        style: AppTheme.of(context)
                                            .bodyText2,
                                      ),
                                      tileColor: Color(0xFFF5F5F5),
                                      activeColor: AppTheme.of(context)
                                          .primaryText,
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
              child: AppButtonWidget(
                onPressed: () async {
                  groupChat = await AppChatManager.instance.addGroupMembers(
                    widget.chat,
                    checkboxListTileCheckedItems
                        .map((e) => e.reference)
                        .toList(),
                  );
                  Navigator.pop(context);

                  setState(() {});
                },
                text: 'Invite to Chat',
                options: AppButtonOptions(
                  width: double.infinity,
                  height: 45,
                  color: AppTheme.of(context).secondaryBackground,
                  textStyle: AppTheme.of(context).subtitle2,
                  elevation: 1,
                  borderSide: BorderSide(
                    color: AppTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
