//
//  ContentView.swift
//  ripples
//
//  Created by Anagha K J on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var innerRipple = Ripple(diameter: 0, color: Color.init(red: 87/255, green: 75/255, blue:144/255), number: 5)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
            RippleView(ripple: innerRipple)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                innerRipple.diameter = 300
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Ripple {
    var diameter: CGFloat
    var color: Color
    var number: Int
}

struct RippleView: View {
    let ripple: Ripple

    var body: some View {
        ForEach(1...ripple.number, id: \.self) { i in
            Circle()
                .stroke(ripple.color.opacity(Double(ripple.number - i)/10.0), lineWidth: CGFloat(i*30))
                .fill(ripple.color.opacity(Double(i)/10.0))
                .frame(width: ripple.diameter, height: ripple.diameter)
                
        }
    }
}

#Preview {
    ContentView()
}
