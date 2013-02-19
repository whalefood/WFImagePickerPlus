//
//  JWImagePickerController.m
//  Kidstar
//
//  Created by Jonah Wallerstein on 2/14/13.
//
//

#import "JWImagePickerControllerPlus.h"


@interface JWImagePickerControllerPlus ()

@property (nonatomic, retain) UIImagePickerController* uiImagePicker;
@property (nonatomic, retain) UIView *galleryView;
@property bool galleryViewIsCurrent;

@end

@implementation JWImagePickerControllerPlus

float PADDING_TOP = 44;
float PADDING = 4;
int COLS = 4;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.uiImagePicker = [[UIImagePickerController alloc] init];
        self.uiImagePicker.delegate = self;
        [self addChildViewController:self.uiImagePicker];
    }
    return self;
}

-(void)setGalleryDataSource:(id<JWImagePickerControllerGalleryDataSource>)dataSource
{
    _galleryDataSource = dataSource;
    self.galleryViewIsCurrent = false;
}

-(void)setSourceType: (JWSimpleImagePickerControllerSourceType) type
{
    _sourceType = type;
    if(type != JWSimpleImagePickerControllerSourceTypeGallery)
    {
        self.uiImagePicker.sourceType = type;
    }
}

-(void)setGalleryTitle:(NSString *)galleryTitle
{
    _galleryTitle =galleryTitle;
    self.galleryViewIsCurrent = false;
}

-(void)loadView
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    self.view = [[UIView alloc] initWithFrame:applicationFrame];
    
    self.galleryView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.galleryView.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    if(self.sourceType == JWSimpleImagePickerControllerSourceTypeGallery)
    {
        [self createGalleryView];
    }
}

-(void)createGalleryView
{
    //add image container scroll view
    UIScrollView * imageContainer = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	imageContainer.clipsToBounds = true;
    
    [self.galleryView addSubview:imageContainer];
    
    //create top bar
    UINavigationBar* topBar = [[UINavigationBar alloc]
                               initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, 44)];
    
    topBar.barStyle = UIBarStyleBlackTranslucent;
    
    //create container for cancel button and title
    UINavigationItem * itemContainer = [[UINavigationItem alloc] initWithTitle:self.galleryTitle];
    
    UIBarButtonItem *cancelButton =  [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(imagePickerControllerDidCancel:)];
    
    //put it all together
    [itemContainer setRightBarButtonItem:cancelButton];
                               topBar.items = @[itemContainer];
    [self.galleryView addSubview:topBar];
    
    float imgSize = (self.view.frame.size.width - PADDING) / COLS - PADDING;
    
    if(self.galleryDataSource)
    {
        int numImages = [self.galleryDataSource numberOfImagesInGalleryForImagePicker:self];
        int contentHeight = PADDING_TOP + ceil(numImages/COLS)*(imgSize + PADDING) + PADDING;
        if(contentHeight < self.view.frame.size.height)
            contentHeight = self.view.frame.size.height;
        imageContainer.contentSize = CGSizeMake(self.view.frame.size.width,contentHeight);
        
        for(int cntr=0; cntr<numImages; cntr++)
        {
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[self.galleryDataSource
                              imagePickerController:self
                              galleryImageAtIndex:cntr]
                    forState:UIControlStateNormal];
            
            button.imageView.contentMode =UIViewContentModeScaleAspectFill;
            button.showsTouchWhenHighlighted = YES;
            button.userInteractionEnabled = YES;
            [button addTarget:self action:@selector(galleryImageSelectedFromButton:) forControlEvents:UIControlEventTouchUpInside];
            
            
            float frameY = PADDING_TOP + PADDING + floor(cntr / COLS) * (imgSize + PADDING);
            float frameX = PADDING + (cntr % COLS) * (imgSize + PADDING);
            
            button.frame = CGRectMake(frameX, frameY, imgSize, imgSize);
            
            [imageContainer addSubview:button];
        }
    }
    
    self.galleryViewIsCurrent = true;
}

-(void)galleryImageSelectedFromButton:(UIButton *)sender
{
    [self.delegate imagePickerController:self didFinishPickingImage:sender.imageView.image];
}

-(void)viewWillAppear:(BOOL)animated
{
    if(self.sourceType == JWSimpleImagePickerControllerSourceTypeGallery)
    {
        [self.uiImagePicker.view removeFromSuperview];
        if(!self.galleryViewIsCurrent)
            [self createGalleryView];
        [self.view addSubview:self.galleryView];
    }
    else
    {
        [self.galleryView removeFromSuperview];
        [self.view addSubview:self.uiImagePicker.view];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.delegate imagePickerControllerDidCancel:self];
    
    id sharedApp = [UIApplication sharedApplication];
    [sharedApp setStatusBarHidden:false animated:true];
    [sharedApp setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.delegate imagePickerController:self didFinishPickingImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    id sharedApp = [UIApplication sharedApplication];
    [sharedApp setStatusBarHidden:false animated:true];
    [sharedApp setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
}

@end
