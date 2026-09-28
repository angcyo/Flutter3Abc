import 'package:flutter/material.dart';
import 'package:flutter3_abc/flutter3_abc.dart';
import 'package:flutter3_app/flutter3_app.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/09/28
///
/// hiblob
class HiblobAbc extends StatefulWidget {
  const HiblobAbc({super.key});

  @override
  State<HiblobAbc> createState() => _HiblobAbcState();
}

class _HiblobAbcState extends State<HiblobAbc> with BaseAbcStateMixin {
  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      //--
      [
        for (final item in HiblobExpressionType.values)
          item.name
              .hiblob(size: 100, expressionType: item)
              .columnOf(item.name.text()),
      ].flowLayout(
        gap: kX,
        padding: insets(all: kX),
      )!,
      //--
      [
        for (final item in HiblobExpressionType.values)
          item.name
              .hiblob(size: 100, isCircle: false, expressionType: item)
              .columnOf(item.name.text()),
      ].flowLayout(
        gap: kX,
        padding: insets(all: kX),
      )!,
      //--
      [
        for (final item in HiblobExpressionType.values)
          item.name
              .hiblob(
                size: 100,
                isCircle: false,
                expressionType: item,
                animate: true,
              )
              .columnOf(item.name.text()),
      ].flowLayout(
        gap: kX,
        padding: insets(all: kX),
      )!,
      //--
      [
        for (final item in HiblobExpressionType.values)
          item.name
              .hiblob(
                size: 100,
                isCircle: false,
                expressionType: item,
                animate: true,
                animation: .hover,
              )
              .columnOf(item.name.text()),
      ].flowLayout(
        gap: kX,
        padding: insets(all: kX),
      )!,
      //--
      [
        for (final item in HiblobExpressionType.values)
          item.name
              .hiblob(
                size: 100,
                isCircle: false,
                expressionType: item,
                animate: true,
                animation: .hover,
                background: .none,
              )
              .columnOf(item.name.text()),
      ].flowLayout(
        gap: kX,
        padding: insets(all: kX),
      )!,
    ];
  }
}
