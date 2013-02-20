//
//  ViewController.h
//  JWImagePickerPlusSample
//
//  Created by Jonah Wallerstein on 2/19/13.
//  Copyright (c) 2013 Whale Food Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFImagePickerControllerPlus.h"

@interface SampleViewController : UIViewController<WFImagePickerControllerGalleryDataSource, WFImagePickerControllerPlusDelegate, UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

-(IBAction)ChooseImage:(id)sender;

@end
