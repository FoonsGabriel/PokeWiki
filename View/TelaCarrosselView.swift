import SwiftUI

struct TelaCarrosselView: View {

    let tipo: String

    @State private var viewModel = PokemonViewModel()

    var body: some View {

        ZStack {

            PokemonTypeBackground(type: tipo)

            VStack(spacing: 0) {

                HStack {

                    VStack(alignment: .leading, spacing: 3) {

                        Text("POKÉDEX")
                            .font(
                                .system(
                                    size: 30,
                                    weight: .black
                                )
                            )
                            .foregroundStyle(.white)

                        Text(
                            "POKÉMON DO TIPO \(tipo.uppercased())"
                        )
                        .font(
                            .system(
                                size: 12,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(.white.opacity(0.8))
                    }

                    Spacer()

                    VStack(spacing: 5) {

                        Circle()
                            .fill(.red)
                            .frame(width: 28, height: 28)
                            .overlay(
                                Circle()
                                    .stroke(.white, lineWidth: 3)
                            )

                        HStack(spacing: 4) {

                            Circle()
                                .fill(.yellow)
                                .frame(width: 7, height: 7)

                            Circle()
                                .fill(.green)
                                .frame(width: 7, height: 7)

                            Circle()
                                .fill(.blue)
                                .frame(width: 7, height: 7)
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 10)
                .padding(.bottom, 15)

                if viewModel.isLoading {

                    Spacer()

                    VStack(spacing: 20) {

                        ProgressView()
                            .controlSize(.large)
                            .tint(.white)

                        Text("PROCURANDO POKÉMON...")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }

                    Spacer()

                } else if let error = viewModel.errorMessage {

                    Spacer()

                    VStack(spacing: 16) {

                        Image(
                            systemName:
                                "exclamationmark.triangle.fill"
                        )
                        .font(.largeTitle)
                        .foregroundStyle(.white)

                        Text(error)
                            .foregroundStyle(.white)

                        Button("Tentar novamente") {
                            Task {
                                await viewModel.fetchPokemons(
                                    type: tipo
                                )
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    Spacer()

                } else {

                    Spacer()

                    ScrollView(.horizontal) {

                        LazyHStack(spacing: 24) {

                            ForEach(viewModel.pokemons) { pokemon in

                                NavigationLink {

                                    TelaDetalhesView(
                                        pokemon: pokemon
                                    )

                                } label: {

                                    PokemonCardView(
                                        pokemon: pokemon,
                                        type: tipo
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .scrollIndicators(.hidden)

                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(false)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            await viewModel.fetchPokemons(type: tipo)
        }
    }
}

struct PokemonCardView: View {

    let pokemon: Pokemon
    let type: String

    var body: some View {

        VStack(spacing: 0) {

            HStack {

                Text(
                    "Nº \(String(format: "%03d", pokemon.id))"
                )
                .font(
                    .system(
                        size: 15,
                        weight: .black,
                        design: .monospaced
                    )
                )

                Spacer()

                Circle()
                    .fill(.red)
                    .frame(width: 14, height: 14)
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
            }
            .padding(.horizontal, 18)
            .padding(.top, 15)

            ZStack {

                Circle()
                    .fill(.black.opacity(0.05))
                    .frame(width: 275, height: 275)

                Circle()
                    .stroke(
                        .black.opacity(0.1),
                        lineWidth: 3
                    )
                    .frame(width: 275, height: 275)

                AnimatedImage(
                    url: URL(
                        string:
                            pokemon.sprites.animated?.frontDefault
                            ?? pokemon.sprites.frontDefault
                            ?? ""
                    )
                )
                .frame(
                    width: 270,
                    height: 270
                )
            }

            Spacer()

            Text(pokemon.name.uppercased())
                .font(
                    .system(
                        size: 26,
                        weight: .black,
                        design: .rounded
                    )
                )

            HStack(spacing: 8) {

                ForEach(
                    pokemon.types,
                    id: \.type.name
                ) { pokemonType in

                    Text(
                        pokemonType.type.name.uppercased()
                    )
                    .font(
                        .system(
                            size: 10,
                            weight: .black
                        )
                    )
                    .padding(
                        .horizontal,
                        12
                    )
                    .padding(
                        .vertical,
                        6
                    )
                    .background(
                        typeColor(
                            pokemonType.type.name
                        )
                    )
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                }
            }

            Spacer()

            HStack {

                Text("VER DETALHES")

                Image(
                    systemName:
                        "chevron.right"
                )
            }
            .font(
                .system(
                    size: 12,
                    weight: .black
                )
            )
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(.black)
        }
        .frame(
            width: 320,
            height: 500
        )
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 26
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: 26
            )
            .stroke(
                .black,
                lineWidth: 5
            )
        )
        .shadow(
            color: .black.opacity(0.35),
            radius: 12,
            y: 8
        )
    }

    private func typeColor(
        _ type: String
    ) -> Color {

        switch type {

        case "normal":
            return .gray

        case "fire":
            return .red

        case "water":
            return .blue

        case "electric":
            return .yellow

        case "grass":
            return .green

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

        case "psychic":
            return .pink

        case "bug":
            return .mint

        case "rock":
            return .gray

        case "ghost":
            return .purple

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

    NavigationStack {

        TelaCarrosselView(
            tipo: "fire"
        )
    }
}
