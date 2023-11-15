//
//  ContentView.swift
//  Weeeather
//
//  Created by taekki on 2023/11/14.
//

import SwiftUI

struct ContentView: View {
  @StateObject var weatherStore = WeatherStore()
  
  var weathers: some View {
    ForEach(weatherStore.weathers) { countryWeather in
      VStack(alignment: .leading, spacing: 0) {
        HStack() {
          AsyncImage(url: URL(string: countryWeather.current.condition.iconString))
          
          Text(countryWeather.current.tempCString)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .bold()
        }
        
        Text(countryWeather.location.country)
          .font(.title3)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding()
      .background {
        LinearGradient(
          gradient: Gradient(colors: [.blue, .yellow]),
          startPoint: .leading,
          endPoint: .trailing
        )
      }
    }
  }
  
  var content: some View {
    ScrollView {
      if weatherStore.isLoading {
        VStack {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .red))
            .padding()
            .frame(maxHeight: .infinity)
        }
      } else {
        weathers
      }
    }
    .padding(.horizontal, 16)
  }
  
  var body: some View {
    content
      .navigationTitle("Weathers")
      .navigationBarTitleDisplayMode(.large)
      .onAppear {
        weatherStore.fetchManyCountryWeather()
      }
  }
}

#Preview {
  ContentView()
}
