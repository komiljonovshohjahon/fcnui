import 'package:go_router/go_router.dart';
import 'package:registry/main.dart';
import 'package:registry/pages/pages.dart';

final registryRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const MyHomePage(title: 'Registry App for Flutter cn UI');
      },
    ),
    GoRoute(
      path: "/button",
      builder: (context, state) {
        final variant = state.uri.queryParameters['variant'];
        final String isDisabled =
            state.uri.queryParameters['isDisabled'] ?? "false";
        final String isLoading =
            state.uri.queryParameters['isLoading'] ?? "false";
        final String withIcon =
            state.uri.queryParameters['withIcon'] ?? "false";

        return ButtonPage(
            variant: variant ?? "primary",
            isDisabled: isDisabled == "true",
            isLoading: isLoading == "true",
            withIcon: withIcon == "true");
      },
    ),
  ],
);