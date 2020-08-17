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

  @State private var bunnyPosition1 = CGPoint(x:3,y:0)
  @State private var bunnyPosition2 = CGPoint(x:3,y:0)
  @State private var bunnyPosition3 = CGPoint(x:3,y:0)
  @State var timer: Timer?

  func startAnimating() {
    timer = Timer(timeInterval: 3, repeats: true) { _ in
      if Bool.random() {
        animateBunny1()
      }
      if Bool.random() {
        animateBunny2()
      }
      if Bool.random() {
        animateBunny3()
      }
    }
    RunLoop.main.add(timer!, forMode: .common)
    animateBunny3()
  }

  func animateBunny1() {
    bunnyPosition1.x = 2
    bunnyPosition1.y = CGFloat.random(in: -1...1)

    withAnimation(.linear(duration: Double.random(in: 2...3))) {
      bunnyPosition1.x = -2
      bunnyPosition1.y = CGFloat.random(in: -1...1)
    }
  }

  func animateBunny2() {
    bunnyPosition2.x = 2
    bunnyPosition2.y = CGFloat.random(in: -1...1)

    withAnimation(.linear(duration: 3)) {
      bunnyPosition2.x = -2
      bunnyPosition2.y = CGFloat.random(in: -1...1)
    }
  }

  func animateBunny3() {
    bunnyPosition3.x = -2
    bunnyPosition3.y = CGFloat.random(in: -1...1)

    withAnimation(.linear(duration: 3)) {
      bunnyPosition3.x = 2
      bunnyPosition3.y = CGFloat.random(in: -1...1)
    }
  }

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

        Image("bunny_blue").offset(
          x: bunnyPosition1.x * geometry.size.width/2,
          y: bunnyPosition1.y * geometry.size.height/2).opacity(1)
        Image("bunny_teal").offset(
          x: bunnyPosition2.x * geometry.size.width/2,
          y: bunnyPosition2.y * geometry.size.height/2).opacity(1)
        Image("bunny_yellow").offset(
          x: bunnyPosition3.x * geometry.size.width/2,
          y: bunnyPosition3.y * geometry.size.height/2).opacity(1)
      }.fullScreenCover(isPresented: $isSearchShowing) {
        SearchPage()
      }
    }.ignoresSafeArea()
    .onAppear {
      startAnimating()
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
