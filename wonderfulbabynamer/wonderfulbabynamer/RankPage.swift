//
//  RankPage.swift
//  wonderfulbabynamer
//
//  Created by Victoria Heric on 8/16/20.
//

import SwiftUI

struct RankPage: View {
    var body: some View {
      VStack {
        Text("Wonderful Baby Namer")
          .font(Font.custom("HennyPenny-Regular", size: 35))
            .padding()
          .background(Image("rankPage"), alignment: .center )
        
      }
    }
}

struct RankPage_Previews: PreviewProvider {
    static var previews: some View {
      RankPage().previewLayout(.fixed(width: 414, height: 896))
    }
}
