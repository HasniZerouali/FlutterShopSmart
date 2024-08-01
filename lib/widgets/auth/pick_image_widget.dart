import 'dart:io';
import 'dart:developer';
import 'dart:ffi';

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
                    File(
                      pickedImage!.path,
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
                : Color.fromARGB(255, 190, 59, 213),
            child: InkWell(
              splashColor: const Color.fromARGB(255, 244, 54, 171),
              borderRadius: BorderRadius.circular(16.0),
              onTap: () {
                function();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_shopping_cart_rounded,
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
