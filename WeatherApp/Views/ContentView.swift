//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mohamad Shehab on 25/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        VStack{
            
            if let location = locationManager.location{
                Text("Your Coordinates are:\(location.longitude),\(location.latitude)")
            } else {
                if locationManager.isLoading{
                    LoadingView( )
                } else {
                    WelcomeView().environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.573, saturation: 0.615, brightness: 0.385))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
