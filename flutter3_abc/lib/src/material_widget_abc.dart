part of '../flutter3_abc.dart';

///
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/11/05
///

class MaterialWidgetAbc extends StatefulWidget {
  const MaterialWidgetAbc({super.key});

  @override
  State<MaterialWidgetAbc> createState() => _MaterialWidgetAbcState();
}

class _MaterialWidgetAbcState extends State<MaterialWidgetAbc>
    with BaseAbcStateMixin {
  var sliderValue = 0.5;

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      const Text(
        "LinearProgressIndicator 进度条↓",
        textAlign: TextAlign.center,
      ),
      const LinearProgressIndicator(),
      const Text(
        "CircularProgressIndicator 进度条↓",
        textAlign: TextAlign.center,
      ),
      const CircularProgressIndicator(),
      const Text(
        "LinearProgressIndicator Value 进度条↓",
        textAlign: TextAlign.center,
      ),
      const LinearProgressIndicator(
        value: 0.33,
      ),
      const Text(
        "CircularProgressIndicator Value 进度条↓",
        textAlign: TextAlign.center,
      ),
      const CircularProgressIndicator(
        value: 0.60,
      ),
      //--
      const Text(
        "Slider 离散↓",
        textAlign: TextAlign.center,
      ),
      Slider(
        value: sliderValue,
        min: 0,
        max: 1.0,
        divisions: 10,
        label: '!!!$sliderValue!!!',
        onChanged: (newValue) {
          setState(() {
            sliderValue = newValue;
          });
        },
        onChangeStart: (startValue) {
          l.d("Started change on:$startValue");
        },
        onChangeEnd: (newValue) {
          l.d("Ended change on:$newValue");
        },
      ),
      const Text(
        "Slider 离散2↓",
        textAlign: TextAlign.center,
      ),
      Slider(
        value: sliderValue,
        min: 0,
        max: 1.0,
        divisions: 100,
        label: '$sliderValue',
        onChanged: (newValue) {
          setState(() {
            sliderValue = newValue;
          });
        },
        onChangeStart: (startValue) {
          l.d("Started change on:$startValue");
        },
        onChangeEnd: (newValue) {
          l.d("Ended change on:$newValue");
        },
      ),
      const Text(
        "Slider 连续↓",
        textAlign: TextAlign.center,
      ),
      Slider(
        value: sliderValue,
        min: 0,
        max: 1,
        divisions: null,
        label: '$sliderValue',
        onChanged: (newValue) {
          setState(() {
            sliderValue = newValue;
          });
        },
        onChangeStart: (startValue) {
          l.d("Started change on:$startValue");
        },
        onChangeEnd: (newValue) {
          l.d("Ended change on:$newValue");
        },
      ),
      const Text(
        "Slider secondaryTrackValue 连续↓",
        textAlign: TextAlign.center,
      ),
      Slider(
        value: sliderValue,
        secondaryTrackValue: 0.8,
        min: 0,
        max: 1,
        divisions: null,
        label: '$sliderValue',
        onChanged: (newValue) {
          setState(() {
            sliderValue = newValue;
          });
        },
        onChangeStart: (startValue) {
          l.d("Started change on:$startValue");
        },
        onChangeEnd: (newValue) {
          l.d("Ended change on:$newValue");
        },
      ),
      const Text(
        "CupertinoSlider↓",
        textAlign: TextAlign.center,
      ),
      CupertinoSlider(
        value: sliderValue,
        onChanged: (newValue) {
          setState(() {
            sliderValue = newValue;
          });
        },
      ),
      const Text(
        "Chip↓",
        textAlign: TextAlign.center,
      ),
      <Widget>[
        const Text("Chip→"),
        Chip(
          avatar: randomTextWidget(),
          label: randomTextWidget(),
        ),
        Chip(
          avatar: randomTextWidget(),
          label: randomTextWidget(),
          onDeleted: () {},
        ),
        const Text("InputChip→"),
        InputChip(
          label: randomTextWidget(),
        ),
        InputChip(
          label: randomTextWidget(),
          onDeleted: () {},
        ),
        const Text("ChoiceChip→"),
        ChoiceChip(
          label: randomTextWidget(),
          selected: true,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: randomTextWidget(),
          selected: false,
          onSelected: (value) {},
        ),
        const Text("FilterChip→"),
        FilterChip(
          label: randomTextWidget(),
          selected: true,
          onSelected: (value) {},
        ),
        FilterChip(
          label: randomTextWidget(),
          selected: false,
          onSelected: (value) {},
        ),
        const Text("ActionChip→"),
        ActionChip(
          label: randomTextWidget(),
          onPressed: () {},
        ),
        ActionChip(
          label: randomTextWidget(),
          onPressed: () {},
        ),
      ].wrap(crossAxisAlignment: WrapCrossAlignment.center)!,
      const Text(
        "Other→",
        textAlign: TextAlign.center,
      ),
      pageContent(),
    ];
  }

  Widget pageContent() => <Widget>[
        GradientButton(
          onTap: () {
            context.pushWidget(pageContent());
          },
          child: const Text('MaterialPageRoute'),
        ),
        GradientButton(
          onTap: () {
            context.pushWidget(pageContent(), type: TranslationType.fade);
          },
          child: const Text('FadePageRoute'),
        ),
        GradientButton(
          onTap: () {
            context.pushWidget(pageContent(),
                type: TranslationType.translation);
          },
          child: const Text('TranslationPageRoute'),
        ),
        GradientButton(
          onTap: () {
            context.pushWidget(pageContent(),
                type: TranslationType.translationFade);
          },
          child: const Text('TranslationFadePageRoute'),
        ),
        GradientButton(
          onTap: () {
            context.pushWidget(pageContent(), type: TranslationType.slide);
          },
          child: const Text('SlidePageRoute'),
        ),
      ].wrap()!.container(
            alignment: Alignment.center,
            color: randomColor(),
          );
}
