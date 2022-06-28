//
//  MainViewModel.swift
//  InnerShadowSpike
//
//  Created by Jason Cheladyn on 2022/06/25.
//

import SwiftUI

struct RGBValue{
    var red: Double
    var green: Double
    var blue: Double
}

struct MainViewModel {
    
    var background: RGBValue = .init(red: 255, green: 255, blue: 255)
    var shadow: RGBValue = .init(red: 0, green: 0, blue: 0)
    var font: RGBValue = .init(red: 0, green: 0, blue: 0)
    var shadowRadius: Double = 4.0
    var xOffset: Double = 0.0
    var yOffset: Double = 5.0
    
}

extension Color {
    static func RGB(_ value: RGBValue) -> Color {
        Color(
            red: value.red.rgbPercentage,
            green: value.green.rgbPercentage,
            blue: value.blue.rgbPercentage
        )
    }
}

extension Double {
    var rgbPercentage: Double {
        self / 255
    }
}
