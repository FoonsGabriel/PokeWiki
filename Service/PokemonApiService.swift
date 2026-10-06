import Foundation

struct PokemonApiService {

    private let apiURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func fetchPokemons() async throws -> [Pokemon] {

        var pokemons: [Pokemon] = []

        for id in 1...20 {

            let url = apiURL.appendingPathComponent("\(id)")

            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            let decodedPokemon = try JSONDecoder().decode(
                PokemonApiResponse.self,
                from: data
            )

            let pokemon = Pokemon(
                name: decodedPokemon.name,
                types: decodedPokemon.types,
                sprites: decodedPokemon.sprites
            )

            pokemons.append(pokemon)
        }

        return pokemons
    }
}
