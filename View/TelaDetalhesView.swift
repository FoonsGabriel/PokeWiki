import SwiftUI

struct TelaDetalhesView: View {

    let pokemon: Pokemon

    private var mainType: String {
        pokemon.types.first?.type.name ?? "normal"
    }

    var body: some View {

        ZStack {

            PokemonTypeBackground(
                type: mainType
            )

            ScrollView {

                VStack(spacing: 18) {

                    HStack {

                        Text("POKÉDEX")
                            .font(
                                .system(
                                    size: 28,
                                    weight: .black
                                )
                            )
                            .foregroundStyle(.white)

                        Spacer()

                        Text(
                            "#\(String(format: "%03d", pokemon.id))"
                        )
                        .font(
                            .system(
                                size: 18,
                                weight: .black,
                                design: .monospaced
                            )
                        )
                        .foregroundStyle(.white)
                    }

                    ZStack {

                        RoundedRectangle(
                            cornerRadius: 28
                        )
                        .fill(.white)
                        .frame(height: 350)
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 28
                            )
                            .stroke(
                                .black,
                                lineWidth: 5
                            )
                        )

                        VStack {

                            Text(
                                "#\(String(format: "%03d", pokemon.id))"
                            )
                            .font(
                                .system(
                                    size: 14,
                                    weight: .black,
                                    design: .monospaced
                                )
                            )
                            .foregroundStyle(.secondary)

                            AnimatedImage(
                                url: URL(
                                    string:
                                        pokemon.sprites.animated?.frontDefault
                                        ?? pokemon.sprites.frontDefault
                                        ?? ""
                                )
                            )
                            .frame(
                                width: 320,
                                height: 290
                            )
                        }
                    }

                    VStack(spacing: 14) {

                        Text(
                            pokemon.name.uppercased()
                        )
                        .font(
                            .system(
                                size: 34,
                                weight: .black,
                                design: .rounded
                            )
                        )

                        HStack {

                            ForEach(
                                pokemon.types,
                                id: \.type.name
                            ) { type in

                                Text(
                                    type.type.name.uppercased()
                                )
                                .font(
                                    .system(
                                        size: 12,
                                        weight: .black
                                    )
                                )
                                .padding(
                                    .horizontal,
                                    15
                                )
                                .padding(
                                    .vertical,
                                    7
                                )
                                .background(
                                    typeColor(
                                        type.type.name
                                    )
                                )
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .stroke(
                            .black,
                            lineWidth: 4
                        )
                    )

                    VStack(spacing: 0) {

                        Text("DADOS DO POKÉMON")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .black
                                )
                            )
                            .foregroundStyle(.white)
                            .frame(
                                maxWidth: .infinity
                            )
                            .padding()
                            .background(.black)

                        HStack {

                            detailItem(
                                title: "ALTURA",
                                value: String(
                                    format: "%.1f m",
                                    Double(
                                        pokemon.height
                                    ) / 10
                                )
                            )

                            Divider()
                                .frame(height: 55)

                            detailItem(
                                title: "PESO",
                                value: String(
                                    format: "%.1f kg",
                                    Double(
                                        pokemon.weight
                                    ) / 10
                                )
                            )
                        }
                        .padding()
                        .background(.white)
                    }
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                        .stroke(
                            .black,
                            lineWidth: 4
                        )
                    )

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        Text("HABILIDADES")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .black
                                )
                            )

                        ForEach(
                            pokemon.abilities,
                            id: \.ability.name
                        ) { ability in

                            HStack {

                                Circle()
                                    .fill(
                                        typeColor(
                                            mainType
                                        )
                                    )
                                    .frame(
                                        width: 10,
                                        height: 10
                                    )

                                Text(
                                    ability.ability.name
                                        .replacingOccurrences(
                                            of: "-",
                                            with: " "
                                        )
                                        .capitalized
                                )
                                .font(.headline)
                            }
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding()
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                        .stroke(
                            .black,
                            lineWidth: 4
                        )
                    )
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .toolbarColorScheme(
            .dark,
            for: .navigationBar
        )
        .navigationTitle("")
    }

    private func detailItem(
        title: String,
        value: String
    ) -> some View {

        VStack(spacing: 5) {

            Text(title)
                .font(
                    .system(
                        size: 11,
                        weight: .bold
                    )
                )
                .foregroundStyle(.secondary)

            Text(value)
                .font(
                    .system(
                        size: 18,
                        weight: .black
                    )
                )
        }
        .frame(maxWidth: .infinity)
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
