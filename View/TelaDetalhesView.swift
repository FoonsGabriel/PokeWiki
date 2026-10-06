import SwiftUI

struct TelaDetalhesView: View {

    let pokemon: Pokemon

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                Text("#\(pokemon.id)")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                AnimatedImage(
                    url: URL(
                        string:
                            pokemon.sprites.animated?.frontDefault
                            ?? pokemon.sprites.frontDefault
                            ?? ""
                    )
                )
                .frame(height: 250)

                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                HStack {

                    ForEach(
                        pokemon.types,
                        id: \.type.name
                    ) { type in

                        Text(type.type.name.capitalized)
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                    }
                }

                VStack(spacing: 15) {

                    Text("Informações")
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {

                        VStack {
                            Text("Altura")
                                .foregroundStyle(.secondary)

                            Text("\(pokemon.height / 10).\(pokemon.height % 10) m")
                                .fontWeight(.bold)
                        }

                        Spacer()

                        VStack {
                            Text("Peso")
                                .foregroundStyle(.secondary)

                            Text("\(Double(pokemon.weight) / 10, specifier: "%.1f") kg")
                                .fontWeight(.bold)
                        }
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Habilidades")
                            .font(.headline)

                        ForEach(
                            pokemon.abilities,
                            id: \.ability.name
                        ) { ability in

                            Text("• \(ability.ability.name.capitalized)")
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
                .padding()
                .background(.white)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 16
                    )
                )
            }
            .padding()
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TelaDetalhesView(
            pokemon: Pokemon(
                id: 25,
                name: "pikachu",
                height: 4,
                weight: 60,
                types: [],
                abilities: [],
                sprites: PokemonSprites(
                    frontDefault: nil,
                    animated: nil
                )
            )
        )
    }
}
