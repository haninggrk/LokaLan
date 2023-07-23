//
//  widget_lokalan.swift
//  widget_lokalan
//
//  Created by Andreas Lim on 08/07/23.
//

import WidgetKit
import SwiftUI
import Intents
import Foundation

struct Provider: IntentTimelineProvider {
    @AppStorage("language", store: UserDefaults(suiteName: "group.cobaWidget"))
    var language: SupportedWords = SupportedWords.Surabaya
    
    func placeholder(in context: Context) -> WordEntry {
        WordEntry(date: Date(), word: WidgetWord(name: "Kon", meaning: "Kamu"), language: .Surabaya, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WordEntry) -> ()) {
        let entry = WordEntry(date: Date(), word: WidgetWord(name: "Kon", meaning: "kamu"), language: .Surabaya, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WordEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        // Get Random Word
        let lang = Surabaya()
        let randWord = lang.getRandom()
        
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WordEntry(date: entryDate, word: randWord, language: language, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WordEntry: TimelineEntry {
    let date: Date
    let word: WidgetWord
    let language: SupportedWords
    let configuration: ConfigurationIntent
}

struct LokalanWidgetView: View {
    let word: WidgetWord
    let date: Date
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            widget_lokalanSmallView(word: WidgetWord(name: word.name, meaning: word.meaning), date: Date())
        case .systemMedium:
            widget_lokalanMediumView(word: WidgetWord(name: word.name, meaning: word.meaning), date: Date())
        @unknown default:
            EmptyView()
        }
    }
}

struct widget_lokalanSmallView : View {
    let word: WidgetWord
    let date: Date
    
    var body: some View {
        VStack {
            HStack {
                Text(word.name)
                    .bold()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 2)
                Spacer()
            }
            
            HStack {
                Text(word.meaning)
                    .foregroundColor(.white)
                    .font(.footnote)
                Spacer()
            }
            
            HStack {
                Spacer()
                ZStack{
                    HStack{
                        
                    }
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(.white)
                    .opacity(0.2)
                    .cornerRadius(15)
                    
                    Link(destination: URL(string: "game:///link1")!, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    })
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
        .widgetURL(URL(string: "game:///link1")!)
    }
}

struct widget_lokalanMediumView : View {
    let word: WidgetWord
    let date: Date
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(word.name)
                        .bold()
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom, 2)
                    Spacer()
                }
                
                HStack {
                    Text(word.meaning)
                        .foregroundColor(.white)
                        .font(.footnote)
                    Spacer()
                }
                
                Spacer()
            }
            .multilineTextAlignment(.leading)
            VStack {
                ZStack{
                    HStack{
                        
                    }
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(.white)
                    .opacity(0.2)
                    .cornerRadius(15)
                    
                    Link(destination: URL(string: "game:///link1")!, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    })
                }
                ZStack{
                    HStack{
                        
                    }
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(.white)
                    .opacity(0.2)
                    .cornerRadius(15)
                    
                    Link(destination: URL(string: "game:///link2")!, label: {
                        Image(systemName: "speaker.wave.2.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    })
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
    }
}

struct widget_lokalan: Widget {
    let kind: String = "widget_lokalan"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            LokalanWidgetView(word: entry.word, date: entry.date)
        }
        .configurationDisplayName("Pilih Tampilan")
        .description("Pilih tampilan kata yang ingin diingat.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct widget_lokalan_Previews: PreviewProvider {
    static var previews: some View {
        LokalanWidgetView(word: WidgetWord(name: "Tetek Bengek", meaning: "Semuanya"), date: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

