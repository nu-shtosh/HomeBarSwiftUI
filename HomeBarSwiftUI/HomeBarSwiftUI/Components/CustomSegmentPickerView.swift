//
//  CustomSegmentPickerView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 12.03.2023.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    @State private var selection = 0
    @Binding var isGender: Bool
    let titles: [String]
    let colors : [Color]
    let font: Font
    @State private var frames = Array<CGRect>(repeating: .zero, count: 4)
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    ForEach(titles.indices, id: \.self) { index in
                        Button(action: {
                            selection = index
                            isGender.toggle()
                            print(isGender)
                        }) {
                           
                            Text(titles[index])
                                .foregroundColor(selection == 0 ? Color("neonOrange") : Color("neonBlue"))
                                .font(font)
                        }
                        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                        .background(GeometryReader { geo in
                            Color.clear.onAppear {
                                setFrame(index: index, frame: geo.frame(in: .global))
                            }
                        })
                    }
                }
                .background(Capsule()
                    .fill(colors[selection].opacity(0.7))
                    .frame(width: frames[selection].width, height: frames[selection].height, alignment: .topLeading)
                    .offset(x: frames[selection].minX - frames[0].minX), alignment: .leading
                )
            }
            .animation(.default, value: selection)
            .background(Capsule().stroke(LinearGradient(
                colors: [Color("neonBlue"), Color("neonOrange")],
                startPoint: .leading,
                endPoint: .trailing
            ), lineWidth: 3))
        }
        
    }
    
   private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}
