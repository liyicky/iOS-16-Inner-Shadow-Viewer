//
//  ContentView.swift
//  InnerShadowSpike
//
//  Created by Jason Cheladyn on 2022/06/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State var bgR = 59.0
    @State var bgG = 105.0
    @State var bgB = 48.0
    
    @State var shadowR = 0.0
    @State var shadowG = 0.0
    @State var shadowB = 0.0
    
    @State var shadowRadius = 4.0
    @State var xOffset = 0.0
    @State var yOffset = 5.0
    
    @State var textToDisplay = TextToDisplayOption.Custom
    @State var customTextToDisplay = "Liyicky was here"
    
    var backgroundColor: Color {
        return Color(red: bgR / 255, green: bgG / 255, blue: bgB / 255)
    }
    
    var shadowdColor: Color {
        return Color(red: shadowR / 255, green: shadowG / 255, blue: shadowB / 255)
    }
    
    var screenIsDark: Bool {
        return bgR + bgG + bgB < (255 * 3) / 2
    }
    
    // MARK: = CONSTANTS
    enum TextToDisplayOption: String, CaseIterable, Identifiable {
        case ABC
        case Kanji
        case Custom
        
        var id: String { self.rawValue }
    }
    static let KanjiArray = ["頑", "張", "庭", "猫", "西", "軽", "谷", "池", "羽"]
    static let ABCArray =  ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    static let Alphabet = ABCArray + ABCArray.map { $0.capitalized}
    
    let textLimit = 25
    
    
    
    var body: some View {
        VStack {
            HStack() {
                Text("Inner Shadow Test")
                    .font(.largeTitle)
                    .foregroundColor(screenIsDark ? .white : .black)
                Spacer()
            } // Title
            
            VStack {
                // MARK: - TEXT DISPLAY
                ScrollView(.horizontal) {
                    HStack(alignment: .center) {
                        if textToDisplay == .Custom {
                            Text(customTextToDisplay)
                                .shadow(color: .black, radius: 1)
                                .foregroundStyle(
                                    .white.gradient.shadow(
                                        .inner(color: shadowdColor, radius: shadowRadius, x: xOffset, y: yOffset)
                                    )
                                )
                                .font(.system(size: 275))
                        } else {
                            ForEach(textToDisplay == .Kanji ? ContentView.KanjiArray : ContentView.Alphabet, id: \.self) { text in
                                Text(text)
                                    .shadow(color: .black, radius: 1)
                                    .foregroundStyle(
                                        .white.gradient.shadow(
                                            .inner(color: shadowdColor, radius: shadowRadius, x: xOffset, y: yOffset)
                                        )
                                    )
                                    .font(.system(size: 275))
                            }
                        }
                    } // HStack
                } // Scroll View
                .frame(width: screenWidth*0.9, height: screenHeight*0.3)
            } // Content VStack
            
            // MARK: - SECOND LABEL
            HStack {
                Text("Second Label Here")
                    .foregroundColor(screenIsDark ? .white : .black)
                Spacer()
            }
            HStack(spacing: 50) {
                Text("Background").font(.footnote).padding(.leading, screenWidth*0.02).foregroundColor(screenIsDark ? .white : .black)
                Text("Shadow").font(.footnote).padding(.leading, screenWidth*0.01).foregroundColor(screenIsDark ? .white : .black)
                Text("Position").font(.footnote).padding(.leading, screenWidth*0.07).foregroundColor(screenIsDark ? .white : .black)
                Spacer()
            }.padding(.top, 1)
            // MARK: - OPTIONS
            HStack {
                ColorSliderView(rValue: $bgR, gValue: $bgG, bValue: $bgB)
                ColorSliderView(rValue: $shadowR, gValue: $shadowG, bValue: $shadowB)
                ShadowSettingsView(shadowRadius: $shadowRadius, xOffset: $xOffset, yOffset: $yOffset)
            } // Options HStack
            
            // MARK: - OPTIONS PICKER
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: UIScreen.main.bounds.width*0.9, height:UIScreen.main.bounds.height * 0.05)
                        .foregroundColor(Color.white.opacity(0.5))
                    Picker("Sample Text", selection: $textToDisplay) {
                        ForEach(TextToDisplayOption.allCases) { option in
                            Text(option.rawValue)
                                .tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                // MARK: - CUSTOM INPUT
                if textToDisplay == .Custom {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: UIScreen.main.bounds.width*0.9, height:UIScreen.main.bounds.height * 0.05)
                            .foregroundColor(Color.white.opacity(0.5))
                        TextField("Custom Text", text: $customTextToDisplay)
                            .onReceive(Just(customTextToDisplay)) { _ in limitText() }
                            .padding()
                    }
                }
            }
            
            
            Spacer()
        } // Super VStack
        .padding()
        .padding(.top, 25)
        .frame(width: screenWidth, height: screenHeight)
        .background(backgroundColor)
        .ignoresSafeArea()
    }
    
    func limitText() {
        if customTextToDisplay.count > textLimit {
            customTextToDisplay = String(customTextToDisplay.prefix(textLimit))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
