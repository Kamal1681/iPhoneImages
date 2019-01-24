//
//  ViewController.m
//  iPhone Images W3D5
//
//  Created by Kamal Maged on 2019-01-24.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;

@property (nonatomic) int photoIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadImage];

}

- (void) loadImage {
    NSArray <NSURL *> * photoArray = @[[NSURL URLWithString:@"https://i.imgur.com/zdwdenZ.png"],
                                       [NSURL URLWithString:@"https://i.imgur.com/bktnImE.png"],
                                       [NSURL URLWithString:@"https://i.imgur.com/CoQ8aNl.png"],
                                       [NSURL URLWithString:@"https://i.imgur.com/2vQtZBb.png"],
                                       [NSURL URLWithString:@"https://i.imgur.com/y9MIaCS.png"]];
    
    NSURL *url = photoArray[self.photoIndex];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
        
    }];
    [downloadTask resume];

}
- (IBAction)randomNumber:(id)sender {
   self.photoIndex = arc4random_uniform(4);
    [self loadImage];
}

@end
