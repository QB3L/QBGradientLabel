//
//  ViewController.m
//  QBGradientLabel
//
//  Created by Ruben Nieves on 5/19/14.
//  Copyright (c) 2014 TopBalance Software. All rights reserved.
//

#import "ViewController.h"
#import "QBGradientLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger labelHeights = 21;
	// Do any additional setup after loading the view, typically from a nib.
    QBGradientLabel *plainLabel = [[QBGradientLabel alloc] initWithFrame:CGRectMake(0, 40, 100, labelHeights)];
    plainLabel.textColor = [UIColor whiteColor];
    plainLabel.font = [UIFont systemFontOfSize:12];
    plainLabel.text = @"Plain";
    plainLabel.textAlignment = NSTextAlignmentCenter;
    plainLabel.center = CGPointMake(self.view.center.x, plainLabel.frame.origin.y);
    [self.view addSubview:plainLabel];
    
    //Rest of labels
    NSInteger startPoint = plainLabel.frame.origin.y;
    QBGradientLabel *initializedLabel = [[QBGradientLabel alloc] initWithFrame:CGRectMake(plainLabel.frame.origin.x, 20 + startPoint * 1 + 1, 100, labelHeights) darkColor:[UIColor redColor] andLightColor:[UIColor lightGrayColor]];
    initializedLabel.textColor = [UIColor whiteColor];
    initializedLabel.font = [UIFont systemFontOfSize:12];
    initializedLabel.text = @"initialized";
    initializedLabel.textAlignment = NSTextAlignmentCenter;
    initializedLabel.center = CGPointMake(plainLabel.center.x, plainLabel.center.y + plainLabel.frame.size.height + 2);
    [self.view addSubview:initializedLabel];
    
    
    QBGradientLabel *changedLabel = [[QBGradientLabel alloc] initWithFrame:CGRectMake(plainLabel.frame.origin.x, 20 +startPoint * 2 + 2, 100, labelHeights)];
    changedLabel.textColor = [UIColor whiteColor];
    changedLabel.font = [UIFont systemFontOfSize:12];
    changedLabel.text = @"Changed";
    changedLabel.textAlignment = NSTextAlignmentCenter;
    [changedLabel setLighterColor:[UIColor colorWithRed:97.0/255.0 green:118.0/255.0 blue:155.0/255.0 alpha:1.0]];
    [changedLabel setDarkerColor:[UIColor colorWithRed:2.0/255.0 green:31.0/255.0 blue:84.0/255.0 alpha:1.0]];
    [self.view addSubview:changedLabel];
    
    
    QBGradientLabel *horizontal = [[QBGradientLabel alloc] initWithFrame:CGRectMake(plainLabel.frame.origin.x, 20 + startPoint * 3 + 3, 100, labelHeights)];
    [horizontal setLighterColor:[UIColor whiteColor]];
    horizontal.gradientDirection = Orientation_Horizontal;
    horizontal.textColor = [UIColor whiteColor];
    horizontal.font = [UIFont systemFontOfSize:12];
    horizontal.text = @"Horizontal";
    horizontal.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
