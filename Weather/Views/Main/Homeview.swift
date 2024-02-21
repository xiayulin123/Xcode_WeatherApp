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
    @GestureState private var dragTranslation = CGSize.zero
    @State var isPresented = false
    @State var constant = true
    @State var selectedDetent: BottomSheet.PresentationDetent = .medium
    @State private var imagesOpacity = 1.0
    @State private var selection = 0
    
    
    
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                ZStack{
                    // MARK: Main Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Main Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .opacity(imagesOpacity)
                    
                    
                    // MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .opacity(imagesOpacity)
                    
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
                        isPresented: $constant,
                        background: (
                            
                            RoundedRectangle(cornerRadius: 44)
                                .fill(Color.background.opacity(0.44))
                            
                                .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 44))
                            //                            .overlay{
                            //                                // MARK: Botton Sheet Inner Shadow (Border)
                            //                                RoundedRectangle(cornerRadius: 44)
                            //                                    .stroke(Color.bottomSheetBorderMiddle, lineWidth: 1)
                            //                            }
                                .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1)
                            
                            
                            
                        ),
                        header: {
                            EmptyView()
                        },
                        main: {
                            
                            ForecastView(isPresented: selectedDetent != .medium)
                                .presentationDetentsPlus(
                                    [.height(UIScreen.main.bounds.height), .fraction(0.4), .medium, .large],
                                    selection: $selectedDetent
                                )
                            
                            //                            .presentationDragIndicatorPlus(.visible)
                        }
                    )
                    
                    .gesture(
                        DragGesture().onChanged { value in
                            // Adjust imagesOpacity based on drag value
                            // This is a simplified example; you'll need to map the drag translation to opacity
                            imagesOpacity = calculateOpacity(from: value.translation.height)
                            
                            if selectedDetent == .height(852.0) {
                                imagesOpacity = 0
                            }else{
                                imagesOpacity = calculateOpacity(from: value.translation.height)
                                
                            }
                        }
                            
                            .onEnded{value in
                                if selectedDetent != .medium {
                                             isPresented = true
                                         }
                                print(selectedDetent)
                                     }
                               
                            
                        )
                                            
                    

                    
                    
                    // MARK: tab bar
                    
                    TabBar(action: {
                        //                    isPresented.toggle()
                        if selectedDetent == .medium{
                            selectedDetent = .fraction(1.0)
                            imagesOpacity = 0
                            isPresented = true
                            
                        }
                        else{
                            selectedDetent = .medium
                            imagesOpacity = 1
                        }
                    })
                }
                .navigationBarHidden(true)
            }
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

func calculateOpacity(from translation: CGFloat) -> Double {
    // Implement the logic to calculate opacity based on the translation
    // For example, you might return 1.0 (fully visible) for no translation
    // and gradually decrease to 0.0 (fully transparent) as translation increases
    // This is just a placeholder logic
    let opacity = max(0, 1 - translation / 100)
    return Double(opacity)
}
