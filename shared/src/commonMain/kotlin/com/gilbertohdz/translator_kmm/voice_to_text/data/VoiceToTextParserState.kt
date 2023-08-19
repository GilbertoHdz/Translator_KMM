package com.gilbertohdz.translator_kmm.voice_to_text.data

data class VoiceToTextParserState(
  val result: String = "",
  val error: String? = null,
  val powerRatio: Float = 0f,
  val isSpeaking: Boolean = false
)
