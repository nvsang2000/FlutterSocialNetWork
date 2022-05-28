import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/item/textField/textfield_search.dart';
import 'package:test/models/users.dart';
import 'package:test/preference/user_peference.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/messeger/item_user.dart';
import 'package:test/screens/search/search_widget.dart';
import 'package:test/screens/search/user_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  List<Users> listUser = [];
  List<Users> listSearch = [];
  String? token;
  String query = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getAllUser();
    listUser = userProvider.getAllUserList;

    return Scaffold(
      body: Builder(
          builder: (context) => CustomScrollView(
                slivers: <Widget>[
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context)),
                  SliverToBoxAdapter(
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SearchWidget(
                            text: query,
                            listUser: listUser,
                            hintText: "Search User",
                            onChanged: searchFood)),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => token != null &&
                                  listSearch.length != 0
                              ? ListView.builder(
                                  itemCount: listSearch.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => UserItem(
                                      token: token!,
                                      id: listSearch[index].iduser!,
                                      image: listSearch[index].avatarImage!,
                                      username: listSearch[index].username!),
                                )
                              : Container(),
                          childCount: 1))
                ],
              )),
    );
  }

  void searchFood(String query) {
    if (query == '') {
      this.listSearch = [];
    } else {
      final users = listUser.where((element) {
        final name = element.username!.toLowerCase();
        final search = query.toLowerCase();
        return name.contains(search);
      }).toList();
      setState(() {
        this.query = query;
        this.listSearch = users;
      });
    }
  }

  Future<void> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = await pref.getString('token');
    setState(() {
      token = _token;
    });
  }
}
