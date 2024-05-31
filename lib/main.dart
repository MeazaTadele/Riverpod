import 'package:flutter/material.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/presentation/screens/admin_screen/adminDetail.dart';
import 'package:flutter_project/presentation/screens/admin_screen/basepage.dart';
import 'package:flutter_project/presentation/screens/admin_screen/create_post_page.dart';
import 'package:flutter_project/presentation/screens/admin_screen/profile.dart';
import 'package:flutter_project/presentation/screens/comment_page.dart';
import 'package:flutter_project/presentation/screens/create_post_page.dart';
import 'package:flutter_project/presentation/screens/detailpage.dart';
import 'package:flutter_project/presentation/screens/login.dart';
import 'package:flutter_project/presentation/screens/noaccount.dart';
import 'package:flutter_project/presentation/screens/signup.dart';
import 'package:flutter_project/presentation/screens/userdetailpage.dart';
import 'package:flutter_project/presentation/screens/withaccount.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:flutter_project/repositories/api_post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import other necessary screens and models

void main() {
  runApp(ProviderScope(child: MyApp()));

}

class MyApp extends StatelessWidget {

  final ApiPostRepository postRepository = ApiPostRepository();

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => NoAccount(),
        ),
        GoRoute(
              path: '/user-details',
              builder: (context, state) => UserDetailsPage(),
            ),
        GoRoute(
          path: '/noaccount',
          builder: (context, state) => NoAccount(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/withaccount',
          builder: (context, state) => WithAccount(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LogInPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => SignUpPage(),
        ),
    
        GoRoute(
          path: '/add',
          builder: (context, state) => LostFoundForm(),
        ),
        GoRoute(
          path: '/admin_addpost',
          builder: (context, state) => adminAddPost(),
        ),
        GoRoute(
          path: '/admin_profile',
          builder: (context, state) => adminprofile(),
        ),
        GoRoute(
          path: '/admin_home',
          builder: (context, state) => adminbasescreen(),
        ),
        GoRoute(
          path: '/detail/:postId',
          builder: (context, state) {
            final String postId = state.params['postId']!;
            return FutureBuilder<Post>(
              future: postRepository.getPostById(postId), // Correctly using the instance
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ItemPage(item: snapshot.data!); // Ensure your ItemPage takes a Post object
                } else {
                  return const Text('Post not found');
                }
              },
            );
          },
        ),

        GoRoute(
          path: '/admin_detail/:postId',
          builder: (context, state) {
            final String postId = state.params['postId']!;
            return FutureBuilder<Post>(
              future: postRepository.getPostById(postId), // Correctly using the instance
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return AdminDetailPage(item: snapshot.data!); // Ensure your ItemPage takes a Post object
                } else {
                  return const Text('Post not found');
                }
              },
            );
          },
        ),

        GoRoute(
          path: '/comment/:postId',
          builder: (context, state) {
            final postId = state.params['postId']!;
            return CommentPage(postId: postId);
          },
        ),
        GoRoute(
          path: '/admin_comment/:postId',
          builder: (context, state) {
            final postId = state.params['postId']!;
            return CommentPage(postId: postId);
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: Text('Page Not Found')),
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      ),
    );

    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider
    );
  }
}
