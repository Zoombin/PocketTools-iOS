//
//  ImageScanViewController.m
//  xyhui
//
//  Created by 颜超 on 13-9-29.
//
//

#import "ImageScanViewController.h"

@interface ImageScanViewController ()

@end

@implementation ImageScanViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)saveImage {
    if (_image == nil) {
        return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_image) {
        [self showImage:_image];
    }
    if (_url) {
        [self showImageWithUrl:_url];
    }
    if (_imageName) {
        self.title = _imageName;
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
}

- (void)showImage:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [webView loadData:data
              MIMEType:@"image/png"
      textEncodingName:@"UTF-8"
               baseURL:nil];
}

- (void)showImageWithUrl:(NSString *)url
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
@end
