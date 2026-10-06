import SwiftUI

struct TelaCarrosselView: View {

    let tipo: String

    @State private var viewModel = PokemonViewModel()

    var body: some View {

        Group {

            if viewModel.isLoading {

                VStack(spacing: 16) {

                    ProgressView()
                        .controlSize(.large)

                    Text("Carregando Pokémons...")
                        .font(.headline)
                }

            } else if let error = viewModel.errorMessage {

                VStack(spacing: 16) {

                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)

                    Text(error)

                    Button("Tentar novamente") {
                        Task {
                            await viewModel.fetchPokemons(type: tipo)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()

            } else {

                ScrollView(.horizontal) {

                    LazyHStack(spacing: 20) {

                        ForEach(viewModel.pokemons) { pokemon in

                            NavigationLink {
                                TelaDetalhesView(pokemon: pokemon)
                            } label: {

                                PokemonCardView(pokemon: pokemon)
                            }
                        }
                    }
                    .padding()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .navigationTitle(tipo.capitalized)
        .task {
            await viewModel.fetchPokemons(type: tipo)
        }
    }
}

struct PokemonCardView: View {

    let pokemon: Pokemon

    var body: some View {

        VStack(spacing: 12) {

            Text("#\(pokemon.id)")
                .font(.headline)
                .foregroundStyle(.secondary)

            AnimatedImage(
                url: URL(
                    string:
                        pokemon.sprites.animated?.frontDefault
                        ?? pokemon.sprites.frontDefault
                        ?? ""
                )
            )
            .frame(width: 220, height: 220)

            Text(pokemon.name.capitalized)
                .font(.title2)
                .fontWeight(.bold)

            HStack {

                ForEach(
                    pokemon.types,
                    id: \.type.name
                ) { type in

                    Text(type.type.name.capitalized)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .frame(width: 280, height: 400)
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
        .shadow(
            color: .black.opacity(0.15),
            radius: 6
        )
    }
}

#Preview {
    NavigationStack {
        TelaCarrosselView(tipo: "fire")
    }
}
