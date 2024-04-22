import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_admin/screens/add_quiz.dart';
import 'package:quiz_admin/screens/categody_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.grey.shade300,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.category_rounded),
            icon: Icon(Icons.category_outlined),
            label: 'Add Category',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.quiz_rounded),
            icon: Badge(child: Icon(Icons.quiz_outlined)),
            label: 'Add Quiz',
          ),
        ],
      ),
      appBar: AppBar(
        // title: const Text(
        //   'Add quiz',
        //   style: TextStyle(
        //     fontSize: 25,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: <Widget>[
        /// Home page
        const CategoryScreen(),

        /// Notifications page
        const AddQuizScreen(),
      ][currentPageIndex],
    );
  }
}
