import Foundation

struct PokemonApiService {
    private let apiURL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(idPokemon)")!

    func fetchPokemons() async throws -> [Pokemon] {
        let (data, response) = try await URLSession.shared.data(from: apiURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decodedResponse = try JSONDecoder().decode(PokemonApiResponse.self, from: data)

        let loadedPokemon = decodedResponse.message.compactMap {
            urlString -> Pokemon? in guard let url = URL(string: urlString) else { return nil }
            return Pokemon(sprites: sprites)
        }
        return loadedPokemon
    }
}