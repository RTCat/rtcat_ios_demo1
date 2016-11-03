//
//  ViewController.m
//  demo1
//
//  Created by spacetime on 10/24/16.
//  Copyright © 2016 spacetime. All rights reserved.
//

#import "ViewController.h"
#import <RTCatSDK/RTCatLocalStream.h>
#import <RTCatSDK/RTCatVideoPlayer.h>
#import <RTCatSDK/RTCat.h>


@interface ViewController(PlayerDelegate)<RTCatVideoPlayerDelegate>

@end

@interface ViewController (){
    RTCatLocalStream *_stream;
    RTCatVideoPlayer *_localPlayer;
}
@property (weak, nonatomic) IBOutlet UIView *videoContainer;

@end

@implementation ViewController

- (IBAction)onSwitchClick:(UIButton *)sender {
    [_stream switchCamera];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rLocal = _videoContainer.bounds;
    
    _localPlayer = [[RTCatVideoPlayer alloc] initWithFrame:rLocal];
    _localPlayer.delegate = self;
    [_videoContainer addSubview:_localPlayer.view];
    
    RTCat *_cat = [RTCat shareInstance];
    
    _stream = [_cat createStreamWithVideo:YES audio:YES facing:RTCAT_CAMERA_FRONT fps:15 height:rLocal.size.height width:rLocal.size.width];
    [_stream playWithPlayer:_localPlayer];
}
@end


@implementation  ViewController(PlayerDelegate)

-(void)didChangeVideoSize:(RTCatVideoPlayer *)videoPlayer Size:(CGSize)size{
    CGRect bounds = _videoContainer.bounds;
    
    
    float A_W = bounds.size.width;
    float A_H = bounds.size.height;
    
    float B_W = size.width;
    float B_H = size.height;
    
    float W,H;
    
    if(A_W/A_H < B_W/B_H){ //定宽
        W = A_W;
        H = W * B_H/B_W;
    }else{ //定高
        H = A_H;
        W = H * B_W/B_H;
    }
    
    bounds.size.width = W;
    bounds.size.height = H;
    
    _localPlayer.view.frame = bounds;
    _localPlayer.view.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));

    [self.view setNeedsLayout];
}

@end
