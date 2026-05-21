//
//  ContentView.swift
//  NotToday Watch App
//
//  Created by Ruslan Pryimak on 5/20/26.
//

import SwiftUI
import WatchKit

struct ContentView: View {

    // База рабочих фраз "поддержки"
    let phrases: [(emoji: String, text: String)] = [
        ("🤡", "Кругом одни идиоты..."),
        ("🤝", "Да они тебе никто!"),
        ("🔥", "Пусть горит, это не твой бизнес."),
        ("🫠", "За такие деньги?"),
        ("📉", "Твоя продуктивность сегодня: 0%"),
        ("🤫", "Кивай и делай по-своему."),
        ("🏃", "Беги оттуда!"),
        ("💸", "Это того не стоит.")
    ]

    @State private var currentPhrase = "Help!"
    @State private var currentEmoji = "🚨"

    @State private var isAlarming = false
    @State private var showAlarmButton = true

    var body: some View {
        VStack(spacing: 12) {
            Group {
                if showAlarmButton {
                    // Кнопка тревоги
                    ZStack {
                        Circle()
                            .fill(isAlarming ? Color.orange : Color.red)
                            .frame(width: 70, height: 70)
                            // Эффект мигания/пульсации масштаба
                            .scaleEffect(isAlarming ? 1.15 : 1.0)
                        
                        Text("🚨")
                            .font(.system(size: 38))
                    }
                    .onTapGesture {
                        triggerAlarm()
                    }
                    
                } else {
                    // Результат (Экран выдачи фразы)
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 70, height: 70)
                        
                        Text(currentEmoji)
                            .font(.system(size: 38))
                    }
                    .onTapGesture {
                        resetAlarm()
                    }
                }
            }

            // Текст фразы
            Text(currentPhrase)
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .minimumScaleFactor(0.7)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 4)
        }
        .padding()
    }

    func triggerAlarm() {
        // Меняем виброотклик на более "тревожный"
        WKInterfaceDevice.current().play(.directionUp)

        // Запускаем быстрое мигание (туда-сюда)
        withAnimation(.easeInOut(duration: 0.1).repeatCount(4, autoreverses: true)) {
            isAlarming = true
        }

        let random = phrases.randomElement()

        // Ждем, пока кнопка "помигает", и выводим фразу
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            currentEmoji = random?.emoji ?? "🤷"
            currentPhrase = random?.text ?? "Кругом одни идиоты..."
            isAlarming = false // сбрасываем стейт мигания

            withAnimation(.spring()) {
                showAlarmButton = false
            }
        }
    }
    
    func resetAlarm() {
        WKInterfaceDevice.current().play(.click)
        
        withAnimation(.easeOut) {
            showAlarmButton = true
        }
        currentPhrase = "Help!"
    }
}

#Preview {
    ContentView()
}
