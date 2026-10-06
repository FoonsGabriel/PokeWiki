//
//  PokeWikiApp.swift
//  PokeWiki
//
//  Created by GABRIEL DE SOUZA FONSECA on 29/09/26.
//

import SwiftUI

@main
struct PokeWikiApp: App {

    init() {
        let urlCache = URLCache(
            memoryCapacity: 1024 * 1024 * 100,
            diskCapacity: 1024 * 1024 * 500,
            diskPath: "async_image_cache"
        )
    }

    var body: some Scene {
        WindowGroup {
            PokemonListView()
        }
    }
}
