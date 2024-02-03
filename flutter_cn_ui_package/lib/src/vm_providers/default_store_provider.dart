import 'package:flutter/material.dart';
import 'package:flutter_cn_ui_package/src/dependency_injection/init.dart';
import 'package:flutter_cn_ui_package/src/store/store.dart';

class DefaultStoreProvider extends StatelessWidget {
  final Widget child;
  DefaultStoreProvider({super.key, required this.child}) {
    initDependency();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("DefaultStoreProvider.build complete");
    return StoreProvider(store: fcnGetIt.get<Store<AppState>>(), child: child);
  }
}
