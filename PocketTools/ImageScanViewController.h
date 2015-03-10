//
//  ImageScanViewController.h
//  xyhui
//
//  Created by 颜超 on 13-9-29.
//
//


@interface ImageScanViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *url;
@end
