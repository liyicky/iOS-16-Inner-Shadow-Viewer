//
//  ContentView.swift
//  InnerShadowSpike
//
//  Created by Jason Cheladyn on 2022/06/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var viewModel: MainViewModel = MainViewModel()
    
    @State var textToDisplay = TextToDisplayOption.Custom
    @State var customTextToDisplay = "Liyicky was here"
    @State var fontSize = 275.0
    
    var fontColor: Color {
        return Color.RGB(viewModel.background)
    }
    
    var shadowdColor: Color {
        return Color.RGB(viewModel.shadow)
    }
    
    var screenIsDark: Bool {
        return viewModel.background.red + viewModel.background.green + viewModel.background.blue < (255 * 3) / 2
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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.4), Color.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                HStack() {
                    Text("Inner Shadow")
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
                                        fontColor.gradient.shadow(
                                            .inner(color: shadowdColor, radius: viewModel.shadowRadius, x: viewModel.xOffset, y: viewModel.yOffset)
                                        )
                                    )
                                    .font(.system(size: fontSize))
                                    .animation(.easeIn, value: fontSize)
                                
                            } else {
                                ForEach(textToDisplay == .Kanji ? ContentView.KanjiArray : ContentView.Alphabet, id: \.self) { text in
                                    Text(text)
                                        .shadow(color: .black, radius: 1)
                                        .foregroundStyle(
                                            fontColor.gradient.shadow(
                                                .inner(color: shadowdColor, radius: viewModel.shadowRadius, x: viewModel.xOffset, y: viewModel.yOffset)
                                            )
                                        )
                                        .font(.system(size: fontSize))
                                        .animation(.easeIn, value: fontSize)
                                    
                                }
                            }
                        } // HStack
                    } // Scroll View
                    .frame(width: screenWidth*0.9, height: screenHeight*0.3)
                } // Content VStack
                
                // MARK: - SECOND LABEL

                HStack(spacing: 50) {
                    Text("Background").font(.footnote).padding(.leading, screenWidth*0.02).foregroundColor(screenIsDark ? .white : .black)
                    Text("Shadow").font(.footnote).padding(.leading, screenWidth*0.01).foregroundColor(screenIsDark ? .white : .black)
                    Text("Position").font(.footnote).padding(.leading, screenWidth*0.07).foregroundColor(screenIsDark ? .white : .black)
                    Spacer()
                }.padding(.top, 1)
                // MARK: - OPTIONS
                HStack {
                    ColorSliderView(rValue: $viewModel.background.red, gValue: $viewModel.background.green, bValue: $viewModel.background.blue)
                    ColorSliderView(rValue: $viewModel.shadow.red, gValue: $viewModel.shadow.green, bValue: $viewModel.shadow.blue)
                    ShadowSettingsView(shadowRadius: $viewModel.shadowRadius, xOffset: $viewModel.xOffset, yOffset: $viewModel.yOffset)
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
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: UIScreen.main.bounds.width*0.9, height:UIScreen.main.bounds.height * 0.05)
                            .foregroundColor(Color.white.opacity(0.5))
                        HStack(alignment: .center, spacing: 5) {
                            Text("Font Size: \(fontSize.formatted())")
                                .font(.footnote)
                                .padding()
                            Slider(value: $fontSize, in: 0...500, step: 1)
                                .accentColor(.black)
                                .padding()
                        }
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
            .ignoresSafeArea()
        }
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
    }
}
