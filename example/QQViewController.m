//
//  QQViewController.m
//  example
//
//  Created by stonedong on 14-4-22.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "QQViewController.h"
#import <QQWalletSDK/QQWalletSDK.h>
#import <QQWalletSDK/QWMessage.h>
@interface QQViewController ()

@end

@implementation QQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction) pay:(id)sender
{
    NSURL* url = [NSURL URLWithString:@"http://fun.svip.qq.com/mqqopenpay_demo.php"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        
        NSDictionary* infos = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (!error) {
            NSString* orderId = infos[@"token"];
            if (orderId) {
                NSDictionary* dic = @{kQWPayParamTokenID:orderId};
                [QQWalletSDK startPayWithServerParams:dic  completion:^(QWMessage *message, NSError *error) {
                    if (error) {
                        NSLog(@"error %@",error);
                    } else
                    {
                        NSLog(@"message infos %@", message.infos);
                    }
                }];
            } else
            {
                NSLog(@"no token id");
            }
        } else
        {
            NSLog(@"%@",error);
        }
    } else
    {
         NSLog(@"%@",error);
    }

}
@end
