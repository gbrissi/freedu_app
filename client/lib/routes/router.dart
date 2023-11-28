import 'package:client/screens/home/components/post_search/components/date_filter.dart';
import 'package:client/screens/post_add_tags/post_add_tags.dart';
import 'package:client/screens/create_post/create_post.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/target_user_profile/target_user_profile.dart';
import 'package:client/screens/user_profile/user_profile.dart';
import 'package:client/shared/components/theme_builder.dart';
import 'package:client/shared/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/activity/activity.dart';
import '../screens/auth/login/login.dart';
import '../screens/google_login/google_login.dart';
import '../screens/home/components/post_search/models/date_range.dart';
import '../screens/post/post.dart';
import '../screens/auth/register/register.dart';
import '../screens/settings/settings.dart';
import '../shared/providers/theme_provider.dart';

Widget _renderTagsScreen(context, state) {
  List<String> tags = <String>[];
  if (state.extra != null) {
    tags = state.extra as List<String>;
  }

  return PostAddTags(
    value: tags,
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (_, __, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(),
            ),
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(),
            )
          ],
          child: ThemeBuilder(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
            name: 'login',
            path: '/login',
            builder: (context, state) => const Login(),
            routes: <RouteBase>[
              GoRoute(
                name: "googleLogin",
                path: "google",
                builder: (context, state) => GoogleLogin(
                  uri: state.extra as Uri,
                ),
              )
            ]),
        GoRoute(
          name: 'register',
          path: '/register',
          builder: (context, state) => const Register(),
        ),
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const Home(),
          routes: <RouteBase>[
            GoRoute(
              name: "dateFilter",
              path: 'filter/date',
              builder: (context, state) {
                DateRange value = DateRange.empty();
                if (state.extra != null) {
                  value = state.extra as DateRange;
                }

                return DateFilter(
                  value: value,
                );
              },
            ),
            GoRoute(
              name: 'post',
              path: 'post',
              builder: (context, state) => Post(
                postId: state.extra! as int,
              ),
              routes: <RouteBase>[
                GoRoute(
                  name: 'filterTags',
                  path: 'tags',
                  builder: _renderTagsScreen,
                ),
              ],
            ),
            GoRoute(
              name: 'createPost',
              path: 'create/post',
              builder: (context, state) => const CreatePost(),
              routes: <RouteBase>[
                GoRoute(
                  name: 'addTags',
                  path: 'tags',
                  builder: _renderTagsScreen,
                ),
              ],
            ),
            GoRoute(
              name: 'settings',
              path: 'settings',
              builder: (context, state) => const Settings(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'profile',
                  name: 'editProfile',
                  builder: (context, state) => const UserProfile(),
                ),
              ],
            ),
            GoRoute(
              name: "userProfile",
              path: 'user/profile',
              builder: (context, state) => const TargetUserProfile(),
            ),
            GoRoute(
              name: "activity",
              path: 'activity',
              builder: (context, state) => const Activity(),
            )
          ],
        ),
      ],
    ),
  ],
);
