//
//  ContentView.swift
//  ripples
//
//  Created by Anagha K J on 21/11/23.
//

import SwiftUI

extension CGPoint : Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

struct ContentView: View {
    var innerRipple = Ripple(diameter: 0, color: Color.init(red: 87/255, green: 75/255, blue:144/255), number: 5)
    @State var positions: [CGPoint] = []
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .contentShape(Rectangle())
                .onTapGesture(coordinateSpace: .global) { location in
                    positions.append(location)
                }
            ForEach(positions, id: \.self) { position in
                RippleView(ripple: innerRipple).position(position)
                    
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
    @State var ripple: Ripple

    var body: some View {
        ForEach(1...ripple.number, id: \.self) { i in
            Circle()
                .stroke(ripple.color.opacity(Double(ripple.number - i)/10.0), lineWidth: CGFloat(i*30))
                .fill(ripple.color.opacity(Double(i)/10.0))
                .frame(width: ripple.diameter, height: ripple.diameter)
                .onAppear {
                    withAnimation(.linear(duration: 3.0)) {
                        ripple.diameter = 100
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
