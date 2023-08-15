//
//  TranslateScreen.swift
//  iosApp
//
//  Created by Gilberto Hernandez G. on 11/08/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct TranslateScreen: View {
  private var historyDateSource: HistoryDataSource
  private var translateUseCase: Translate
  @ObservedObject var viewModel: IOSTranslateViewModel
  
  init(historyDateSource: HistoryDataSource, translateUseCase: Translate) {
    self.historyDateSource = historyDateSource
    self.translateUseCase = translateUseCase
    self.viewModel = IOSTranslateViewModel(historyDataSource: historyDateSource, translateUseCase: translateUseCase)
  }
  
  var body: some View {
    ZStack {
      
      List {
        
        HStack(alignment: .center) {
          LanguageDropDown(
            language: viewModel.state.fromLanguage,
            isOpen: viewModel.state.isChoosingToLanguage,
            selectLanguage: { language in
              viewModel.onEvent(event: TranslateEvent.ChooseFromLanguage(language: language))
            }
          )
          
          Spacer()
          SwapLanguageButton(onClick: {
            viewModel.onEvent(event: TranslateEvent.SwapLanguages())
          })
          Spacer()
          
          LanguageDropDown(
            language: viewModel.state.toLanguage,
            isOpen: viewModel.state.isChoosingToLanguage,
            selectLanguage: { language in
              viewModel.onEvent(event: TranslateEvent.ChooseToLanguage(language: language))
            }
          )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.background)
        
        // Translation Edit Text
        TranslateTextField(
          fromText: Binding(
            get: { viewModel.state.fromText },
            set: { value in
              viewModel.onEvent(event: TranslateEvent.ChangeTranslationText(text: value))
            }
          ),
          toText: viewModel.state.toText ?? "",
          isTranslating: viewModel.state.isTranslating,
          fromLanguage: viewModel.state.fromLanguage,
          toLanguage: viewModel.state.toLanguage,
          onTranslateEvent: { viewModel.onEvent(event: $0) } // $0 -> Element object from the List
        )
        .listRowSeparator(.hidden)
        .listRowBackground(Color.background)
        
      }
      .listStyle(.plain)
      .buttonStyle(.plain)
      
    }
    .onAppear {
      viewModel.startObserving()
    }
    .onDisappear {
      viewModel.dispose()
    }
    
  }
}

/*
struct TranslateScreen_Previews: PreviewProvider {
  static var previews: some View {
    TranslateScreen()
  }
}
*/
