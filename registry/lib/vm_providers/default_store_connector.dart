import 'package:flutter/material.dart';
import 'package:registry/store/store.dart';

class DefaultStoreConnector<T> extends StatelessWidget {
  final ViewModelBuilder<T> builder;
  final StoreConverter<AppState, T> converter;
  const DefaultStoreConnector(
      {super.key, required this.builder, required this.converter});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, T>(
      converter: converter,
      builder: builder,
    );
  }
}
