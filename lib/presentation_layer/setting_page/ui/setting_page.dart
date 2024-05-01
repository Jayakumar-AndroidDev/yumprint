import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:yumprint/data_layer/db/sqlite_db.dart';
import 'package:yumprint/data_layer/model/user_profile_model.dart';
import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/bloc/image_picker_bloc.dart';
import 'package:yumprint/presentation_layer/setting_page/bloc/sqlite_bloc.dart';
import 'package:yumprint/presentation_layer/setting_page/event/sqlite_event.dart';
import 'package:yumprint/presentation_layer/setting_page/state/sqlite_state_update.dart';
import 'package:yumprint/presentation_layer/setting_page/widget/switch_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userName = Repository().getUserName();
    return BlocProvider(
      create: (context) => SqliteBloc()..add(SqliteUpdateEvent()),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
              'image/setting_bg.png',
            ),
            SizedBox(
              width: size.width,
              height: size.height,
            ).asGlass(
              blurX: 5,
              blurY: 5,
            ),
            Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SafeArea(
                          child: TextComponent(
                            text: 'Setting',
                            textSize: 30,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            textAlign: Alignment.centerLeft,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: ClipOval(
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 209, 208, 208),
                              radius: 50,
                              child: BlocBuilder<SqliteBloc, SqliteStateUpdate>(
                                builder: (context, state) {
                                  if (state is OnSqliteUpdated) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: Image.memory(
                                            state.path,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return const Text('something went wrong.');
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<SqliteBloc, SqliteStateUpdate>(
                          builder: (context, state) {

                            if (state is OnSqliteUpdated) {
                                return TextComponent(
                                  text: state.userName,
                                  textSize: 20,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  textAlign: Alignment.center,
                                );
                            }

                            return const TextComponent(
                                  text: 'Hi, ?',
                                  textSize: 20,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  textAlign: Alignment.center,
                                );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                surfaceTintColor:
                                    Theme.of(context).colorScheme.background,
                                color: Theme.of(context).colorScheme.background,
                                elevation: 7,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextComponent(
                                            text: 'Dark Theme',
                                            textSize: 20,
                                            textColor: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          SwitchWidget()
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    BlocBuilder<SqliteBloc, SqliteStateUpdate>(
                                      builder: (blocContext, state) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('edit_profile')
                                                .then((value) {
                                              BlocProvider.of<SqliteBloc>(
                                                      blocContext)
                                                  .add(SqliteUpdateEvent());
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextComponent(
                                                  text: 'Edit Profile',
                                                  textSize: 20,
                                                  textColor: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                                Visibility(
                                                  maintainSize: true,
                                                  visible: false,
                                                  maintainAnimation: true,
                                                  maintainState: true,
                                                  child: Switch(
                                                    value: false,
                                                    onChanged: (value) {},
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
