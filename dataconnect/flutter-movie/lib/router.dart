import 'package:go_router/go_router.dart';

import 'login.dart';
import 'destination.dart';
import 'profile.dart';
import 'search.dart';
import 'actor_detail.dart';
import 'main.dart';
import 'movie_detail.dart';
import 'navigation_shell.dart';
import 'sign_up.dart';
import 'util/auth.dart';

var router = GoRouter(
  refreshListenable: Auth.instance,
  initialLocation: homePath.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: homePath.path,
              builder: (context, state) => const MyHomePage(),
            ),
            GoRoute(
                path: '/movies/:movieId',
                builder: (context, state) =>
                    MovieDetail(id: state.pathParameters['movieId']!)),
            GoRoute(
                path: "/actors",
                redirect: (context, state) =>
                    '/actors/${state.pathParameters['actorId']}',
                routes: [
                  GoRoute(
                      path: ":actorId",
                      builder: (context, state) => ActorDetail(
                          actorId: state.pathParameters['actorId']!))
                ])
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/search",
              builder: (context, state) => const Search(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: "/profile",
                redirect: (context, state) async {
                  return Auth.instance.isLoggedIn ? null : '/login';
                },
                builder: (context, state) => const Profile()),
            GoRoute(
              path: "/login",
              builder: (context, state) => const Login(),
              redirect: (context, state) async {
                return Auth.instance.isLoggedIn ? '/profile' : null;
              },
            ),
            GoRoute(
              path: "/signup",
              builder: (context, state) => const SignUp(),
              redirect: (context, state) async {
                return Auth.instance.isLoggedIn ? '/profile' : null;
              },
            )
          ],
        )
      ],
    )
  ],
);
