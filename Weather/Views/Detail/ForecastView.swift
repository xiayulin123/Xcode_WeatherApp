//
//  ForecaseView.swift
//  Weather
//
//  Created by Yulin Xia on 2024-02-18.
//

import SwiftUI
import BottomSheet

struct ForecastView: View {
    var isPresented: Bool
    @State private var selection = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: Segmented Control
                SegmentedControl(selection: $selection)
            }
            // MARK: Forecast Cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if selection == 0 {
                        ForEach(Forecast.hourly) { forecast in
                            ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                        }
                        .transition(.offset(x: -430))
                    } else {
                        ForEach(Forecast.daily) { forecast in
                            ForecastCard(forecast: forecast, forecastPeriod: .daily)
                        }
                        .transition(.offset(x: 430))
                    }
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 20)
            if isPresented{
                Image("Forecast Widgets")
                    .opacity(1)
            } else {
                Image("Forecast Widgets")
                    .opacity(0)
            }
            // MARK: Forecast Widgets
            
        }
//        .blur(radius: 25, opaque: true)
//        .background(Blur(radius: 25, opaque: true))
//        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        
        .overlay {
            // MARK: Bottom Sheet Separator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(isPresented: false)
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
