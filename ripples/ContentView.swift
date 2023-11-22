//
//  ContentView.swift
//  ripples
//
//  Created by Anagha K J on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var innerRipple = Ripple(diameter: 0, color: Color.init(red: 87/255, green: 75/255, blue:144/255))

    var body: some View {
        ZStack {
            RippleView(ripple: innerRipple)
            Rectangle()
                .fill(.clear)
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
}

struct RippleView: View {
    let ripple: Ripple

    var body: some View {
        Circle()
            .fill(ripple.color)
            .frame(width: ripple.diameter, height: ripple.diameter)
    }
}

#Preview {
    ContentView()
}
