import SwiftUI

struct PokemonTypeBackground: View {

    let type: String

    var body: some View {

        ZStack {

            LinearGradient(
                colors: backgroundColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(.white.opacity(0.08))
                .frame(width: 280)
                .offset(x: 130, y: -220)

            Circle()
                .fill(.black.opacity(0.08))
                .frame(width: 350)
                .offset(x: -150, y: 300)

            VStack {

                Spacer()

                HStack {

                    Text(type.uppercased())
                        .font(
                            .system(
                                size: 70,
                                weight: .black,
                                design: .rounded
                            )
                        )
                        .foregroundStyle(.white.opacity(0.12))

                    Spacer()
                }
                .padding(.leading, -10)

                Spacer()
            }
        }
        .ignoresSafeArea()
    }

    private var backgroundColors: [Color] {

        switch type {

        case "normal":
            return [
                Color.gray,
                Color.gray.opacity(0.55)
            ]

        case "fire":
            return [
                Color.red,
                Color.orange
            ]

        case "water":
            return [
                Color.blue,
                Color.cyan
            ]

        case "electric":
            return [
                Color.yellow,
                Color.orange
            ]

        case "grass":
            return [
                Color.green,
                Color.mint
            ]

        case "ice":
            return [
                Color.cyan,
                Color.blue.opacity(0.5)
            ]

        case "fighting":
            return [
                Color.orange,
                Color.red
            ]

        case "poison":
            return [
                Color.purple,
                Color.pink
            ]

        case "ground":
            return [
                Color.brown,
                Color.orange.opacity(0.6)
            ]

        case "flying":
            return [
                Color.blue,
                Color.indigo
            ]

        case "psychic":
            return [
                Color.pink,
                Color.purple
            ]

        case "bug":
            return [
                Color.green,
                Color.yellow
            ]

        case "rock":
            return [
                Color.brown,
                Color.gray
            ]

        case "ghost":
            return [
                Color.indigo,
                Color.purple
            ]

        case "dragon":
            return [
                Color.indigo,
                Color.teal
            ]

        case "dark":
            return [
                Color.black,
                Color.gray
            ]

        case "steel":
            return [
                Color.gray,
                Color.blue
            ]

        case "fairy":
            return [
                Color.pink,
                Color.purple.opacity(0.5)
            ]

        default:
            return [
                Color.red,
                Color.orange
            ]
        }
    }
}
