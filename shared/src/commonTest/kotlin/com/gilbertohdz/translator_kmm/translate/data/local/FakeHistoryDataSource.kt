package com.gilbertohdz.translator_kmm.translate.data.local

import com.gilbertohdz.translator_kmm.core.domain.util.CommonFlow
import com.gilbertohdz.translator_kmm.core.domain.util.toCommonFlow
import com.gilbertohdz.translator_kmm.translate.domain.history.HistoryDataSource
import com.gilbertohdz.translator_kmm.translate.domain.history.HistoryItem
import kotlinx.coroutines.flow.MutableStateFlow

class FakeHistoryDataSource: HistoryDataSource {

  private val  _data = MutableStateFlow<List<HistoryItem>>(emptyList())

  override fun getHistory(): CommonFlow<List<HistoryItem>> {
    return _data.toCommonFlow()
  }

  override suspend fun insertHistoryItem(item: HistoryItem) {
    _data.value += item
  }
}