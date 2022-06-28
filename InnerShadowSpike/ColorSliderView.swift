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
        .colorSliderFrame()
        .padding()
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 8, style: .continuous)
        )
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    @State static var rgbValue = 0.0
    static var previews: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            ColorSliderView(rValue: $rgbValue, gValue: $rgbValue, bValue: $rgbValue)
        }
    }
}

struct ColorSliderSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth*0.22, height: screenHeight*0.2)
    }
}

extension View {
    func colorSliderFrame() -> some View {
        modifier(ColorSliderSizeModifier())
    }
}
