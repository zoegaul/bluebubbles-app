import 'dart:io';
import 'dart:math';

import 'package:bluebubbles/helpers/helpers.dart';
import 'package:bluebubbles/app/layouts/settings/widgets/settings_widgets.dart';
import 'package:bluebubbles/app/wrappers/theme_switcher.dart';
import 'package:bluebubbles/app/wrappers/stateful_boilerplate.dart';
import 'package:bluebubbles/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPanel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AboutPanelState();
}

class _AboutPanelState extends OptimizedState<AboutPanel> {

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
        title: "About & Links",
        initialHeader: "Links",
        iosSubtitle: iosSubtitle,
        materialSubtitle: materialSubtitle,
        tileColor: tileColor,
        headerColor: headerColor,
        bodySlivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SettingsSection(
                  backgroundColor: tileColor,
                  children: [
                    SettingsTile(
                      title: "Support Us",
                      subtitle: kIsDesktop || kIsWeb ? "Left click for PayPal / Venmo\nRight click for Github Sponsors" : "Tap for PayPal / Venmo\nTap and hold for GitHub Sponsors",
                      onTap: () async {
                        await launchUrl(Uri(scheme: "https", host: "bluebubbles.app", path: "donate"), mode: LaunchMode.externalApplication);
                      },
                      onLongPress: () async {
                        await launchUrl(Uri(scheme: "https", host: "github.com", path: "sponsors/BlueBubblesApp"), mode: LaunchMode.externalApplication);
                      },
                      leading: const SettingsLeadingIcon(
                        iosIcon: CupertinoIcons.money_dollar_circle,
                        materialIcon: Icons.attach_money,
                      ),
                      isThreeLine: true,
                    ),
                    Container(
                      color: tileColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SettingsDivider(color: context.theme.colorScheme.surfaceVariant),
                      ),
                    ),
                    SettingsTile(
                      title: "Website",
                      onTap: () async {
                        await launchUrl(Uri(scheme: "https", host: "bluebubbles.app"), mode: LaunchMode.externalApplication);
                      },
                      leading: const SettingsLeadingIcon(
                        iosIcon: CupertinoIcons.globe,
                        materialIcon: Icons.language,
                      ),
                    ),
                    Container(
                      color: tileColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SettingsDivider(color: context.theme.colorScheme.surfaceVariant),
                      ),
                    ),
                    SettingsTile(
                      title: "Source Code",
                      subtitle: kIsWeb || kIsDesktop ? "Right click to report a bug" : "Tap and hold to report a bug",
                      onTap: () async {
                        await launchUrl(Uri(scheme: "https", host: "github.com", path: "BlueBubblesApp"), mode: LaunchMode.externalApplication);
                      },
                      onLongPress: () async {
                        await launchUrl(Uri(scheme: "https", host: "github.com", path: "BlueBubblesApp/bluebubbles-app/issues"), mode: LaunchMode.externalApplication);
                      },
                      leading: const SettingsLeadingIcon(
                        iosIcon: CupertinoIcons.chevron_left_slash_chevron_right,
                        materialIcon: Icons.code,
                      ),
                    ),
                    Container(
                      color: tileColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SettingsDivider(color: context.theme.colorScheme.surfaceVariant),
                      ),
                    ),
                    SettingsTile(
                      title: "Join Our Discord",
                      onTap: () async {
                        await launchUrl(Uri(scheme: "https", host: "discord.gg", path: "hbx7EhNFjp"), mode: LaunchMode.externalApplication);
                      },
                      leading: SvgPicture.asset(
                        "assets/icon/discord.svg",
                        color: HexColor("#7289DA"),
                        alignment: Alignment.centerRight,
                        width: 32,
                      ),
                    ),
                  ],
                ),
                SettingsHeader(
                    headerColor: headerColor,
                    tileColor: tileColor,
                    iosSubtitle: iosSubtitle,
                    materialSubtitle: materialSubtitle,
                    text: "Info"),
                SettingsSection(
                  backgroundColor: tileColor,
                  children: [
                    SettingsTile(
                      title: "Changelog",
                      onTap: () async {
                        String changelog =
                            await DefaultAssetBundle.of(context).loadString('assets/changelog/changelog.md');
                        Navigator.of(context).push(
                          ThemeSwitcher.buildPageRoute(
                            builder: (context) => Scaffold(
                              body: Markdown(
                                data: changelog,
                                physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                styleSheet: MarkdownStyleSheet.fromTheme(
                                  context.theme
                                    ..textTheme.copyWith(
                                      headlineMedium: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                ).copyWith(
                                  h1: context.theme
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  h2: context.theme
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  h3: context.theme.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              backgroundColor: context.theme.colorScheme.background,
                              appBar: AppBar(
                                toolbarHeight: 50,
                                elevation: 0,
                                scrolledUnderElevation: 3,
                                surfaceTintColor: context.theme.colorScheme.primary,
                                leading: buildBackButton(context),
                                backgroundColor: headerColor,
                                iconTheme: IconThemeData(color: context.theme.colorScheme.primary),
                                centerTitle: iOS,
                                title: Padding(
                                  padding: EdgeInsets.only(top: kIsDesktop ? 20 : 0),
                                  child: Text(
                                    "Changelog",
                                    style: context.theme.textTheme.titleLarge,
                                  ),
                                ),
                                systemOverlayStyle: context.theme.colorScheme.brightness == Brightness.dark
                                    ? SystemUiOverlayStyle.light
                                    : SystemUiOverlayStyle.dark,
                              ),
                            ),
                          ),
                        );
                      },
                      leading: const SettingsLeadingIcon(
                        iosIcon: CupertinoIcons.doc_plaintext,
                        materialIcon: Icons.article,
                      ),
                    ),
                    Container(
                      color: tileColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SettingsDivider(color: context.theme.colorScheme.surfaceVariant),
                      ),
                    ),
                    SettingsTile(
                      title: "Developers",
                      onTap: () {
                        final devs = {
                          "Zach": "zlshames",
                          "Tanay": "tneotia",
                          "Joel": "jjoelj",
                        };
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Developers! Developers!",
                              style: context.theme.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: context.theme.colorScheme.properSurface,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: devs.entries.map((e) => Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child: RichText(
                                  text: TextSpan(
                                    text: e.key,
                                    style: context.theme.textTheme.bodyLarge!.copyWith(decoration: TextDecoration.underline, color: context.theme.colorScheme.primary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launchUrl(Uri(scheme: "https", host: "github.com", path: e.value), mode: LaunchMode.externalApplication);
                                      }),
                                ),
                              )).toList(),
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  "Close",
                                style: context.theme.textTheme.bodyLarge!.copyWith(color: context.theme.colorScheme.primary)),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        );
                      },
                      leading: const SettingsLeadingIcon(
                        iosIcon: CupertinoIcons.person_alt,
                        materialIcon: Icons.person,
                      ),
                    ),
                    if (kIsWeb || kIsDesktop)
                      Container(
                        color: tileColor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SettingsDivider(color: context.theme.colorScheme.surfaceVariant),
                        ),
                      ),
                    if (kIsWeb || kIsDesktop)
                      SettingsTile(
                        title: "Keyboard Shortcuts",
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Keyboard Shortcuts', style: context.theme.textTheme.titleLarge),
                                  scrollable: true,
                                  backgroundColor: context.theme.colorScheme.properSurface,
                                  content: Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    child: SingleChildScrollView(
                                      child: DataTable(
                                        columnSpacing: 5,
                                        dataRowHeight: 75,
                                        dataTextStyle: context.theme.textTheme.bodyLarge,
                                        headingTextStyle: context.theme.textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                                        columns: const <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'Key Combination',
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Action',
                                            ),
                                          ),
                                        ],
                                        rows: const <DataRow>[
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + COMMA')),
                                              DataCell(Text('Open settings')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + N')),
                                              DataCell(Text('Start new chat (Desktop only)')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('ALT + N')),
                                              DataCell(Text('Start new chat')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + F')),
                                              DataCell(Text('Open search page')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('ALT + R')),
                                              DataCell(
                                                  Text('Reply to most recent message in the currently selected chat')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + R')),
                                              DataCell(Text(
                                                  'Reply to most recent message in the currently selected chat (Desktop only)')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('ALT + G')),
                                              DataCell(Text('Sync from server')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + SHIFT + R')),
                                              DataCell(Text('Sync from server (Desktop only)')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + G')),
                                              DataCell(Text('Sync from server (Desktop only)')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + SHIFT + 1-6')),
                                              DataCell(Text(
                                                  'Apply reaction to most recent message in the currently selected chat')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + ARROW DOWN')),
                                              DataCell(Text('Switch to the chat below the currently selected one')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + TAB')),
                                              DataCell(Text(
                                                  'Switch to the chat below the currently selected one (Desktop only)')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + ARROW UP')),
                                              DataCell(Text('Switch to the chat above the currently selected one')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + SHIFT + TAB')),
                                              DataCell(Text(
                                                  'Switch to the chat above the currently selected one (Desktop only)')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('CTRL + I')),
                                              DataCell(Text('Open chat details page')),
                                            ],
                                          ),
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('ESC')),
                                              DataCell(Text('Close pages')),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    )
                                  ],
                                );
                              });
                        },
                        leading: const SettingsLeadingIcon(
                          iosIcon: CupertinoIcons.keyboard,
                          materialIcon: Icons.keyboard,
                        ),
                      ),
                    Container(
                      color: tileColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SettingsDivider(color: context.theme.colorScheme.surfaceVariant),
                      ),
                    ),
                    SettingsTile(
                      title: "About",
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder<PackageInfo>(
                                future: PackageInfo.fromPlatform(),
                                builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.only(
                                      top: 24,
                                      left: 24,
                                      right: 24,
                                    ),
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    scrollable: true,
                                    backgroundColor: context.theme.colorScheme.properSurface,
                                    content: ListBody(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            IconTheme(
                                              data: context.theme.iconTheme,
                                              child: Image.asset(
                                                "assets/icon/icon.png",
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                      "BlueBubbles",
                                                      style: context.theme.textTheme.titleLarge,
                                                    ),
                                                    if (!kIsDesktop)
                                                      Text(
                                                          "Version Number: ${snapshot.hasData ? snapshot.data!.version : "N/A"}",
                                                          style: context.theme.textTheme.bodyLarge),
                                                    if (!kIsDesktop)
                                                      Text(
                                                          "Version Code: ${snapshot.hasData
                                                                  ? snapshot.data!.buildNumber.toString().lastChars(
                                                                      min(4, snapshot.data!.buildNumber.length))
                                                                  : "N/A"}",
                                                          style: context.theme.textTheme.bodyLarge),
                                                    if (kIsDesktop)
                                                      Text(
                                                        "${fs.packageInfo.version}_${Platform.operatingSystem.capitalizeFirst!}",
                                                        style: context.theme.textTheme.bodyLarge,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("View Licenses", style: context.theme.textTheme.bodyLarge!.copyWith(color: context.theme.colorScheme.primary)),
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute<void>(
                                            builder: (BuildContext context) => Theme(
                                              data: context.theme,
                                              child: LicensePage(
                                                applicationName: "BlueBubbles",
                                                applicationVersion: snapshot.hasData ? snapshot.data!.version : "",
                                                applicationIcon: Image.asset(
                                                  "assets/icon/icon.png",
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                            ),
                                          ));
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Close", style: context.theme.textTheme.bodyLarge!.copyWith(color: context.theme.colorScheme.primary)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        );
                      },
                      leading: const SettingsLeadingIcon(
                        iosIcon: CupertinoIcons.info_circle,
                        materialIcon: Icons.info,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
  }
}
