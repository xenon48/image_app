import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';
import 'package:provider/provider.dart';

class ImageAssetThumbnailView extends StatelessWidget {
  final AssetEntity imageAsset;
  final int itemNumber;

  const ImageAssetThumbnailView({
    Key key,
    @required this.imageAsset,
    this.itemNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: imageAsset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return CircularProgressIndicator();
        // If there's data, display it as an image
        return Consumer<GalleryListViewModel>(
          builder: (context, AssetListViewModel, _) {
            return AssetListViewModel.currentIndex == this.itemNumber
                ? Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                    //color: Color.fromRGBO(50, 10, 75, 0.9),
                    color :Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.9),
                    colorBlendMode: BlendMode.modulate,
                  )
                : Image.memory(bytes, fit: BoxFit.cover);
          },
        );
      },
    );
  }
}
