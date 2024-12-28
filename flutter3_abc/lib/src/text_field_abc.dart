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
    ];
  }
}
