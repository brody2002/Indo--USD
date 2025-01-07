//
//  ContentView.swift
//  IndoCashConverter
//
//  Created by Brody on 1/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputAmerican: String = ""
    @State private var inputIndo: String = ""
    @State private var outputAmerican: String = ""
    @State private var outputIndo: String = ""
    
    @FocusState private var focus: focusInput?
    
    enum focusInput {
        case currencyInput
    }
    
    @State private var americanToIndoMode: Bool = true
    
    // USD -> Indo
    func americanToIndo(_ inputAmerican: String) -> Double {
        let americanValue: Double = Double(inputAmerican) ?? 0.0
        let indoValue: Double = americanValue * 16143.01
        return indoValue
    }
    
    func indoToAmerican(_ inputIndo: String) -> Double {
        let indoValue: Double = Double(inputIndo) ?? 0.0
        let americanValue: Double = indoValue / 16143.01
        return americanValue
    }
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: value)) ?? "0.00"
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            americanToIndoMode ? Color.blue.ignoresSafeArea() : Color.red.ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 100)
                Text(americanToIndoMode ? "USD -> INDO" : "INDO -> USD")
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .font(.system(size: 48))
                ZStack{
                
                    TextField(americanToIndoMode ? "Enter USD" : "Enter INDO", text: americanToIndoMode ? $inputAmerican : $inputIndo)
                        .foregroundStyle(.black).fontDesign(.rounded).fontWeight(.bold)

                        .multilineTextAlignment(.center)
                        .font(.system(size: 30))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: inputAmerican) { _, newValue in
                            let output = americanToIndo(newValue)
                            outputIndo = "Rp " + formatCurrency(value: output)
                        }
                        .onChange(of: inputIndo) { _, newValue in
                            let output = indoToAmerican(newValue)
                            outputAmerican = "$" + formatCurrency(value: output)
                        }
                        .focused($focus, equals: .currencyInput)
                   
                }
                Spacer().frame(height: 100)
                if americanToIndoMode {
                    Text(outputIndo.isEmpty ? "Rp 0.00" : outputIndo)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .font(.system(size: 34))
                } else {
                    Text(outputAmerican.isEmpty ? "$0.00" : outputAmerican)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .font(.system(size: 34))
                }
                Spacer().frame(height: 100)
                Button(action: {
                    withAnimation(.spring(response: 0.3)) { americanToIndoMode.toggle() }
                }, label: {
                    Image(systemName: "arrow.up.circle")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(americanToIndoMode ? 0 : 180))
                })
            }
            .padding(.horizontal)
        }.onTapGesture {focus = nil}
        
    }
}

#Preview {
    ContentView()
}

