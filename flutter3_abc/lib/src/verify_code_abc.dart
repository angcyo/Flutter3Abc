part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/12/25
///

class VerifyCodeAbc extends StatefulWidget {
  const VerifyCodeAbc({super.key});

  @override
  State<VerifyCodeAbc> createState() => _VerifyCodeAbcState();
}

class _VerifyCodeAbcState extends State<VerifyCodeAbc> with BaseAbcStateMixin {
  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      VerifyCode(
        fullBorder: true,
        itemMargin: kXh,
        onCompleted: (value) {
          FocusScope.of(context).unfocus();
        },
      ).padding(0, kL).center(),
      const VerifyCode(
        itemMargin: kH,
      ).padding(0, kL).center(),
      const VerifyCode(
        fullBorder: true,
        length: 6,
        isSecure: true,
      ).padding(0, kL).center(),
      const VerifyCode(
        length: 6,
        isSecure: true,
      ).padding(0, kL).center(),
    ];
  }
}
