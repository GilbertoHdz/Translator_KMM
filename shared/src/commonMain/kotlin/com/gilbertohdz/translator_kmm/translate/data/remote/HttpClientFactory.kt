package com.gilbertohdz.translator_kmm.translate.data.remote

import io.ktor.client.HttpClient

expect class HttpClientFactory {
  fun create(): HttpClient
}