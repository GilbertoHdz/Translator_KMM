package com.gilbertohdz.translator_kmm.di

import com.gilbertohdz.translator_kmm.translate.data.local.FakeHistoryDataSource
import com.gilbertohdz.translator_kmm.translate.data.remote.FakeTranslateClient
import com.gilbertohdz.translator_kmm.translate.domain.history.HistoryDataSource
import com.gilbertohdz.translator_kmm.translate.domain.translate.Translate
import com.gilbertohdz.translator_kmm.translate.domain.translate.TranslateClient
import com.gilbertohdz.translator_kmm.voice_to_text.data.FakeVoiceToTextParser
import com.gilbertohdz.translator_kmm.voice_to_text.data.VoiceToTextParser
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object TestAppModule {

  @Provides
  @Singleton
  fun provideFakeTranslateClient(): TranslateClient {
    return FakeTranslateClient()
  }

  @Provides
  @Singleton
  fun provideFakeHistoryDataSource(): HistoryDataSource {
    return FakeHistoryDataSource()
  }

  @Provides
  @Singleton
  fun provideTranslateUseCase(
    client: TranslateClient,
    dataSource: HistoryDataSource
  ): Translate {
    return Translate(client, dataSource)
  }

  @Provides
  @Singleton
  fun provideFakeVoiceToTextParser(): VoiceToTextParser {
    return FakeVoiceToTextParser()
  }
}