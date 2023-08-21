import SwiftUI
import shared

struct ContentView: View {
	
  let appModule: AppModule

	var body: some View {
    ZStack {
      Color.background
        .ignoresSafeArea() // Override default DarkTheme from iOs, and make a better dark theme
      
      TranslateScreen(
        historyDateSource: appModule.historyDataSource,
        translateUseCase: appModule.translateUseCase,
        parser: appModule.voiceParser
      )
    }
	}
}
