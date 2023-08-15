//
//  ProgressButton.swift
//  iosApp
//
//  Created by Gilberto Hernandez G. on 15/08/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct ProgressButton: View {
  var text: String
  var isLoading: Bool
  var onClick: () -> Void
  
  var body: some View {
    Button(
      action: {
        if !isLoading {
          onClick()
        }
      }
    ) {
      if isLoading {
        ProgressView()
          .animation(.easeOut, value: isLoading)
          .padding(5) // same has a Text
          .background(Color.primaryColor)
          .cornerRadius(100)
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
      } else {
        Text(text.uppercased())
          .animation(.easeOut, value: isLoading)
          .padding(.horizontal)
          .padding(.vertical, 5) // same has a progress bar
          .font(.body.weight(.bold))
          .background(Color.primaryColor)
          .foregroundColor(Color.onPrimary)
          .cornerRadius(100)
      }
    }
  }
}

struct ProgressButton_Previews: PreviewProvider {
  static var previews: some View {
    ProgressButton(text: "Translate",
                   isLoading: true, // change tru or fasle
                   onClick: {}
    )
  }
}
