//
//  ViewController.m
//  JWImagePickerPlusSample
//
//  Created by Jonah Wallerstein on 2/19/13.
//  Copyright (c) 2013 Whale Food Games. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController (){
    NSArray *imageChoices;
}

@property (nonatomic, retain) JWImagePickerControllerPlus *imagePicker;
@property (nonatomic, retain) UIActionSheet *imageSourceOptions;
@end

@implementation SampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //some random images
    imageChoices = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",
                     @"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",
                     @"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",
                     @"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",
                     @"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",
                     @"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
    
    //set up image picker
    self.imagePicker = [[JWImagePickerControllerPlus alloc] init];
    self.imagePicker.galleryDataSource = self;
    self.imagePicker.delegate =self;
    self.imagePicker.galleryTitle = @"Pick an Image";
    
    //set up action sheet
    self.imageSourceOptions = [[UIActionSheet alloc]
                               initWithTitle:nil
                               delegate:self
                               cancelButtonTitle:nil destructiveButtonTitle:nil
                               otherButtonTitles:@"Take Photo",@"Choose Photo", @"Program Gallery", @"Cancel", nil];
    [self.imageSourceOptions setDestructiveButtonIndex:3];
}


-(IBAction)ChooseImage:(id)sender
{
    [self.imageSourceOptions showInView:self.view];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [[[UIAlertView alloc] initWithTitle:nil message:@"No camera on device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                return;
            }
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            self.imagePicker.sourceType = JWSimpleImagePickerControllerSourceTypeGallery;
            break;
        default:
            break;
    }
    
    [self presentViewController:self.imagePicker animated:true completion:nil];
}

#pragma mark -
#pragma mark JWImagePickerControllerPlusDelegate implementation

-(void)imagePickerController:(JWImagePickerControllerPlus *)picker didFinishPickingImage: (UIImage *)image
{
    self.imageView.image = image;
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerControllerDidCancel:(JWImagePickerControllerPlus *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark -
#pragma mark JWImagePickerControllerGalleryDataSource implementation


-(UIImage *)imagePickerController: (JWImagePickerControllerPlus *)picker galleryImageAtIndex:(NSUInteger) index
{
    return [UIImage imageNamed:[imageChoices objectAtIndex:index]];
}

-(int)numberOfImagesInGalleryForImagePicker: (JWImagePickerControllerPlus *)picker
{
   return [imageChoices count];
}

@end
