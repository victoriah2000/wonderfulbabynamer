//
//  ContentView.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/15/20.
//

import SwiftUI


struct TitleView: View {
  var body: some View {
    ZStack {
      Image("nameplate")
      Text("Wonderful Baby Namer")
        .font(Font.custom ("HennyPenny-Regular", size: 19))
        .padding().offset(y: 38.0)
    }
  }
}

struct TitleBackground: View {
  var body: some View {
    Image("homePage").resizable()
      .aspectRatio(contentMode: .fill)
  }
}

struct BunnySearchView: View {
  var width: CGFloat
  
  var body: some View {
    ZStack {
      Image("bunny_pink")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: width)
      Text("Search")
        .font(Font.custom ("HennyPenny-Regular",
                           size: width*0.20))
        .offset(y: -width*0.25)
    }
  }
}

//Image("bunny_blue")
//Image("bunny_teal")
//Image("bunny_yellow")

struct ContentView: View {
  
  @State private var isSearchShowing = false
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        TitleBackground()
        VStack {
          TitleView().padding()
          Spacer()
        }
        VStack {
          Spacer()
          BunnySearchView(width: geometry.size.width * 0.9)
            .onTapGesture {
              isSearchShowing = true
            }
        }
      }.fullScreenCover(isPresented: $isSearchShowing) {
        SearchPage()
      }
    }.ignoresSafeArea()
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
