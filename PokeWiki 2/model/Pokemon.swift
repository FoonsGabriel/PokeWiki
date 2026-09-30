import SwiftUI

struct Pokemon: Identifiable, Hashable {
    let id: UUID
    let name: String

    let types: [PokemonType]
    let sprites: PokemonSprites

    init(id: UUID = UUID(), name: String, types: [PokemonType], sprites: PokemonSprites){
        self.id = id
        self.name = name
        self.types = types
        self.sprites = sprites
    }

    struct PokemonApiResponse: Decodable {
        let message: [String]
        let status: String
    }
}