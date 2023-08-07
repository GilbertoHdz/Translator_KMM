package com.gilbertohdz.translator_kmm.core.domain.util

import kotlinx.coroutines.flow.Flow

/**
 * expect because we need implementation for Android and iOs
 * since iOs does not have coroutines
 */
expect class CommonFlow<T>(flow: Flow<T>): Flow<T>

fun <T> Flow<T>.toCommonFlow() = CommonFlow(this)