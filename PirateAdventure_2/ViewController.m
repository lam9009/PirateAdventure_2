//
//  ViewController.m
//  PirateAdventure_2
//
//  Created by Alfred on 11/2/15.
//  Copyright (c) 2015 Maptier. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //display factory tiles method's return value: array here
//    PAFactory *factory = [[PAFactory alloc] init];
//    NSArray *tiles = [factory tiles];
//    NSLog(@"%@", tiles);
    
    PAFactory *factory = [[PAFactory alloc] init];
    self.tiles = [factory tiles];
    
    self.currentPoint = CGPointMake(0,0);
    NSLog(@"%f %f", self.currentPoint.x, self.currentPoint.y);

    NSLog(@"%lu",(unsigned long)[self.tiles count]);
    
    //after updateing tiles method, adding images
    [self updateTile];
    [self updateButtons];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButton:(UIButton *)sender {
}

- (IBAction)northButton:(UIButton *)sender {
    //click this north button to move up along Y
    //then update buttons and tiles
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y+1);
    [self updateButtons];
    [self updateTile];
}

- (IBAction)eastButton:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x+1, self.currentPoint.y);
    [self updateButtons];
    [self updateTile];
}

- (IBAction)southButton:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y-1);
    [self updateButtons];
    [self updateTile];
}

- (IBAction)westButton:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x-1, self.currentPoint.y);
    [self updateButtons];
    [self updateTile];
}


#pragma mark - helper method

-(void)updateTile
{
    //now set a PATile object with a coordinate: x and y
    //use this PATile coordinate to update storyLabel story contents
    PATile *tileModel =[[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];
    self.storyLabel.text = tileModel.story;
    
    //add background image
    self.backgroundImageView.image = tileModel.backgroundImage;

}

//use this method to verify the button scope
- (BOOL)tileExistsAtPoint:(CGPoint)point
{
    if(point.y >= 0 && point.x >= 0 && point.x < [self.tiles count] && point.y < [[self.tiles objectAtIndex:point.x] count]){
        return NO;
    }
    else {
        return YES;
    }
}
//use this method to decide which button to hid
-(void)updateButtons
{
    self.westButton.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x - 1, self.currentPoint.y)];
    self.eastButton.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x + 1, self.currentPoint.y)];
    self.northButton.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y + 1)];
    self.southButton.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y - 1)];
}

@end
