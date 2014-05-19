//
//  QBGradientView.h
//  TopBalance Software
//
//  Created by Ruben Nieves on 10/2/10.
//  Copyright 2010 TopBalance Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GRADIENT_PERCENTAGE (3.0/4.0)
struct QBColor {
	CGFloat	red;
	CGFloat	green;
	CGFloat	blue;
	CGFloat	alpha;
};

typedef enum QBGRADIENT_ORIENTATION {
    Orientation_Vertical = 0,
	Orientation_Horizontal
} QBGradient_Orientation;

@interface QBGradientLabel : UILabel
@property (assign, nonatomic) QBGradient_Orientation gradientDirection;
@property (assign, nonatomic) CGFloat startOffset;

- (id)initWithFrame:(CGRect)frame darkColor:(UIColor *)darkColor andLightColor:(UIColor *)lightColor;
- (void)setLighterColor:(UIColor *)color;
- (void)setDarkerColor:(UIColor *)color;
@end
