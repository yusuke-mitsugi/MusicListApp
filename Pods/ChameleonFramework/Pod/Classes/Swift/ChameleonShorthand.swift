
//  ChameleonShorthand.swift

/*
 
 The MIT License (MIT)
 
 Copyright (c) 2014-2015 Vicc Alexander.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import UIKit

// MARK: - UIColor Methods Shorthand

/**
Creates and returns a complementary flat color object 180 degrees away in the HSB colorspace from the specified color.

- parameter color: The color whose complementary color is being requested.

- returs: A flat UIColor object in the HSB colorspace.
*/
public func ComplementaryFlatColorOf(color: UIColor) -> UIColor {
    return UIColor(complementaryFlatColorOf: color)
}

/**
 Returns a randomly generated flat color object with an alpha value of 1.0 in either a light or dark shade.
 
 - parameter shade: Specifies whether the randomly generated flat color should be a light or dark shade.
 
 - returns: A flat UIColor object in the HSB colorspace.
 */


public func FlatRed() -> UIColor {
    return UIColor.flatRed()
}

// MARK: - Chameleon - Dark Shades Shorthand

public func FlatBlackDark() -> UIColor {
	return UIColor.flatBlackColorDark() 
}

public func FlatBlueDark() -> UIColor {
	return UIColor.flatBlueColorDark() 
}

public func FlatBrownDark() -> UIColor {
	return UIColor.flatBrownColorDark() 
}

public func FlatCoffeeDark() -> UIColor {
	return UIColor.flatCoffeeColorDark() 
}

public func FlatForestGreenDark() -> UIColor {
	return UIColor.flatForestGreenColorDark() 
}

public func FlatGrayDark() -> UIColor {
	return UIColor.flatGrayColorDark() 
}

public func FlatGreenDark() -> UIColor {
	return UIColor.flatGreenColorDark() 
}

public func FlatLimeDark() -> UIColor {
	return UIColor.flatLimeColorDark() 
}

public func FlatMagentaDark() -> UIColor {
	return UIColor.flatMagentaColorDark() 
}

public func FlatMaroonDark() -> UIColor {
	return UIColor.flatMaroonColorDark() 
}

public func FlatMintDark() -> UIColor {
	return UIColor.flatMintColorDark() 
}

public func FlatNavyBlueDark() -> UIColor {
	return UIColor.flatNavyBlueColorDark() 
}

public func FlatOrangeDark() -> UIColor {
	return UIColor.flatOrangeColorDark() 
}

public func FlatPinkDark() -> UIColor {
	return UIColor.flatPinkColorDark() 
}

public func FlatPlumDark() -> UIColor {
	return UIColor.flatPlumColorDark() 
}

public func FlatPowderBlueDark() -> UIColor {
	return UIColor.flatPowderBlueColorDark() 
}

public func FlatPurpleDark() -> UIColor {
	return UIColor.flatPurpleColorDark() 
}

public func FlatRedDark() -> UIColor {
	return UIColor.flatRedColorDark() 
}

public func FlatSandDark() -> UIColor {
	return UIColor.flatSandColorDark() 
}

public func FlatSkyBlueDark() -> UIColor {
	return UIColor.flatSkyBlueColorDark() 
}

public func FlatTealDark() -> UIColor {
	return UIColor.flatTealColorDark() 
}

public func FlatWatermelonDark() -> UIColor {
	return UIColor.flatWatermelonColorDark() 
}

public func FlatWhiteDark() -> UIColor {
	return UIColor.flatWhiteColorDark() 
}

public func FlatYellowDark() -> UIColor {
	return UIColor.flatYellowColorDark() 
}
