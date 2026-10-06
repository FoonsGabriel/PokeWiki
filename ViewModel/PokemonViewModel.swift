import Foundation
import Observation

@Observable
final class PokemonViewModel {

    var pokemons: [Pokemon] = []
    var isLoading = false
    var errorMessage: String?

    private let service = PokemonApiService()

    func fetchPokemons(type: String) async {

        isLoading = true
        errorMessage = nil
        pokemons = []

        do {
            pokemons = try await service.fetchPokemonsByType(type)
            isLoading = false
        } catch {
            errorMessage = "Não foi possível carregar os Pokémons."
            isLoading = false
        }
    }
}
