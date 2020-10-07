//
//  ViewController.m
//  SampleAppObjC
//
//  Created by Cesar Vargas on 07.10.20.
//  Copyright © 2020 Cesar Vargas. All rights reserved.
//

#import "ViewController.h"
#import <Wyler/Wyler-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  ScreenRecorder *screenRecorder = [ScreenRecorder init];
  [screenRecorder startRecordingTo:[NSURL init] size:CGSizeMake(0, 0) saveToCameraRoll:true errorHandler:^(NSError* error){
  }];
  [screenRecorder stoprecordingWithErrorHandler:^(NSError* error){
  }];
}


@end
