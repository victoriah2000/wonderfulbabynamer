//
//  SearchPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI

struct SearchPage: View {
  
  @StateObject var model = BabyNameModel()
  
  var body: some View {
    ZStack {
      Image("blue_bg").resizable().ignoresSafeArea()
      VStack {
        
        TextField("\(Image(systemName: "magnifyingglass")) Search...", text: $model.filterString)
          .padding()
          .background(Color(.systemBackground))
          .border(Color.gray)
          .padding(EdgeInsets(top: 60, leading: 10, bottom: 10, trailing: 10))
        ZStack {
          Image("green_banner").resizable().frame(width: 400, height: 230
          )
          VStack {
            
            Text("Child Parameters...")
              .font(Font.custom ("HennyPenny-Regular", size: 20))
              .padding(.top, 20)
              .padding(.bottom, -10)
          
          HStack {
            Spacer()
            
            ZStack {
              Image(model.filterGender == .boy ? "boy" : "girl")
                .frame(width: 40, height: 40).shadow(radius: 2)
              Text(model.filterGender.name).foregroundColor(.black)
                .offset(y: model.filterGender == .boy ? 35.0 : 25.0)
              
            }
            .padding(30)
            .onTapGesture {
              model.filterGender = model.filterGender == .boy ? .girl : .boy
            }
            
            
            Spacer()
            
            ZStack {
              Image(model.order == .popularity ? "mixed" : "mixed")
                .frame(width: 40, height: 40).shadow(radius: 2)
              Text(model.order.name).foregroundColor(.black)
                .offset(y: model.order == .popularity ? 25.0 : 25.0)
              
            }
            .padding(30)
            .onTapGesture {
              model.order = model.order == .alpha ? .popularity : .alpha
            }
            Spacer()
          }.padding(.bottom, 30)
            
          }
        }
          //          Image("boy")
          //          Image("girl")
          //          Image("girl")
          
          //          Picker(selection: $model.order,
          //                 label: Text(model.order.name)) {
          //            Text(SortOrder.alpha.name).tag(SortOrder.alpha)
          //            Text(SortOrder.popularity.name).tag(SortOrder.popularity)
          //          }.pickerStyle(MenuPickerStyle())
          
          //          Picker(selection: $model.filterGender,
          //                 label: Text(model.filterGender.name)) {
          //            Text(Gender.boy.name).tag(Gender.boy)
          //            Text(Gender.girl.name).tag(Gender.girl)
          //          }.pickerStyle(MenuPickerStyle())
          
          List(model.babyNames) { babyName in
            HStack {
              Text(babyName.name.localizedCapitalized)
              Spacer()
              Group {
                if model.favorites.contains(babyName.name) {
                  Image(systemName: "heart.fill").foregroundColor(.red)
                }
                else {
                  Image(systemName: "heart").foregroundColor(.gray)
                }
              }.onTapGesture {
                withAnimation {
                  model.tapFavorite(name: babyName.name)
                }
              }
            }
          }
        }
      }
    }
  }
  
  struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
      SearchPage()
    }
  }


