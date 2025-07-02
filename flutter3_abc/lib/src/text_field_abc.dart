part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/15
///
class TextFieldAbc extends StatefulWidget {
  const TextFieldAbc({super.key});

  @override
  State<TextFieldAbc> createState() => _TextFieldAbcState();
}

class _TextFieldAbcState extends State<TextFieldAbc> with BaseAbcStateMixin {
  final Map<int, FocusNode> _focusNodeMap = {};

  FocusNode generateFocusNode(int index) {
    return _focusNodeMap.putIfAbsent(index, () => FocusNode());
  }

  final Map<int, ValueNotifier<bool>> _valueNotifierMap = {};

  ValueNotifier<bool> generateValueNotifier(int index) {
    return _valueNotifierMap.putIfAbsent(
        index, () => ValueNotifier<bool>(false));
  }

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        'TextField↓',
        textAlign: TextAlign.center,
      ),
      TextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
        enabled: AbcConfig.getAndIncrementClickCount() % 2 == 0,
        decoration: null,
      ),
      TextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
        enabled: AbcConfig.getAndIncrementClickCount() % 2 == 0,
        decoration: const InputDecoration(
          labelText: "default",
          prefixText: 'prefixText',
          suffixText: 'suffixText',
        ),
        controller: TextEditingController(text: '8️⃣🅱️Q了'),
      ),
      TextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
        enabled: AbcConfig.getAndIncrementClickCount() % 2 == 0,
        decoration: const InputDecoration(
          labelText: "default",
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        controller: TextEditingController(text: '8️⃣🅱️Q了'),
      ),
      const TextField(
        obscureText: true,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          labelText: "default-obscure",
          prefix: Icon(Icons.lock),
          suffix: Icon(Icons.remove_red_eye),
        ),
      ),
      const TextField(
        decoration: InputDecoration(
          labelText: "default-border",
          border: OutlineInputBorder(),
        ),
      ),
      const TextField(
        decoration: InputDecoration(
          labelText: "default-border-color",
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
      ),
      const Text(
        'TextField-lines↓',
        textAlign: TextAlign.center,
      ),
      const TextField(
        maxLength: 10,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: "hintText",
          hintMaxLines: 5,
          border: OutlineInputBorder(),
        ),
      ),
      TextField(
        maxLength: 50,
        maxLines: 2,
        decoration: InputDecoration(
          suffix: randomTextWidget(length: 5),
          labelText: "default-border-50",
          hintMaxLines: 5,
          border: const OutlineInputBorder(),
        ),
      ),
      const TextField(
        maxLength: 100,
        minLines: 3,
        maxLines: 10,
        autofillHints: [
          AutofillHints.email,
          AutofillHints.username,
          AutofillHints.url,
        ],
        decoration: InputDecoration(
          labelText: "default-border",
          hintMaxLines: 5,
          border: OutlineInputBorder(),
        ),
      ),
      const Text(
        'CupertinoTextField↓',
        textAlign: TextAlign.center,
      ),
      CupertinoTextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
        enabled: AbcConfig.getAndIncrementClickCount() % 2 == 0,
        decoration: null,
      ),
      CupertinoTextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
      ),
      CupertinoTextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
        placeholder: 'placeholder',
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: CupertinoColors.systemRed,
            ),
          ),
        ),
      ),
      const Text(
        'CupertinoSearchTextField↓',
        textAlign: TextAlign.center,
      ),
      CupertinoSearchTextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
      ),
      CupertinoSearchTextField(
        onChanged: (value) => l.v(value),
        onSubmitted: (value) => toast(Text(value)),
        placeholder: 'placeholder',
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: CupertinoColors.systemRed,
            ),
          ),
        ),
      ),
      const Text(
        'Autocomplete↓',
        textAlign: TextAlign.center,
      ),
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          l.d("optionsBuilder->$textEditingValue");
          if (isNil(textEditingValue.text)) {
            return [];
          }
          return [
            "默认样式->${textEditingValue.text}",
            textEditingValue.text,
            "->${textEditingValue.text}<-",
          ];
        },
        onSelected: (option) {
          l.d("onSelected[${option.runtimeType}]->$option");
        },
      ),
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          l.d("textEditingValue->$textEditingValue");
          if (isNil(textEditingValue.text)) {
            return [];
          }
          return [
            "->${textEditingValue.text}",
            textEditingValue.text,
            "->${textEditingValue.text}<-",
          ];
        },
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return SingleInputWidget(
            config: TextFieldConfig(
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (value) {
                onFieldSubmitted();
              },
            ),
            hintText: "SingleInputWidget",
          );
        },
      ),
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          l.d("optionsBuilder->$textEditingValue");
          if (isNil(textEditingValue.text)) {
            return [];
          }
          return [
            "重写optionsViewBuilder->${textEditingValue.text}",
            textEditingValue.text,
            "->${textEditingValue.text}<-",
          ];
        },
        onSelected: (option) {
          l.d("onSelected[${option.runtimeType}]->$option");
        },
        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options,
        ) {
          return AutocompleteOptionsWidget(
            options: options,
            onSelected: onSelected,
          );
        },
      ).size(width: 300).align(Alignment.center),
      SingleInputWidget(
        config: TextFieldConfig(
          autoOptionsBuilder: (config, textEditingValue) {
            l.d("autoOptionsBuilder[${config.hasFocus}]->$textEditingValue");
            if (isNil(textEditingValue.text)) {
              return [];
            }
            return [
              "autoOptionsBuilder->${textEditingValue.text}",
              textEditingValue.text,
              "->${textEditingValue.text}<-",
            ];
          },
        ),
        hintText: "Autocomplete-SingleInputWidget",
        borderColor: Colors.red,
        focusBorderColor: Colors.purpleAccent,
      ).size(width: 400).align(Alignment.center),
      //AutocompleteHighlightedOption(highlightIndexNotifier: highlightIndexNotifier, child: child),
      AutofillGroup(child: "AutofillGroup".text()),
      const Text(
        'AnchorOverlayLayout↓',
        textAlign: TextAlign.center,
      ),
      _buildFocusNodeAnchor(1, Alignment.topLeft, Alignment.bottomRight),
      _buildFocusNodeAnchor(2, Alignment.topCenter, Alignment.bottomCenter),
      _buildFocusNodeAnchor(3, Alignment.topRight, Alignment.bottomLeft),
      _buildFocusNodeAnchor(4, Alignment.centerRight, Alignment.centerLeft),
      _buildFocusNodeAnchor(5, Alignment.bottomRight, Alignment.topLeft),
      _buildFocusNodeAnchor(6, Alignment.bottomCenter, Alignment.topCenter),
      _buildFocusNodeAnchor(7, Alignment.bottomLeft, Alignment.topRight),
      _buildFocusNodeAnchor(8, Alignment.centerLeft, Alignment.centerRight),
      _buildValueNotifierAnchor(1, Alignment.topLeft, Alignment.bottomRight),
      _buildValueNotifierAnchor(5, Alignment.bottomRight, Alignment.topLeft),
      //AutofillClient(),
      Empty.height(500),
    ];
  }

  Widget _buildFocusNodeAnchor(
    int focusIndex,
    Alignment targetAnchor,
    Alignment followerAnchor, {
    Offset offset = Offset.zero,
  }) {
    return AnchorOverlayLayout(
      triggerFocusNode: generateFocusNode(focusIndex),
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      followerOffset: offset,
      rootOverlay: false,
      anchor: SingleInputWidget(
        config: TextFieldConfig(
          focusNode: generateFocusNode(focusIndex),
        ),
        hintText:
            "${targetAnchor.toString().substringEnd(".")}+${followerAnchor.toString().substringEnd(".")}",
      ),
      overlayWidgetBuilder: (ctx, bounds) {
        return GradientButton(
          child: "button:$bounds".text(),
          onTap: () {
            toastInfo("click:$bounds");
          },
        ).constrained(width: bounds.w);
        /*.size(width: 100, height: 50).center()*/;
      },
    ).size(width: 300).align(Alignment.center);
  }

  Widget _buildValueNotifierAnchor(
    int focusIndex,
    Alignment targetAnchor,
    Alignment followerAnchor, {
    Offset offset = Offset.zero,
  }) {
    return AnchorOverlayLayout(
      groupId: focusIndex,
      triggerValueNotifier: generateValueNotifier(focusIndex),
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      followerOffset: offset,
      rootOverlay: false,
      anchor: GradientButton(
        child:
            "${targetAnchor.toString().substringEnd(".")}+${followerAnchor.toString().substringEnd(".")}"
                .text(),
        onTap: () {
          generateValueNotifier(focusIndex).value = true;
        },
      ),
      overlayWidgetBuilder: (ctx, bounds) {
        return GradientButton(
          child: "button:$bounds".text(),
          onTap: () {
            toastInfo("click:$bounds");
          },
        ).constrained(width: bounds.w);
        /*.size(width: 100, height: 50).center()*/;
      },
    ).size(width: 300).align(Alignment.center);
  }
}
