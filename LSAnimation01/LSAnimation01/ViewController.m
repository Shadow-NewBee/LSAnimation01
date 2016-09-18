//
//  ViewController.m
//  LSLearnAni01
//
//  Created by xiaoT on 16/4/2.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import "ViewController.h"
#import "Lai_CicleView.h"


#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, strong) Lai_CicleView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.mySlider addTarget:self action:@selector(valueDidChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.circleView = [[Lai_CicleView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 320 / 2, HEIGHT / 2 - 320 / 2, 320, 320)];
    [self.view addSubview:self.circleView];
    //    首次进入界面
    self.circleView.circleLayer.process = _mySlider.value;
}

-(void)valueDidChanged:(UISlider *)sender
{
    self.valueLabel.text = [NSString stringWithFormat:@"Current : %f",sender.value];
    
    self.circleView.circleLayer.process = sender.value;
}

@end
