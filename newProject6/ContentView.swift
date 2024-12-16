//
//  ContentView.swift
//  newProject6
//
//  Created by Адам Дотмерзаев on 14.12.2024.
//
import SwiftUI

struct ContentView: View {
    @State private var trigger = false
    private let rect = 7
    private let spacing: CGFloat = 10
    private let cornerRadius: CGFloat = 10
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink]

    var body: some View {
        GeometryReader { geo in
            let size = calculateSize(for: geo.size)
            let step = calculateStep(for: geo.size, size: size)

            ZStack {
                ForEach(0 ..< rect, id: \.self) { i in
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundStyle(colors[i % colors.count])
                        .frame(width: size, height: size)
                        .position(position(for: i, size: size, step: step, geometry: geo.size))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                withAnimation(.spring) {
                    trigger.toggle()
                }
            }
        }
    }

    private func calculateSize(for geometry: CGSize) -> CGFloat {
        trigger ? geometry.height / CGFloat(rect) : (geometry.width - spacing * CGFloat(rect - 1)) / CGFloat(rect)
    }

    private func calculateStep(for geometry: CGSize, size: CGFloat) -> CGPoint {
        CGPoint(x: (geometry.width - size) / CGFloat(rect - 1),
                y: (geometry.height - size) / CGFloat(rect - 1)
        )
    }

    private func position(for index: Int, size: CGFloat, step: CGPoint, geometry: CGSize) -> CGPoint {
        CGPoint(x: trigger ? step.x * CGFloat(index) + size / 2 : (size + spacing) * CGFloat(index) + size / 2,
                y: trigger ? geometry.height - (step.y * CGFloat(index) + size / 2) : geometry.height / 2)
    }
}




#Preview {
    ContentView()
}
