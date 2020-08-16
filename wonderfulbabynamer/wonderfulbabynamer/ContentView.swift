//
//  ContentView.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/15/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack {
        Text("Wonderful Baby Namer")
            .padding()
          .font(Font.custom ("Henny Penny", size: 20))
          .background(Image("homePage"), alignment: .center)
      }

       // Text("Hello, world!")
          //  .padding()
    
    }
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().previewLayout(.fixed(width: 414, height: 896))
    }
}
