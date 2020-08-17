//
//  RankPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI


struct NameCell: View {
  var name: String
  var body: some View {
    Text(name)
  }
}

struct RankPage: View {

  @ObservedObject var model: BabyNameModel

  @State private var bunnyPosition1 = CGPoint(x:3,y:0)
  @State private var bunnyPosition2 = CGPoint(x:3,y:0)
  @State private var bunnyPosition3 = CGPoint(x:3,y:0)
  @State var timer: Timer?

  func startAnimating() {
    timer = Timer(timeInterval: 3, repeats: true) { _ in

      switch Int.random(in: 1...3) {
      case 1:
        animateBunny1()
      case 2:
        animateBunny2()
      case 3:
        animateBunny3()
      case _:
        break
      }
    }
    RunLoop.main.add(timer!, forMode: .common)
    animateBunny3()
  }

  func stopAnimating() {
    timer?.invalidate()
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


  let magenta = Color(UIColor(red: CGFloat(0xcc)/255, green: CGFloat(0x33)/255,
                              blue: CGFloat(0x8b)/255, alpha: 1))

  var body: some View {
    ZStack {
      Image("rankPage").resizable()
        .aspectRatio(contentMode: .fill).ignoresSafeArea()
      GeometryReader { geometry in
        ZStack {
          VStack() {
            Text("My Favorites")
              .font(Font.custom("HennyPenny-Regular", size: 35))
              .padding(.top, 80)
              .padding(30)
            Group {
              if (model.favorites.isEmpty) {
                ZStack {
                  Color.clear
                  Text("No favorites yet").font(.title)
                    .offset(y: -70)
                }
              }
              else {
                VStack(alignment: .leading, spacing: 50) {
                  ForEach(model.favorites, id: \.self) { name in
                    HStack {
                      Text(name.localizedCapitalized)
                      Spacer()
                      Image(systemName: "heart.fill").foregroundColor(magenta).onTapGesture {
                        withAnimation {
                          model.tapFavorite(name: name)
                        }
                      }
                    }
                    .font(.title)
                    .frame(height: 10)
                  }
                }
                .padding(100)
              }
            }
            Spacer()
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
      }
    }.onAppear {
      startAnimating()
    }
    .onDisappear() {
      stopAnimating()
    }
  }
}

struct RankPage_Previews: PreviewProvider {
  static var previews: some View {
//    TabView {
//      RankPage(model: BabyNameModel(favorites: [
//                                      "Fred", "Joe", "Biden", "Mamala"]))
//    }
    TabView {
      RankPage(model: BabyNameModel())
    }
  }
}
