# WFImagePickerPlus

A simple extention to the UIImagePickerController to allow an extra "gallery" source type.
The gallery is made to look similar to Apple's interface for picking a photo from your library, but allows the program to specify the image options.

There's no lazy loading implimented with the gallery, so having a huge number of images may hurt performance.
For a higher perfance grid control, I'd recommend looking at https://github.com/AlanQuatermain/AQGridView/

Licence: MIT-Licence

## Usage

The sample project should be mostly self explanitory.

There are two protocols involved: `WFImagePickerControllerGalleryDataSource` and `WFImagePickerControllerPlusDelegate`.

Implementing `WFImagePickerControllerPlusDelegate` allows your class to respond to events when an image is picked or the user cancels.

Implementing `WFImagePickerControllerGalleryDataSource` allows you to specify how many and which images are shown in the gallery.

## Acknowledgements

Some pieces of code borrowed from https://github.com/jeena/JPImagePickerController