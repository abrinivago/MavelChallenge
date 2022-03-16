//
//  ColorExtension.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 12/03/2022.
//

import UIKit

public extension UIColor {
    convenience init?(hexConvert: String) {
        var chars = Array(hexConvert.hasPrefix("#") ? hexConvert.dropFirst() : hexConvert[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F", "F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0 ... 1]), nil, 16)) / 255
            red = CGFloat(strtoul(String(chars[2 ... 3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4 ... 5]), nil, 16)) / 255
            blue = CGFloat(strtoul(String(chars[6 ... 7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
