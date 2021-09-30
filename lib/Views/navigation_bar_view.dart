import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/post_list_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../runtime_data.dart';
import 'AddingPost/adding_post_view.dart';
import 'Post/post_list_view.dart';
import 'Profile/profile_view.dart';

class NavigationBarView extends StatefulWidget {
  //List<Widget> listTab;

  //NavigationBarView(this.listTab);

  State<StatefulWidget> createState() {
    //return _NavigationBarView(this.listTab);
    return _NavigationBarView();
  }
}

class _NavigationBarView extends State<NavigationBarView> {
  List<Widget> listTab = [
    ChangeNotifierProvider(
      create: (context) => PostListViewModel(PostListType.all),
      child: PostListView(),
    ),
    AddingPostView(),
    ProfileView(
        ProfileViewModel(RuntimeData.currentUserProfile)),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
          240, 241, 224, 195),
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: Color.fromARGB(
            240, 239, 184, 83),
        centerTitle: true,
        title: const Text(
          'ImageApp',
          style: TextStyle(
              color: Color.fromARGB(
                  240, 90, 59, 2),
              fontFamily: 'Helvetica',
              fontSize: 22),
        ),
      ),
      body: IndexedStack(
        children: listTab,
        index: _currentIndex,
      ),
      bottomNavigationBar: SizedBox(
        height: 54,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Color.fromARGB(240, 239, 184, 83),
          showUnselectedLabels: true,
          onTap: (newIndex) => setState(() => _currentIndex = newIndex),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 24,
                ),
                label:'Лента'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  size: 24,
                ),
                label:'Добавить'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 24,
                ),
                label: 'Профиль')
          ],
        ),
      ),
    );
  }
}
