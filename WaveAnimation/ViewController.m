//
//  ViewController.m
//  WaveAnimation
//
//  Created by qiusenwei on 2017/1/2.
//  Copyright © 2017年 qiusen. All rights reserved.
//

#import "ViewController.h"
#import "KTWaveView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet KTWaveView *waveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_waveView startWaveAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
