import SwiftUI

struct PokemonListView: View {

    @State private var viewModel = PokemonViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Checando a Pokedex do Ash...")
                        .controlSize(.large)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text(error)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        Button("Cheque a Pokedex novamente") {
                            Task { await viewModel.fetchPokemons() }
                        }
                        .buttonStyle(.borderedProminente)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.pokemons) { pokemon in 
                                VStack {
                                    AsyncImage(url: pokemon.sprites) { phase in 
                                        switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            case .failure:
                                                Image(systemName: "pawprint.circle.fill")
                                                    .font(.system(size: 40))
                                                    .foregroundColor(.gray.opacity(0.6))
                                            @unknown default:
                                                EmptyView()
                                        }
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                                    Text("ID: \(pokemon.id.uuidString.prefix(5))")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await viewModel.fetchPokemons()
                    }
                }
            }
            .navigationTitle("Pokemons")
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }
}

#Preview {
    PokemonListView()
}