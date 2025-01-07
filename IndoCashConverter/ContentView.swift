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
    
    @State private var moneyCalculator = MoneyCalculator()
    
    @FocusState private var focus: focusInput?
    
    enum focusInput {
        case currencyInput
    }
    
    @State private var americanToIndoMode: Bool = true
    
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
                    TextField(
                        americanToIndoMode ? "Enter USD" : "Enter INDO",
                        text: americanToIndoMode ? $inputAmerican : $inputIndo,
                        prompt: americanToIndoMode ?
                        Text("Enter USD")
                            .foregroundStyle(.black.opacity(0.5)) :
                            Text("Enter INDO")
                            .foregroundStyle(.black.opacity(0.5))
                    )
                    .foregroundStyle(.black).fontDesign(.rounded).fontWeight(.bold).font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: inputAmerican) { _, newValue in
                        let output = moneyCalculator.americanToIndo(newValue)
                        outputIndo = "Rp " + formatCurrency(value: output)
                    }
                    .onChange(of: inputIndo) { _, newValue in
                        let output = moneyCalculator.indoToAmerican(newValue)
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
                .buttonStyle(NoGrayOutButtonStyle())
            }
            .padding(.horizontal)
        }.onTapGesture {focus = nil}
        
    }
}

#Preview {
    ContentView()
}



struct NoGrayOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 1.0 : 1.0)
    }
}
