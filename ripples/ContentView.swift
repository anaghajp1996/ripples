//
//  ContentView.swift
//  ripples
//
//  Created by Anagha K J on 21/11/23.
//

import SwiftUI

let colors: [Color] = [
    Color.init(red: 87/255, green: 75/255, blue: 144/255),
    Color.init(red: 119/255, green: 139/255, blue: 235/255),
    Color.init(red: 247/255, green: 215/255, blue: 148/255),
    Color.init(red: 207/255, green: 106/255, blue: 135/255),
    Color.init(red: 231/255, green: 127/255, blue: 103/255),
    Color.init(red: 243/255, green: 166/255, blue: 131/255),
    Color.init(red: 234/255, green: 134/255, blue: 133/255),
]

extension CGPoint : Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

struct ContentView: View {
    @State var ripple = Ripple(diameter: 0, color: colors.randomElement()!, lineWidth: 10)
    @State var positions: [CGPoint] = []
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .contentShape(Rectangle())
                .onTapGesture(coordinateSpace: .global) { location in
                    ripple.color = colors.randomElement()!
                    positions.append(location)
                }
            ForEach(positions, id: \.self) { position in
                RippleView(ripple: ripple).position(position)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Ripple {
    var diameter: CGFloat
    var color: Color
    var lineWidth: CGFloat
}

struct RippleView: View {
    @State var ripple: Ripple
    let number = 5
    var body: some View {
        ForEach(1...number, id: \.self) { i in
            Circle()
                .stroke(ripple.color.opacity(Double(number - i)/10.0), lineWidth: ripple.lineWidth * Double(i))
                .frame(width: ripple.diameter, height: ripple.diameter)
                .onAppear {
                    withAnimation(.linear(duration: 1.5)) {
                        ripple.diameter = 150
                        ripple.lineWidth = 0
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
