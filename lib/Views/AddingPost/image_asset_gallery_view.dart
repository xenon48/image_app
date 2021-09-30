import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';
import 'package:provider/provider.dart';

import 'image_asset _thumbnail_view.dart';

class ImageAssetGalleryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageAssetGalleryView();
  }
}

class _ImageAssetGalleryView extends State<ImageAssetGalleryView> {
  GalleryListViewModel galleryListViewModel;

  @override
  Widget build(BuildContext context) {
    this.galleryListViewModel =
          Provider.of<GalleryListViewModel>(context, listen: false);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.landscape ? 8 : 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1, //(1 / 1),
      ),
      itemCount: this.galleryListViewModel.imageAssets.length,
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            if (this.galleryListViewModel.imageAssets[index].type == AssetType.image) {
              this.galleryListViewModel.currentIndex = index;
              //print(this.assetListViewModel.assets.toString());
            }
          },
          child:
              ImageAssetThumbnailView(imageAsset: this.galleryListViewModel.imageAssets[index], itemNumber: index+5,),
        );
      },
    );
  }
}
