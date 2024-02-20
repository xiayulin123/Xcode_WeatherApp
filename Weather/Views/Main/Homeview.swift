//
//  Homeview.swift
//  Weather
//
//  Created by Yulin Xia on 2024-02-17.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable{
    case top = 0.83
    case middle = 0.385
}


struct Homeview: View {
//    @State var bottomSheetPosition: BottomSheetPosition = .middle
    
    @State var isPresented = true
    @State var selectedDetent: BottomSheet.PresentationDetent = .medium
    
    var body: some View {
        
        NavigationView {
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
                
                // MARK: Bottom Sheet
                .sheetPlus(
                    isPresented: $isPresented,
                    background: (
                        RoundedRectangle(cornerRadius: 44)
                            .fill(Color.background.opacity(0.44))
                    ),
                    header: {
                        EmptyView()                    },
                    main: {
                        ForecastView()
                            .presentationDetentsPlus(
                                [.height(244), .fraction(0.4), .medium, .large],
                                selection: $selectedDetent
                            )
//                            .presentationDragIndicatorPlus(.visible)
                    }
                )
                
                // MARK: tab bar
                
                TabBar(action: {
                    isPresented.toggle()
                })
            }
            .navigationBarHidden(true)
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
