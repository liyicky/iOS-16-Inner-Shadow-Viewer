//
//  ColorSliderView.swift
//  InnerShadowSpike
//
//  Created by Jason Cheladyn on 2022/06/24.
//

import SwiftUI

struct ColorSliderView: View {
    
    @Binding var rValue: Double
    @Binding var gValue: Double
    @Binding var bValue: Double
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .colorSliderFrame()
                .foregroundColor(Color.white.opacity(0.5))
            
            VStack(alignment: .center, spacing: 0) {
                // MARK: - SLIDER ONE
                VStack {
                    HStack {
                        Text("R: \(rValue.formatted())")
                            .font(.footnote)
                        Spacer()
                    }
                    Slider(value: $rValue, in: 0...255, step: 1)
                        .accentColor(.red)
                }
                .padding(1)
                
                // MARK: - SLIDER TWO
                VStack {
                    HStack {
                        Text("G: \(gValue.formatted())")
                            .font(.footnote)
                        Spacer()
                    }
                    Slider(value: $gValue, in: 0...255, step: 1)
                        .accentColor(.green)
                }
                .padding(1)
                
                // MARK: - SLIDER THREE
                VStack {
                    HStack {
                        Text("B: \(bValue.formatted())")
                            .font(.footnote)
                        Spacer()
                    }
                    Slider(value: $bValue, in: 0...255, step: 1)
                        .accentColor(.blue)
                }
                .padding(1)
                
            }
            
            
        } // ZStack
        .colorSliderFrame()
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    @State static var rgbValue = 0.0
    static var previews: some View {
        ColorSliderView(rValue: $rgbValue, gValue: $rgbValue, bValue: $rgbValue)
    }
}

struct ColorSliderSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth*0.29, height: screenHeight*0.2)
    }
}

extension View {
    func colorSliderFrame() -> some View {
        modifier(ColorSliderSizeModifier())
    }
}
