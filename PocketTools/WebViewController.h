//
//  WebViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/22.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@end
