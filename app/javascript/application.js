// Polyfill for Explicit Resource Management (required by cocooned 3.x in older browsers)
// Must run BEFORE cocooned is imported — using dynamic import() since static imports are hoisted
if (typeof Symbol.dispose !== "symbol") {
  Symbol.dispose = Symbol("Symbol.dispose")
}

if (typeof DisposableStack === "undefined") {
  window.DisposableStack = class DisposableStack {
    #disposed = false
    #stack = []

    use(resource) {
      if (this.#disposed) throw new Error("DisposableStack is disposed")
      this.#stack.push(resource)
      return resource
    }

    defer(fn) {
      if (this.#disposed) throw new Error("DisposableStack is disposed")
      this.#stack.push(fn)
    }

    dispose() {
      if (this.#disposed) return
      this.#disposed = true
      while (this.#stack.length) {
        const item = this.#stack.pop()
        try {
          if (typeof item[Symbol.dispose] === "function") {
            item[Symbol.dispose]()
          } else if (typeof item === "function") {
            item()
          }
        } catch {}
      }
    }

    [Symbol.dispose]() {
      this.dispose()
    }
  }
}

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import("@notus.sh/cocooned").then(({ default: Cocooned }) => {
  document.addEventListener("turbo:load", () => {
    Cocooned.start()
  })
})
