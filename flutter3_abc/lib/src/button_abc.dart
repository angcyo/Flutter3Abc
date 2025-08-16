part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/09
///

/// https://api.flutter.dev/flutter/material/ButtonStyle-class.html#material-3-button-types
class ButtonAbc extends StatefulWidget {
  const ButtonAbc({super.key});

  @override
  State<ButtonAbc> createState() => _ButtonAbcState();
}

class _ButtonAbcState extends State<ButtonAbc> with BaseAbcStateMixin {
  bool isChecked1 = false;
  bool isChecked2 = true;

  @override
  bool get enableFrameLoad => true;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    List<Widget> list1 = [
      ElevatedButton(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: randomTextWidget(),
      ),
      ElevatedButton(
        onPressed: null,
        child: randomTextWidget(),
      ),
    ];
    List<Widget> list2 = [
      FilledButton(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.access_alarm),
        label: randomTextWidget(),
      ),
      FilledButton(
        onPressed: null,
        child: randomTextWidget(),
      ),
      FilledButton.tonal(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      FilledButton.tonalIcon(
        onPressed: null,
        icon: const Icon(Icons.account_tree),
        label: randomTextWidget(),
      ),
    ];
    List<Widget> list3 = [
      OutlinedButton(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.account_circle_rounded),
        label: randomTextWidget(),
      ),
      OutlinedButton(
        onPressed: null,
        child: randomTextWidget(),
      ),
    ];

    List<Widget> list4 = [
      TextButton(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add_circle),
        label: randomTextWidget(),
      ),
      TextButton(
        onPressed: null,
        child: randomTextWidget(),
      ),
    ];

    List<Widget> list5 = [
      FloatingActionButton.small(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      FloatingActionButton(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      FloatingActionButton.large(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      FloatingActionButton.extended(
        onPressed: onPressed,
        icon: const Icon(Icons.accessible),
        label: randomTextWidget(),
      ),
      FloatingActionButton(
        onPressed: null,
        child: randomTextWidget(),
      ),
    ];

    List<Widget> list6 = [
      IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.ad_units),
      ),
      IconButton.filled(onPressed: onPressed, icon: const Icon(Icons.ad_units)),
      IconButton.filledTonal(
          onPressed: onPressed, icon: const Icon(Icons.ad_units)),
      IconButton.outlined(
          onPressed: onPressed, icon: const Icon(Icons.ad_units)),
      const IconButton(
        onPressed: null,
        icon: Icon(Icons.add_alarm),
      ),
    ];

    List<Widget> list7 = [
      GradientButton(
        onTap: onPressed,
        child: const Icon(Icons.ad_units),
      ),
      GradientButton(
        onTap: onPressed,
        child: randomTextWidget(),
      ),
      GradientButton(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(45),
        child: randomTextWidget(),
      ),
      GradientButton(
        onTap: null,
        borderRadius: BorderRadius.circular(45),
        child: randomTextWidget(),
      ),
      ElevatedGradientButton(
        onPressed: onPressed,
        child: const Icon(Icons.ad_units),
      ),
      ElevatedGradientButton(
        onPressed: onPressed,
        child: randomTextWidget(),
      ),
      ElevatedGradientButton(
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(45),
        child: randomTextWidget(),
      ),
      ElevatedGradientButton(
        onPressed: null,
        borderRadius: BorderRadius.circular(45),
        child: randomTextWidget(),
      ),
    ];

    List<Widget> list8 = [
      CupertinoButton(
        onPressed: onPressed,
        child: randomTextWidget(length: 3),
      ),
      CupertinoButton.filled(
        onPressed: onPressed,
        child: randomTextWidget(length: 5),
      ),
    ];

    List<Widget> list9 = [
      "ink".text().paddingAll(kX).ink(onPressed),
      "ink(splash-blue)"
          .text()
          .paddingAll(kX)
          .ink(onPressed, splashColor: Colors.blue),
      "ink(highlight-blue)"
          .text()
          .paddingAll(kX)
          .ink(onPressed, highlightColor: Colors.blue),
      "ink(splash-highlight)".text().paddingAll(kX).ink(onPressed,
          highlightColor: Colors.blue, splashColor: Colors.redAccent),
      "inkWell".text().paddingAll(kX).inkWell(onPressed),
      "inkWellCircle".text().paddingAll(kX).inkWellCircle(onPressed),
      "ink(container)"
          .text()
          .paddingAll(kX)
          .ink(onPressed, highlightColor: Colors.blue)
          .container(
            color: Colors.redAccent,
            /*padding: const EdgeInsets.all(kX),*/
          ),
      "ink(container)"
          .text()
          .paddingAll(kX)
          .ink(onPressed, backgroundColor: Colors.blue, radius: 45)
    ];

    const textLength = 5;
    return [
      const Text(
        "ElevatedButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        children: [
          ...list1,
        ],
      ),
      const Text(
        "FilledButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        children: [
          ...list2,
        ],
      ),
      const Text(
        "OutlinedButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        children: [
          ...list3,
        ],
      ),
      const Text(
        "TextButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        children: [
          ...list4,
        ],
      ),
      const Text(
        "FloatingActionButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        children: [
          ...list5,
        ],
      ),
      const Text(
        "IconButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        children: [
          ...list6,
        ],
      ),
      const Text(
        "GradientButton↓",
        textAlign: TextAlign.center,
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...list7,
        ],
      ),
      const Text(
        "CupertinoButton↓",
        textAlign: TextAlign.center,
      ),
      list8.wrap()!,
      const Text(
        "ink↓",
        textAlign: TextAlign.center,
      ),
      list9.wrap()!,
      const Text(
        "check↓",
        textAlign: TextAlign.center,
      ),
      [
        CheckButton(
          text: randomText(textLength),
          isChecked: false,
        ),
        CheckButton(
          text: randomText(textLength),
          isChecked: true,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
      ].wrap()!,
      const Text(
        "radio↓",
        textAlign: TextAlign.center,
      ),
      [
        Radio<String>(
          value: '1',
          groupValue: null,
          onChanged: (value) {},
        ),
        Radio<String>(
          value: '1',
          toggleable: true,
          groupValue: null,
          onChanged: (value) {},
        ),
        Radio<String>(
          value: '1',
          groupValue: '1',
          onChanged: (value) {},
        ),
        Radio<String>(
          value: '1',
          groupValue: '1',
          toggleable: true,
          onChanged: (value) {},
        ),
        RadioButton(
          isChecked: isChecked1,
          text: randomText(textLength),
          onChanged: (value) {
            isChecked1 = value == true;
            updateState();
          },
        ),
        RadioButton(
          isChecked: isChecked2,
          text: randomText(textLength),
          activeColor: Colors.redAccent,
          fillColor: Colors.blue,
          crossAxisAlignment: CrossAxisAlignment.center,
          onChanged: (value) {
            isChecked2 = value == true;
            updateState();
          },
        )
      ].wrap()!,
      [
        GradientButton(
          onTap: () {
            l.d('抖动1...');
          }.debounce(1000),
          child: "抖动1".text(),
        ),
        GradientButton(
          onTap: () {
            debounce(() {
              l.d('抖动2...');
            }, millisecond: 1000);
          },
          child: "抖动2".text(),
        ),
        GradientButton(
          onTap: () {
            l.d('限流1...');
          }.throttle(1000),
          child: "限流1".text(),
        ),
        GradientButton(
          onTap: () {
            throttle(() {
              l.d('限流2...');
            }, millisecond: 1000);
          }.throttle(1000),
          child: "限流2".text(),
        ),
      ].flowLayout(
        padding: const EdgeInsets.all(kH),
        childGap: kH,
      )!,
    ];
  }
}
