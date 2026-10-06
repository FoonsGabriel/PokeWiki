import SwiftUI

@main
struct PokeWikiApp: App {

    init() {
        let urlCache = URLCache(
            memoryCapacity: 1024 * 1024 * 100,
            diskCapacity: 1024 * 1024 * 500,
            diskPath: "async_image_cache"
        )

        URLCache.shared = urlCache
    }

    var body: some Scene {
        WindowGroup {
            PokemonListView()
        }
    }
}
