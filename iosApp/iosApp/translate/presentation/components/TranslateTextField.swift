//
//  TranslateTextField.swift
//  iosApp
//
//  Created by Gilberto Hernandez G. on 15/08/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared
import UniformTypeIdentifiers

struct TranslateTextField: View {
  @Binding var fromText: String
  let toText: String
  let isTranslating: Bool
  let fromLanguage: UiLanguage
  let toLanguage: UiLanguage
  let onTranslateEvent: (TranslateEvent) -> Void
  
  var body: some View {
    
    if toText.isEmpty || isTranslating {
      
      IdleTextField(
        fromText: $fromText,
        isTranslating: isTranslating,
        onTranslateEvent: onTranslateEvent
      )
      .gradientSurface()
      .cornerRadius(15)
      .animation(.easeInOut, value: isTranslating)
      .shadow(radius: 4)
    } else {
      
      TranslatedTextField(
        fromText: fromText,
        toText: toText,
        fromLanguage: fromLanguage,
        toLanguage: toLanguage,
        onTranslateEvent: onTranslateEvent
      )
      .padding()
      .gradientSurface()
      .cornerRadius(15)
      .animation(.easeOut, value: isTranslating)
      .shadow(radius: 4)
      .onTapGesture {
        onTranslateEvent(TranslateEvent.EditTranslation())
      }
      
    }
    
  }
}

struct TranslateTextField_Previews: PreviewProvider {
  static var previews: some View {
    TranslateTextField(
      fromText: Binding(
        get: { "test" },
        set: { value in }
      ),
      toText: "Test",
      isTranslating: false,
      fromLanguage: UiLanguage(language: .english, imageName: "english"),
      toLanguage: UiLanguage(language: .spanish, imageName: "spanish"),
      onTranslateEvent: { event in }
    )
  }
}

private extension TranslateTextField {
  
  // Idle Text Field
  struct IdleTextField: View {
    @Binding var fromText: String
    let isTranslating: Bool
    let onTranslateEvent: (TranslateEvent) -> Void
    
    var body: some View {
      
      TextEditor(text: $fromText)
        .frame(
          maxWidth: .infinity,
          minHeight: 200,
          alignment: .topLeading
        )
        .padding()
        .foregroundColor(Color.onSurface)
        .overlay(alignment: .bottomTrailing) {
          ProgressButton(
            text: "Translate",
            isLoading: isTranslating,
            onClick: {
              onTranslateEvent(TranslateEvent.Translate())
              
            }
          )
          .padding(.trailing)
          .padding(.bottom)
          
        }
        .onAppear {
          UITextView.appearance().backgroundColor = .clear
        }
    }
  }
  
  struct TranslatedTextField: View {
    
    let fromText: String
    let toText: String
    let fromLanguage: UiLanguage
    let toLanguage: UiLanguage
    let onTranslateEvent: (TranslateEvent) -> Void
    
    private let tts = TextToSpeech()
    
    var body: some View {
      
      VStack(alignment: .leading) {
        
        // To Text

        LanguageDisplay(language: fromLanguage)
        Text(fromText)
          .foregroundColor(.onSurface)
        
        HStack { // From Language HStak
          
          Spacer()
          Button(action: {
            UIPasteboard.general.setValue(
              fromText,
              forPasteboardType: UTType.plainText.identifier
            )
          }, label: {
            Image(uiImage: UIImage(named: "copy")!)
              .renderingMode(.template)
              .foregroundColor(.lightBlue)
          })
          
          Button(action: {
            onTranslateEvent(TranslateEvent.CloseTranslation())
          }, label: {
            Image(systemName: "xmark")
              .foregroundColor(.lightBlue)
          })
          
        }
        
        // Line Divider
        Divider().padding()
        
        // To Text
        LanguageDisplay(language: toLanguage)
          .padding(.bottom)
        Text(toText)
          .foregroundColor(.onSurface)
        
        HStack { // To Language HStak
          Spacer()
          Button(action: {
            UIPasteboard.general.setValue(
              toText,
              forPasteboardType: UTType.plainText.identifier
            )
          }, label: {
            Image(uiImage: UIImage(named: "copy")!)
              .renderingMode(.template)
              .foregroundColor(.lightBlue)
          })
          
          Button(action: {
            tts.speak(
              text: toText,
              language: toLanguage.language.langCode
            )
          }, label: {
            Image(systemName: "speaker.wave.2")
              .foregroundColor(.lightBlue)
          })
        }
        
      }
      
    }
  }
  
  
}
