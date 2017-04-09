//
//  ViewController.m
//  ZCJGifInIntroDemo
//
//  Created by ZCJ on 2017/4/9.
//  Copyright © 2017年 ZCJ. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage.h"
#import "EAIntroView.h"

@interface ViewController ()<EAIntroDelegate>
@property (nonatomic, strong) NSMutableArray *gifArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.gifArr = [NSMutableArray new];
    
}

- (IBAction)addIntroViewAction:(id)sender {
    
    self.gifArr = [NSMutableArray new];
    NSMutableArray *views = [NSMutableArray new];
    for (int i=0; i<4; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"guideImage_%d", i + 1];
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"gif"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data1];
        
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:self.view.bounds];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.animatedImage = image;
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        [bgView addSubview:imageView];
        [views addObject:bgView];
        [self.gifArr addObject:imageView];
        
    }
    
    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:views[0]];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:views[1]];
    EAIntroPage *page3 = [EAIntroPage pageWithCustomView:views[2]];
    EAIntroPage *page4 = [EAIntroPage pageWithCustomView:views[3]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [intro setDelegate:self];
    intro.tapToNext = YES;
    
    [intro showInView:self.view animateDuration:0.3];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EAIntroView delegate

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        NSLog(@"Intro skipped");
    } else {
        NSLog(@"Intro finished");
    }
}

- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex {
    NSLog(@"Current page index = %lu", (unsigned long)pageIndex);
    
    for (FLAnimatedImageView *iv in self.gifArr) {
        [iv stopAnimating];
    }
    FLAnimatedImageView *imageView = self.gifArr[pageIndex];
    [imageView startAnimating];
    
}

@end
