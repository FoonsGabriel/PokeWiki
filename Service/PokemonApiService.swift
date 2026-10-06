import Foundation

struct PokemonApiService {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    func fetchPokemonsByType(_ type: String) async throws -> [Pokemon] {

        let typeURL = baseURL
            .appendingPathComponent("type")
            .appendingPathComponent(type)

        let (data, response) = try await URLSession.shared.data(
            from: typeURL
        )

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let typeResponse = try JSONDecoder().decode(
            PokemonTypeApiResponse.self,
            from: data
        )

        let firstPokemons = Array(
            typeResponse.pokemon.prefix(10)
        )

        var pokemons: [Pokemon] = []

        for item in firstPokemons {
            let pokemon = try await fetchPokemon(from: item.pokemon.url)
            pokemons.append(pokemon)
        }

        return pokemons
    }

    private func fetchPokemon(from urlString: String) async throws -> Pokemon {

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(
            from: url
        )

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let response = try JSONDecoder().decode(
            PokemonApiResponse.self,
            from: data
        )

        return Pokemon(
            id: response.id,
            name: response.name,
            height: response.height,
            weight: response.weight,
            types: response.types,
            abilities: response.abilities,
            sprites: response.sprites
        )
    }
}

struct PokemonTypeApiResponse: Decodable {
    let pokemon: [PokemonTypeResult]
}

struct PokemonTypeResult: Decodable {
    let pokemon: PokemonURL
}

struct PokemonURL: Decodable {
    let name: String
    let url: String
}
