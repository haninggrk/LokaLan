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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct LokalanWidgetView: View {
    //    var word: Word?
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            widget_lokalanSmallView()
        case .systemMedium:
            widget_lokalanMediumView()
        @unknown default:
            EmptyView()
        }
    }
}

struct widget_lokalanSmallView : View {
    var body: some View {
        VStack {
            HStack {
                Text("Tetek Bengek")
                    .bold()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 2)
                Spacer()
            }
            
            HStack {
                Text("Semuanya (Dengan segala keribetan nya)")
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
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Tetek Bengek")
                        .bold()
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom, 2)
                    Spacer()
                }
                
                HStack {
                    Text("Semuanya (Dengan segala keribetan nya)")
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
            LokalanWidgetView()
        }
        .configurationDisplayName("Word Lokalan")
        .description("Tampilkan kata yang ingin diingat.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct widget_lokalan_Previews: PreviewProvider {
    static var previews: some View {
        LokalanWidgetView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

