import 'package:flutter/material.dart';
class UsersSelectorWidget extends StatelessWidget {
  const UsersSelectorWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
             
      },
      child: child,
    );
  }
}

// this widget will handle the search of team members from UsersCollection until now

// this widget uses (chooseMembersModel) from admin folders because it needs (choose members page), but it will be changed 
// later 

//! choose member/choose multible members page, will ba a part of user Feature