//
//  JWImagePickerController.h
//  Kidstar
//
//  Created by Jonah Wallerstein on 2/14/13.
//
//

#import <UIKit/UIKit.h>

@class JWImagePickerControllerPlus;
@protocol JWImagePickerControllerGalleryDataSource <NSObject>

-(UIImage *)imagePickerController: (JWImagePickerControllerPlus *)picker galleryImageAtIndex:(NSUInteger) index;
-(int)numberOfImagesInGalleryForImagePicker: (JWImagePickerControllerPlus *)picker;

@end

@protocol JWImagePickerControllerPlusDelegate <NSObject>

-(void)imagePickerController:(JWImagePickerControllerPlus *)picker didFinishPickingImage: (UIImage *)image;
- (void)imagePickerControllerDidCancel:(JWImagePickerControllerPlus *)picker;

@end

//custom enum so can have extra source type
typedef enum
{
    JWSimpleImagePickerControllerSourceTypePhotoLibrary=UIImagePickerControllerSourceTypePhotoLibrary,
    JWSimpleImagePickerControllerSourceTypeCamera = UIImagePickerControllerSourceTypeCamera,
    JWSimpleImagePickerControllerSourceTypeSavedPhotosAlbum=UIImagePickerControllerSourceTypeSavedPhotosAlbum,
    JWSimpleImagePickerControllerSourceTypeGallery
    
} JWSimpleImagePickerControllerSourceType;

@interface JWImagePickerControllerPlus : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) JWSimpleImagePickerControllerSourceType sourceType;
@property (nonatomic, retain) id<JWImagePickerControllerGalleryDataSource> galleryDataSource;
@property (nonatomic, retain) id<JWImagePickerControllerPlusDelegate> delegate;
@property (nonatomic, retain) NSString * galleryTitle;

@end
