//
//  ShadowSettingsView.swift
//  InnerShadowSpike
//
//  Created by Jason Cheladyn on 2022/06/24.
//

import SwiftUI

struct ShadowSettingsView: View {
    
    @Binding var shadowRadius: Double
    @Binding var xOffset: Double
    @Binding var yOffset: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .colorSliderFrame()
                .foregroundColor(Color.white.opacity(0.5))
            
            VStack(alignment: .center, spacing: 5) {
                // MARK: - SLIDER ONE
                VStack {
                    HStack {
                        Text("Radius: \(shadowRadius.formatted())")
                            .font(.footnote)
                        Spacer()
                    }
                    Slider(value: $shadowRadius, in: 0...100, step: 1)
                        .accentColor(.black)
                }
                .padding()
                
                // MARK: - SLIDER TWO
                VStack {
                    HStack {
                        Text("X: \(xOffset.formatted())")
                            .font(.footnote)
                        Spacer()
                    }
                    Slider(value: $xOffset, in: -100...100, step: 1)
                        .accentColor(.black)
                }
                .padding()
                
                // MARK: - SLIDER THREE
                VStack {
                    HStack {
                        Text("Y: \(yOffset.formatted())")
                            .font(.footnote)
                        Spacer()
                    }
                    Slider(value: $yOffset, in: -100...100, step: 1)
                        .font(.footnote)
                        .accentColor(.black)
                }
                .padding()
            }
            
        } // ZStack
        .colorSliderFrame()
    }
}

struct ShadowSettingsView_Previews: PreviewProvider {
    @State static var setting = 0.0
    static var previews: some View {
        ShadowSettingsView(shadowRadius: $setting, xOffset: $setting, yOffset: $setting)
    }
}
