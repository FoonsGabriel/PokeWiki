import Foundation
import Observation

@Observable
final class PokemonViewModel {
    var pokemons: [Pokemon] = []
    var isLoading = false
    var errorMessage: String? = nil

    private let service = PokemonApiService()

    func fetchPokemons() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchPokemons = try await service.fetchPokemons()

            self.pokemons = fetchPokemons
            self.isLoading = false
        } catch {
            self.errorMessage = "Não foi possível carregar os Pokemons: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}