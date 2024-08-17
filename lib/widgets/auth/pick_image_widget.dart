import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, this.pickedImage, required this.function});
  final XFile? pickedImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    // nasta3mil l provider
    // (context, listen: true) listen min dereh true ywali provider yatsama3
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                  )
                : Image.file(
                    //tadi 9ima type File lihada nhawlo pickedImage la type File khtrch howa XFile
                    File(
                      pickedImage!.path, //tadi path ta3 file
                    ),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(16.0),
            // color: const Color(0xFF9c27b0),
            color: themeProvider.getIsDarkTheme
                ? const Color(0xFF9c27b0)
                : const Color.fromARGB(255, 188, 147, 232),
            child: InkWell(
              splashColor: Color.fromARGB(255, 244, 59, 232),
              borderRadius: BorderRadius.circular(16.0),
              onTap: () {
                function();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 20,
                  // color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
