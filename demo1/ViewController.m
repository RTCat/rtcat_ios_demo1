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

@interface ViewController (){
    RTCatLocalStream *_stream;
}
@property (weak, nonatomic) IBOutlet UIView *VideoContainer;


@end

@implementation ViewController

- (IBAction)onSwitchClick:(UIButton *)sender {
    [_stream switchCamera];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect rLocal = _VideoContainer.bounds;
    RTCatVideoPlayer *_localPlayer = [[RTCatVideoPlayer alloc] initWithFrame:rLocal];
    [_VideoContainer addSubview:_localPlayer.view];

    RTCat *_cat = [RTCat shareInstance];
    _stream = [_cat createStreamWithVideo:YES audio:YES facing:RTCAT_CAMERA_FRONT fps:15 height:rLocal.size.height width:rLocal.size.width];
    [_stream playWithPlayer:_localPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
