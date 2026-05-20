//
//  ContentView.swift
//  NotToday Watch App
//
//  Created by Ruslan Pryimak on 5/20/26.
//

import SwiftUI
import WatchKit

struct ContentView: View {

    let phrases = [
        "Не сегодня.",
        "Пусть оно само.",
        "Ну и ладно.",
        "Потом.",
        "Очень не хочется.",
        "Не мои проблемы.",
        "Абсолютно нет.",
        "Я пас.",
        "Оставим это будущему мне.",
        "Как-нибудь."
    ]

    @State private var currentPhrase = "Нажми на кубик"

    @State private var rotation: Double = 0

    var body: some View {

        VStack(spacing: 20) {

            Text("🎲")
                .font(.system(size: 60))
                .rotationEffect(.degrees(rotation))
                .onTapGesture {
                    rollDice()
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

        currentPhrase = phrases.randomElement() ?? "Ну и ладно."
    }
}

#Preview {
    ContentView()
}
