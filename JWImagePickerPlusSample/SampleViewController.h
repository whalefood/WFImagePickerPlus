//
//  ViewController.h
//  JWImagePickerPlusSample
//
//  Created by Jonah Wallerstein on 2/19/13.
//  Copyright (c) 2013 Whale Food Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWImagePickerControllerPlus.h"

@interface SampleViewController : UIViewController<JWImagePickerControllerGalleryDataSource, JWImagePickerControllerPlusDelegate, UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

-(IBAction)ChooseImage:(id)sender;

@end
