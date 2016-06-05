//
//  QBGradientLabelSwift.swift
//  QBGradientLabel
//
//  Created by Ruben Nieves on 6/4/16.
//  Copyright © 2016 TopBalance Software. All rights reserved.
//

import UIKit

struct QBColor {
    var red : CGFloat
    var green : CGFloat
    var blue : CGFloat
    var alpha : CGFloat
}

enum QBGradient_Orientation : Int {
    case Orientation_Vertical = 0
    case Orientation_Horizontal
}


class QBGradientLabelSwift: UILabel {
//Defined VARS
    static let GRADIENT_PERCENTAGE : CGFloat = (3.0/4.0)
    static let QBColorBlack : QBColor = QBColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let QBColorGray : QBColor = QBColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let QBColorZero : QBColor = QBColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    
//PROPERTIES
    var gradientDirection : QBGradient_Orientation = QBGradient_Orientation.Orientation_Vertical
    var startOffset : CGFloat = GRADIENT_PERCENTAGE
    var lightColor : QBColor  = QBColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    var darkColor : QBColor  = QBColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

//Initialization
    required init(coder aDecoder: NSCoder) {
        self.gradientDirection = QBGradient_Orientation.Orientation_Vertical
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        self.gradientDirection = QBGradient_Orientation.Orientation_Vertical
        super.init(frame: frame)
    }
    
    init(frame: CGRect, darkColor:UIColor, lightColor:UIColor) {
        self.gradientDirection = QBGradient_Orientation.Orientation_Vertical
        self.lightColor = QBGradientLabelSwift.colorFromUIColor(lightColor)
        self.darkColor = QBGradientLabelSwift.colorFromUIColor(darkColor)
        super.init(frame: frame)
    }
    
//Special Methods
    func QBContextDrawVerticalGradient(c: CGContextRef, gradient:CGGradientRef, rect:CGRect, ratio:CGFloat) {
        
        let midx : CGFloat  = CGRectGetMidX(rect)
        let miny : CGFloat  = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect)
        
        // Gradient line
        let startPoint : CGPoint = CGPointMake(midx, miny)
        let endPoint : CGPoint = CGPointMake(midx, maxy * ratio)
        
//        let rgb : CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!;
        CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsAfterEndLocation)
    }
    
    func QBContextDrawHorizontalGradient(c: CGContextRef, gradient:CGGradientRef, rect:CGRect, ratio:CGFloat) {
        let minx : CGFloat = CGRectGetMinX(rect);
        let maxx : CGFloat = CGRectGetMaxX(rect);
        let midy : CGFloat = CGRectGetMidY(rect);
        
        // Gradient line
        let startPoint : CGPoint = CGPointMake(minx, midy)
        let endPoint : CGPoint = CGPointMake(maxx * ratio, midy)
        
//        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsAfterEndLocation);
        
    }
    
    
//Class Methods
    class func colorFromUIColor(theColor:UIColor) -> QBColor {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if theColor.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            return QBColor.init(red: fRed, green: fGreen, blue: fBlue, alpha: fAlpha)
        } else {
            // Could not extract RGBA so return Default
            print("Error getting color components")
            return QBColorBlack
        }
    }

//Instance Methods
    override func drawRect(rect: CGRect) {
        
        let ctx : CGContextRef = UIGraphicsGetCurrentContext()!;
        
        CGContextSaveGState(ctx);
        let componentCount : Int = 4
        //Gradient
        let gradientColors:[CGFloat] = [
            self.lightColor.red ,  self.lightColor.green, self.lightColor.blue, self.lightColor.alpha,
            self.darkColor.red ,  self.darkColor.green, self.darkColor.blue, self.darkColor.alpha
        ];
        
        let rgb : CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!;
        let gradient : CGGradientRef = CGGradientCreateWithColorComponents(rgb, gradientColors, nil, componentCount)!
        
        if self.gradientDirection == QBGradient_Orientation.Orientation_Vertical {
            self.QBContextDrawVerticalGradient(ctx, gradient: gradient, rect: rect, ratio: self.startOffset);
        } else {
            self.QBContextDrawHorizontalGradient(ctx, gradient: gradient, rect: rect, ratio: self.startOffset);
        }
        
//        CGGradientRelease(gradient);
//        CGColorSpaceRelease(rgb);
        CGContextRestoreGState(ctx);
        super.drawRect(rect);
    }
    
    
}
