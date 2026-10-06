import Foundation

struct PokemonApiService {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    func fetchPokemonsByType(_ type: String) async throws -> [Pokemon] {

        let typeURL = baseURL
            .appendingPathComponent("type")
            .appendingPathComponent(type)

        let (data, httpResponse) = try await URLSession.shared.data(
            from: typeURL
        )

        guard let response = httpResponse as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let typeResponse = try JSONDecoder().decode(
            PokemonTypeApiResponse.self,
            from: data
        )

        let randomPokemons = Array(
            typeResponse.pokemon.shuffled().prefix(10)
        )

        var pokemons: [Pokemon] = []

        for item in randomPokemons {
            let pokemon = try await fetchPokemon(
                from: item.pokemon.url
            )

            pokemons.append(pokemon)
        }

        return pokemons
    }

    private func fetchPokemon(from urlString: String) async throws -> Pokemon {

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, httpResponse) = try await URLSession.shared.data(
            from: url
        )

        guard let response = httpResponse as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let pokemonResponse = try JSONDecoder().decode(
            PokemonApiResponse.self,
            from: data
        )

        return Pokemon(
            id: pokemonResponse.id,
            name: pokemonResponse.name,
            height: pokemonResponse.height,
            weight: pokemonResponse.weight,
            types: pokemonResponse.types,
            abilities: pokemonResponse.abilities,
            sprites: pokemonResponse.sprites
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

