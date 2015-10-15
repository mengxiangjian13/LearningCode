//
//  ViewController.m
//  UIStackViewDemo
//
//  Created by Xiangjian Meng on 15/10/15.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *peopleStackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)changeStackViewAlignment:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            self.peopleStackView.alignment = UIStackViewAlignmentFill;
        }
            break;
        case 1:
        {
            self.peopleStackView.alignment = UIStackViewAlignmentTop;
        }
            break;
        case 2:
        {
            self.peopleStackView.alignment = UIStackViewAlignmentCenter;
        }
            break;
        case 3:
        {
            self.peopleStackView.alignment = UIStackViewAlignmentBottom;
        }
            break;
            
        default:
            break;
    }
    
}
- (IBAction)changeStackViewDistribution:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            self.peopleStackView.distribution = UIStackViewDistributionFill;
        }
            break;
        case 1:
        {
            self.peopleStackView.distribution = UIStackViewDistributionFillEqually;
        }
            break;
        case 2:
        {
            self.peopleStackView.distribution = UIStackViewDistributionFillProportionally;
        }
            break;
        case 3:
        {
            self.peopleStackView.distribution = UIStackViewDistributionEqualSpacing;
        }
            break;
        case 4:
        {
            self.peopleStackView.distribution = UIStackViewDistributionEqualCentering;
        }
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
