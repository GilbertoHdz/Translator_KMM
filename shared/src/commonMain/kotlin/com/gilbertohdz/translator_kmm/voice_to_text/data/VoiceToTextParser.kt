package com.gilbertohdz.translator_kmm.voice_to_text.data

import com.gilbertohdz.translator_kmm.core.domain.util.CommonStateFlow

interface VoiceToTextParser {
  val state: CommonStateFlow<VoiceToTextParserState>
  fun startListening(languageCode: String)
  fun stopListening()
  fun cancel()
  fun reset()

}