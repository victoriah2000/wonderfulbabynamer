//
//  SearchPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI

struct SearchPage: View {
    var body: some View {
      VStack {
        //Text("Wonderful Baby Namer")
           // .padding()
          //.background(Image("blue_bg"), alignment: .center )
        ZStack {
          HStack(alignment: .top) {
            Image ("bunny_banner")
              .padding(.all)
              .frame(width: 0.0)
          }.frame(width: 414, height: 896, alignment: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/)
          HStack {
            Image ("green_banner")
              .padding(.all)
              .frame(width: 0.0)
            Spacer()
            Image ("boy")
            
            
        }
        .background(Image("blue_bg"), alignment: .center )
      }

    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
      SearchPage().previewLayout(.fixed(width: 414, height: 896))
    }
}
}
