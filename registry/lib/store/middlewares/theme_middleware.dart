import 'package:registry/store/store.dart';

class ThemeStateMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    switch (action.runtimeType) {
      case ChangeThemeModeAction:
        return _changeThemeModeAction(store, action, next);
      case ChangeFlexSchemeAction:
        return _changeFlexSchemeAction(store, action, next);
    }
  }

  void _changeThemeModeAction(Store<AppState> store,
      ChangeThemeModeAction action, NextDispatcher next) {
    next(UpdateThemeState(themeMode: action.themeMode));
  }

  void _changeFlexSchemeAction(Store<AppState> store,
      ChangeFlexSchemeAction action, NextDispatcher next) {
    next(UpdateThemeState(flexScheme: action.flexScheme));
  }
}
