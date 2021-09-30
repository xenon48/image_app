import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';
import 'package:provider/provider.dart';

class FullSizeImageAssetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryListViewModel>(
      builder: (context, galleryListViewModel, _) {
        return galleryListViewModel.currentIndex != null
            ? FutureBuilder<File>(
                future: galleryListViewModel.getCurrentFile(),
                builder: (_, snapshot) {
                  final file = snapshot.data;
                  if (file == null)
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  return Image.file(file, fit: BoxFit.scaleDown);
                },
              )
            : Container();
      },
    );
  }
}
