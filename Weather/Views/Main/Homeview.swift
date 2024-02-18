//
//  Homeview.swift
//  Weather
//
//  Created by Yulin Xia on 2024-02-17.
//

import SwiftUI

struct Homeview: View {
    var body: some View {
        ZStack{
            // MARK: Main Background Color
            Color.background
                .ignoresSafeArea()
            
            // MARK: Main Background Image
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            // MARK: House Image
            Image("House")
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 257)
            
            VStack(spacing: -10){
                Text("Waterloo")
                    .font(.largeTitle)
                
                VStack{
                    
                    
                    Text(attributedString)
                    
                    Text("H:24°   L:18°").font(.title3.weight(.semibold))
                }
                
                Spacer()
            }
            .padding(.top, 51)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n" + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let space = string.range(of: " | ") {
            string[space].font = .title3.weight(.semibold)
            string[space].foregroundColor = .secondary
        }
        if let situation = string.range(of: "Mostly Clear") {
            string[situation].font = .title3.weight(.semibold)
            string[situation].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    Homeview()
        .preferredColorScheme(.dark)
}