part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/03/28
///
class MenuAbc extends StatefulWidget {
  const MenuAbc({super.key});

  @override
  State<MenuAbc> createState() => _MenuAbcState();
}

class _MenuAbcState extends State<MenuAbc> with BaseAbcStateMixin {
  String? initialValue = "1";

  MenuController menuController = MenuController();

  @override
  List<Widget> buildBodyList(BuildContext context) {
    return [
      "MenuAnchor↓".text(textAlign: TextAlign.center),
      MenuAnchor(
        controller: menuController,
        menuChildren: buildMenuWidget(),
        style: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
        ),
        onOpen: () {
          l.d('open');
        },
        onClose: () {
          l.d('close');
        },
        child: IconTextTile(
          text: 'MenuAnchor',
          onTap: () {
            //menuController.open(/*position: Offset(10, 10)*/);
            if (menuController.isOpen) {
              menuController.close();
            } else {
              // close to open
              menuController.open();
            }
          },
        ),
      ),
      "MenuBar↓".text(textAlign: TextAlign.center),
      MenuBar(
        children: [
          SubmenuButton(
              menuChildren: buildMenuWidget(), child: "Submenu1".text()),
          SubmenuButton(
              menuChildren: buildMenuWidget(), child: "Submenu2".text()),
          SubmenuButton(
              menuChildren: buildMenuWidget(), child: "Submenu3".text()),
          MenuItemButton(child: "Menu1".text()),
          MenuItemButton(
            child: "Menu2".text(),
            onPressed: () {},
          ),
          MenuItemButton(child: "Menu3".text()),
        ],
      ),
      "SubmenuButton↓".text(textAlign: TextAlign.center),
      SubmenuButton(
          menuChildren: buildMenuWidget(), child: "SubmenuButton".text()),
      "MenuItemButton↓".text(textAlign: TextAlign.center),
      MenuItemButton(child: "Menu1".text()),
      "DropdownMenu↓".text(textAlign: TextAlign.center),
      DropdownMenu(dropdownMenuEntries: buildDropdownMenuEntries()),
      DropdownMenu(
        dropdownMenuEntries: buildDropdownMenuEntries(),
        initialSelection: "2",
        helperText: "请选择",
      ).fittedBox().wh(50, 40),
      DropdownMenuTheme(
        data: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            filled: true,
            fillColor: Colors.black12,
            constraints: BoxConstraints(maxHeight: 50),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        child: DropdownMenu(
          dropdownMenuEntries: buildDropdownMenuEntries(),
          initialSelection: "2",
          helperText: "请选择",
        ),
      ),
      DropdownMenu(
        dropdownMenuEntries: buildDropdownMenuEntries(),
        label: "DropdownMenu".text(),
        hintText: "请选择",
        /*initialSelection: "2",*/
        expandedInsets: const EdgeInsets.all(8),
        enabled: true,
        enableFilter: true,
        enableSearch: true,
        selectedTrailingIcon: const Icon(Icons.ac_unit),
        menuStyle: const MenuStyle(
          visualDensity: VisualDensity
              .compact, /*maximumSize: MaterialStatePropertyAll(Size(300, 300))*/
        ),
        //弹出来的菜单的大小
        /*width: 300,*/
        searchCallback:
            (List<DropdownMenuEntry<String>> entries, String query) {
          if (query.isEmpty) {
            return null;
          }
          final int index = entries.indexWhere(
              (DropdownMenuEntry<String> entry) => entry.label == query);
          return index != -1 ? index : null;
        },
        /*menuHeight: 100,*/ //弹出来的菜单的高度
      ).size(height: 48),
      "DropdownButton↓".text(textAlign: TextAlign.center),
      DropdownButton(
        items: buildDropdownMenuItems(),
        value: initialValue,
        /*icon: nil,*/
        iconSize: 0,
        onChanged: (value) {
          initialValue = value;
          updateState();
        },
      ),
      DropdownButton(
        items: buildDropdownMenuItems(),
        value: initialValue,
        underline: nil,
        icon: const Icon(Icons.add_a_photo_outlined),
        /*isDense: true,*/
        itemHeight: kMinInteractiveDimension,
        //高度必须≥kMinInteractiveDimension
        onChanged: (value) {
          initialValue = value;
          updateState();
        },
      ),
      "DropdownButtonFormField↓".text(textAlign: TextAlign.center),
      //内部就是用[DropdownButton]实现的
      DropdownButtonFormField(
        items: buildDropdownMenuItems(),
        value: initialValue,
        onChanged: (value) {
          initialValue = value;
          updateState();
        },
      ),
      DropdownButtonFormField(
        items: buildDropdownMenuItems(),
        value: initialValue,
        iconSize: 0,
        onChanged: (value) {
          initialValue = value;
          updateState();
        },
      ),
      DropdownMenuItem(child: 'text'.text()),
      "showMenu↓".text(textAlign: TextAlign.center),
      [
        GradientButton.normal(() {}, onContextTap: (ctx) {
          ctx
              .showMenus(null, items: buildPopupMenu(ctx))
              .get((value, error) {
            l.d("value:$value,error:$error");
          });
        }, child: "showMenu-items".text()),
        GradientButton.normal(() {}, onContextTap: (ctx) {
          ctx
              .showMenus(null, items: buildPopupMenu2(ctx))
              .get((value, error) {
            l.d("value:$value,error:$error");
          });
        }, child: "showMenu2-items".text()),
        GradientButton.normal(() {}, onContextTap: (ctx) {
          ctx.showMenus(buildMenuWidget());
        }, child: "showMenu-widget".text()),
      ].flowLayout(padding: kXInsets, childGap: kX)!,
      "...↑".text(textAlign: TextAlign.center),
    ];
  }

  List<PopupMenuEntry<String>> buildPopupMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem(
        value: randomText(),
        child: randomTextWidget(length: 5),
      ),
      PopupMenuItem(
        value: randomText(),
        child: randomTextWidget(length: 5),
      ),
      PopupMenuItem(
        value: randomText(),
        child: randomTextWidget(length: 5),
      ),
    ];
  }

  List<PopupMenuEntry<String>> buildPopupMenu2(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem(
        value: "1",
        child: randomTextWidget(length: 5).click(() {
          toastInfo("1");
          context.popMenu();
        }),
      ),
      PopupMenuItem(
        value: "2",
        child: randomTextWidget(length: 5).click(() {
          toastInfo("2");
          buildContext?.popMenu("pop 2");
        }),
      ),
      PopupMenuItem(
        value: "3",
        child: randomTextWidget(length: 5).click(() {
          toastInfo("3");
          buildContext?.popMenu("pop 3");
        }),
      ),
    ];
  }

  List<Widget> buildMenuWidget() {
    return [
      IconTextTile(
        text: 'Item 1',
        onTap: () => menuController.close(),
      ),
      IconTextTile(
        text: 'Item 2',
        onTap: () => menuController.close(),
      ),
      IconTextTile(
        text: 'Item 3',
        onTap: () => menuController.close(),
      ),
    ];
  }

  List<DropdownMenuEntry<String>> buildDropdownMenuEntries() {
    return [
      DropdownMenuEntry(
        value: "1",
        label: "label 1",
        labelWidget: "Item 1".text(),
      ),
      DropdownMenuEntry(
        value: "2",
        label: "label 2",
        labelWidget: "Item 2".text(),
        leadingIcon: const Icon(Icons.keyboard_arrow_left),
        trailingIcon: const Icon(Icons.ac_unit),
      ),
      DropdownMenuEntry(
        value: "3",
        label: "label 3",
        labelWidget: "Item 3".text(),
      ),
    ];
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems() {
    return [
      DropdownMenuItem(
        value: "1",
        child: "Item 1".text(),
      ),
      DropdownMenuItem(
        value: "2",
        child: "Item 2".text(),
      ),
      DropdownMenuItem(
        value: "3",
        child: "Item 3".text(),
      ),
    ];
  }
}
