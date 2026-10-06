import SwiftUI

struct PokemonListView: View {

    @State private var viewModel = PokemonViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.94, green: 0.94, blue: 0.90)
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView("Carregando Pokédex...")
                        .controlSize(.large)

                } else if let error = viewModel.errorMessage {

                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 45))
                            .foregroundStyle(.red)

                        Text(error)
                            .multilineTextAlignment(.center)

                        Button("Tentar novamente") {
                            Task {
                                await viewModel.fetchPokemons()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()

                } else {

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {

                            ForEach(viewModel.pokemons) { pokemon in

                                VStack(spacing: 8) {

                                    ZStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.white)

                                        AnimatedImage(
                                            url: URL(
                                                string: pokemon.sprites.animated?.frontDefault
                                                    ?? pokemon.sprites.frontDefault
                                                    ?? ""
                                            )
                                        )
                                        .frame(height: 140)
                                        .padding(8)
                                    }
                                    .frame(height: 160)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.black, lineWidth: 2)
                                    }

                                    Text(pokemon.name.capitalized)
                                        .font(.headline)
                                        .foregroundStyle(.black)

                                    HStack(spacing: 6) {
                                        ForEach(pokemon.types, id: \.type.name) { type in
                                            Text(type.type.name.capitalized)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(typeColor(type.type.name))
                                                .foregroundStyle(.white)
                                                .clipShape(Capsule())
                                        }
                                    }
                                }
                                .padding(8)
                                .background(.white.opacity(0.75))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadow(
                                    color: .black.opacity(0.15),
                                    radius: 4,
                                    x: 0,
                                    y: 2
                                )
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await viewModel.fetchPokemons()
                    }
                }
            }
            .navigationTitle("Pokédex")
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }

    private func typeColor(_ type: String) -> Color {
        switch type {
        case "fire":
            return .red
        case "water":
            return .blue
        case "grass":
            return .green
        case "electric":
            return .yellow
        case "psychic":
            return .purple
        case "ice":
            return .cyan
        case "fighting":
            return .orange
        case "poison":
            return .purple
        case "ground":
            return .brown
        case "flying":
            return .indigo
        case "bug":
            return .green
        case "rock":
            return .gray
        case "ghost":
            return .indigo
        case "dragon":
            return .teal
        case "dark":
            return .black
        case "steel":
            return .gray
        case "fairy":
            return .pink
        default:
            return .gray
        }
    }
}

#Preview {
    PokemonListView()
}
