//
//  CalendarView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/25/25.
//

import SwiftUI

struct CalendarView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: [SortDescriptor(\Mood.timestamp)])
//    private var moodLog: FetchedResults<Mood>
    @StateObject var calendarModel = CalendarModel()
    @State var monthId: Month.ID?
    @State var showMonthLabel: Bool = false
    @State var viewInitialized: Bool = false
    

    var body: some View {
        VStack(
            alignment: .center,
            spacing: 0
            
        ) {
            // header
            VStack (
                alignment: .center,
                spacing: 20
            ) {
                // year label
                let displayMonth = calendarModel.monthFromId(monthId)
                Text(verbatim: "\(displayMonth.firstDayOfMonth.year())")
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .font(.system(size: 20))

                
                // weekday label
                HStackWithPadding(leadingPadding: 2, trailingPadding: 2) {
                    let weekdaySymbols = Date.weekdaySymbols()
                    ForEach(0..<weekdaySymbols.count, id: \.self) { i in
                        let symbol = weekdaySymbols[i]
                        Text(symbol)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 16))
                            .padding(.all, 5)
                            .foregroundStyle((i == 0 || i == 6) ? Color.red : Color.black)
                    }
                    
                }

            }
            .frame(height: 80, alignment: .top)
            .padding(.bottom, 5)
            .background(Color(UIColor.systemGray5))
            .overlay(Rectangle()
                .frame(height: 1, alignment: .bottom)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(UIColor.lightGray)), alignment: .bottom)

            // monthly calendar stack
            ZStack(
                alignment: .top
            ) {
                // month label
                if (showMonthLabel) {
                    let displayMonth = calendarModel.monthFromId(monthId)
                    Text(displayMonth.firstDayOfMonth.yearMonthString())
                        .font(.system(size: 20))
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(Color.black)
                        .foregroundStyle(Color.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .transition(.opacity)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .zIndex(2.0)
                }
                
                // scrollable monthly view
                ScrollView {
                    LazyVStack {
                        ForEach(calendarModel.months) { month in
                            MonthView(month: month)
                                .onAppear {
                                    if month == calendarModel.months.last{
                                        print("last visible row")
                                        Task {
                                            await calendarModel.addMonthAfter(5)
                                        }
                                    } else if month ==  calendarModel.months.first {
                                        print("first visible row")
                                        Task {
                                            await calendarModel.addMonthBefore(5)
                                        }
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .scrollPosition(id: $monthId)
                .padding(.vertical, 10)
                .onAppear{ monthId = calendarModel.idForCurrentMonth() }
                .scrollIndicators(.hidden)
                .onChange(of: monthId, initial: false) {
                    if ( !viewInitialized ) {
                        viewInitialized = true
                        return
                    }
                    showMonthLabel = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.smooth) {
                            showMonthLabel = false
                        }
                    }
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            
            // footer
            HStack {
                Button("TODAY") {
                    withAnimation(.default) {
                        monthId = calendarModel.idForCurrentMonth()
                    }
                }
                .foregroundStyle(Color.red)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color(UIColor.systemGray5))
            .overlay(Rectangle()
                .frame(height: 1, alignment: .top)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(UIColor.lightGray)), alignment: .top)
            
            
        }
//        .onAppear {
//            calendarModel.getMonths(moodLog: moodLog)
//        }
    }
}

struct HStackWithPadding<Content>: View where Content: View  {
    var leadingPadding: CGFloat?
    var trailingPadding: CGFloat?

    @ViewBuilder var content: Content
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
                .frame(width: leadingPadding ?? 0, height: 10, alignment: .center)
            
            content
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
                .frame(width: trailingPadding ?? 0, height: 10, alignment: .center)

        }
        
    }
}

#Preview {
    CalendarView()
}
