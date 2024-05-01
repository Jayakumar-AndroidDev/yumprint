import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumprint/data_layer/db/sqlite_db.dart';
import 'package:yumprint/data_layer/model/user_profile_model.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/bloc/image_picker_bloc.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/event/image_picker_event.dart';
import 'package:sizer/sizer.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/state/image_picker_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.refreshData});
  final Function() refreshData;
  @override
  Widget build(BuildContext context) {
    final userName = TextEditingController();
    File? bath;
    return BlocProvider<ImagePickerBloc>(
      create: (context) => ImagePickerBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile Edit',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Sizer(
          builder: (sizeContext, orientation, deviceType) {
            return SizedBox(
              width: 100.w,
              height: 100.h,
              child: Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 20.h,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            width: 35.w,
                            height: 35.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child:
                                BlocBuilder<ImagePickerBloc, ImagePickerState>(
                              builder: (context, state) {
                                if (state is ImagePickerPathState) {
                                  bath = state.path;
                                  return GestureDetector(
                                    onTap: () {
                                      _showImagePickerDialog(context);
                                    },
                                    child: Image.file(
                                      state.path,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    _showImagePickerDialog(context);
                                  },
                                  child: Image.asset(
                                    'image/image_place_holder.png',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: userName,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              label: const Text('Enter user name'),
                            ),
                          ),
                        ),
                        BlocBuilder<ImagePickerBloc, ImagePickerState>(
                          builder: (context, state) {
                            File? file;

                            if (state is ImagePickerPathState) {
                              file = state.path;
                            }

                            List<int> imageByte = file != null
                                ? file.readAsBytesSync()
                                : [0, 3, 4, 5];
                            String base64 = base64Encode(imageByte);

                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orange),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange),
                                      onPressed: () {
                                        if (userName.text == '' ||
                                            base64 == '' ||
                                            bath == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 90, 37, 34))),
                                              content: Text(
                                                'Please select all value',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        SqliteDb.sqliteDb.deleteDb();
                                        SqliteDb.sqliteDb.insertUserItem(
                                          UserProfileModel(
                                            userImage: base64,
                                            userName: userName.text,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showImagePickerDialog(BuildContext buildContext) async {
    return await showDialog(
      context: buildContext,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick Image From'),
          backgroundColor: Colors.white,
          content: const Text('Do you want image pick from ?'),
          actions: [
            TextButton(
                onPressed: () {
                  final picker = ImagePicker();
                  picker.pickImage(source: ImageSource.camera,imageQuality: 25).then((value) {
                    if (value != null) {
                      final pathOfImage = File(value.path);
                      BlocProvider.of<ImagePickerBloc>(buildContext).add(
                          OnImagePickerClickedEvent(
                              pickedImagePath: pathOfImage));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No Image Picked...')));
                    }

                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Camera',
                    style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: () {
                  final picker = ImagePicker();
                  picker.pickImage(source: ImageSource.gallery,imageQuality: 25).then((value) {
                    if (value != null) {
                      final pathOfImage = File(value.path);
                      BlocProvider.of<ImagePickerBloc>(buildContext).add(
                          OnImagePickerClickedEvent(
                              pickedImagePath: pathOfImage));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No Image Picked...')));
                    }

                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Gallery',
                    style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.black)))
          ],
        );
      },
    );
  }
}
