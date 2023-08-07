package com.gilbertohdz.translator_kmm.core.domain.util

fun interface DisposableHandle: kotlinx.coroutines.DisposableHandle


/* In order to use lambda from return DisposableHandle { job.cancel() } this code is necessary without fun interface
fun DisposableHandle(block: () -> Unit): DisposableHandle {
  return object : DisposableHandle { // remove fun from interface declaration and this will be necessary
    override fun dispose() {
      block()
    }
  }
}
*/
