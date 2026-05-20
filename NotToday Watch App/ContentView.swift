//
//  ContentView.swift
//  NotToday Watch App
//
//  Created by Ruslan Pryimak on 5/20/26.
//

import SwiftUI
import WatchKit

struct ContentView: View {

    let phrases: [(emoji: String, text: String)] = [

        ("🙃", "Вот и всё..."),
        ("🙂‍↔️", "Не сегодня..."),
        ("🤡", "Отлично. Просто отлично."),
        ("🫠", "Очень не хочется."),
        ("😵", "С меня хватит."),
        ("🥲", "Пусть оно само."),
        ("🤝", "Не моя проблема..."),
        ("🚬", "Надо подумать... лет пять."),
        ("🪦", "Я пас..."),
        ("🔥", "Да гори оно всё..."),
        ("🚫", "Абсолютно нет..."),
        ("🫥", "Помогите..."),
        ("📉", "Мотивация покинула чат..."),
        ("🐌", "Двигаемся в сторону принятия..."),
        ("🌴", "Нужен перерыв. Лет 30..."),
        ("🌚", "Ой,все.."),
        ("🤷", "Как-нибудь..."),
        ("😩", "Явно не мой день..."),
        ("🧠", "Мозг временно недоступен..."),
        ("😮‍💨", "Ну и ладно...")
    ]

    @State private var currentPhrase = "Нажми на кубик"
    @State private var currentEmoji = "🎲"

    @State private var rotation: Double = 0
    @State private var showDice = true

    var body: some View {

        VStack(spacing: 12) {

            Group {

                if showDice {

                    Text("🎲")
                        .font(.system(size: 52))
                        .rotationEffect(.degrees(rotation))
                        .onTapGesture {
                            rollDice()
                        }

                } else {

                    Text(currentEmoji)
                        .font(.system(size: 52))
                        .onTapGesture {
                            resetDice()
                        }
                }
            }

            Text(currentPhrase)
                .font(.system(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .minimumScaleFactor(0.7)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
        }
        .padding()
    }

    func rollDice() {

        WKInterfaceDevice.current().play(.click)

        withAnimation(.easeInOut(duration: 0.5)) {
            rotation += 360
        }

        let random = phrases.randomElement()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            currentEmoji = random?.emoji ?? "🫠"
            currentPhrase = random?.text ?? "Ну и ладно."

            withAnimation {
                showDice = false
            }
        }
    }
    
    func resetDice() {

        withAnimation {
            showDice = true
        }

        currentPhrase = "Нажми на кубик"
    }
}

#Preview {
    ContentView()
}
