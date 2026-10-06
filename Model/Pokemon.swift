import SwiftUI

struct Pokemon: Identifiable, Hashable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let sprites: PokemonSprites
}

struct PokemonApiResponse: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let sprites: PokemonSprites
}

struct PokemonType: Decodable, Hashable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Decodable, Hashable {
    let name: String
}

struct PokemonAbility: Decodable, Hashable {
    let ability: AbilityInfo
}

struct AbilityInfo: Decodable, Hashable {
    let name: String
}

struct PokemonSprites: Decodable, Hashable {
    let frontDefault: String?
    let animated: AnimatedSprites?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case versions
    }

    enum VersionsKeys: String, CodingKey {
        case generationV = "generation-v"
    }

    enum GenerationVKeys: String, CodingKey {
        case blackWhite = "black-white"
    }

    enum BlackWhiteKeys: String, CodingKey {
        case animated
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        frontDefault = try container.decodeIfPresent(
            String.self,
            forKey: .frontDefault
        )

        if let versions = try? container.nestedContainer(
            keyedBy: VersionsKeys.self,
            forKey: .versions
        ),
        let generationV = try? versions.nestedContainer(
            keyedBy: GenerationVKeys.self,
            forKey: .generationV
        ),
        let blackWhite = try? generationV.nestedContainer(
            keyedBy: BlackWhiteKeys.self,
            forKey: .blackWhite
        ) {
            animated = try? blackWhite.decodeIfPresent(
                AnimatedSprites.self,
                forKey: .animated
            )
        } else {
            animated = nil
        }
    }
}

struct AnimatedSprites: Decodable, Hashable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
