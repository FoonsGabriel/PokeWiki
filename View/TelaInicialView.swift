import SwiftUI

struct TelaInicialView: View {

    let tipos = [
        "normal",
        "fire",
        "water",
        "electric",
        "grass",
        "ice",
        "fighting",
        "poison",
        "ground",
        "flying",
        "psychic",
        "bug",
        "rock",
        "ghost",
        "dragon",
        "dark",
        "steel",
        "fairy"
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Pokédex")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Escolha um tipo")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 12
                    ) {

                        ForEach(tipos, id: \.self) { tipo in

                            NavigationLink {
                                TelaCarrosselView(tipo: tipo)
                            } label: {
                                Text(tipo.capitalized)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(typeColor(tipo))
                                    .foregroundStyle(.white)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 12
                                        )
                                    )
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.top)
        }
    }

    private func typeColor(_ type: String) -> Color {

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
    TelaInicialView()
}
