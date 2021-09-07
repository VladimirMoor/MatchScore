//
//  CurrentMatchView.swift
//  CurrentMatchView
//
//  Created by Владимир Муравьев on 29.08.2021.
//

import SwiftUI
import CoreData



struct CurrentMatchView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var match: Match
    @State private var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var firstHalfTimer = 0
    @State private var firstHalfAddTimer = 0
    @State private var secondHalfTimer = 0
    @State private var secondHalfAddTimer = 0
    
    @State private var isShowNewEventSheet = false
    
    @State private var isFirstHalfGoing = false
    @State private var isSecondHalfGoing = false
    @State private var isBreak = false
    @State private var breakCounter = 0
    @State private var matchIsOver = false
    @State private var secondHalfCounter = 0
    
    @State private var newEvent: Event = Event()
    @State private var choosedTeam: Team = Team()
    @State private var newGameTime = GameTimer()
    
    @State private var isHomeTeamEvent = true
    @State private var to: CGFloat = 0
    @State private var isStopMatchActionSheetShow = false
    
    
    var homeTeamGoals: Int {
        if let events = match.events?.allObjects as? [Event] {
            return events.filter { ($0.type == "Goal") && ($0.team == match.homeTeam) }.count
        } else { return 0 }
    }
    
    var visitTeamGoals: Int {
        if let events = match.events?.allObjects as? [Event] {
            return events.filter { ($0.type == "Goal") && ($0.team == match.visitTeam) }.count
        } else { return 0 }
    }

    
    var body: some View {

        VStack {
            
            Spacer(minLength: 50)
            
            HStack {
                Spacer()
                
                if matchIsOver {
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .padding(.trailing, 30)
                    .scaleEffect(1.5)

                    
                } else {
                    Button {
                        isStopMatchActionSheetShow = true
                    } label: {
                        Image(systemName: "stop.circle")
                    }
                    .padding(.trailing, 30)
                    .scaleEffect(1.5)
                    }
                }
            
            
            Spacer()
                        
            HStack {
            
            Text(match.homeTeam?.name ?? "")
                .padding()
                .frame(maxWidth: .infinity)
                
                ZStack(alignment: .circleAndText) {
                    
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 7))
                    .frame(width: 150, height: 150)
                    .alignmentGuide(Alignment.circleAndText.vertical) { d in
                        d[VerticalAlignment.center]
                    }

                Circle()
                    .trim(from: 0, to: to)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 7, lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(Angle(degrees: -90))
                    
                
                VStack {
                    
                    if isFirstHalfGoing && firstHalfAddTimer > 0 {
                        Text("+" + Event.secondsToString(firstHalfAddTimer))
                            .font(.caption)
                            

                    } else if secondHalfAddTimer > 0 {
                        Text("+" + Event.secondsToString(secondHalfAddTimer))
                            .font(.caption)

                    } else {
                        EmptyView()
                     }
                    
                    Text(Event.secondsToString(secondHalfTimer > 0 ? secondHalfTimer : firstHalfTimer))
                    
                    Text("\(homeTeamGoals) : \(visitTeamGoals)")
                        .font(.largeTitle)
                        .bold()
                        .alignmentGuide(Alignment.circleAndText.vertical) { d in
                            d[VerticalAlignment.center]
                        }


                    switch(isFirstHalfGoing, isBreak, isSecondHalfGoing, matchIsOver) {
                    case(false, false, false, false): Text("coin toss")
                    case(true, false, false, false): Text("1st half")
                    case(false, true, false, false): Text("break")
                    case(false, false, true, false): Text("2nd half")
                    case(false, false, false, true): Text("match is over")
                    default: EmptyView()
                    }
                }
                
             }

            Text(match.visitTeam?.name ?? "")
                .padding()
                .frame(maxWidth: .infinity)
        }
 
            
            
            HStack {

            Button {

                newGameTime = GameTimer(context: moc)
                newGameTime.firstHalfTimer = Int16(firstHalfTimer)
                newGameTime.firstHalfExtraTimer = Int16(firstHalfAddTimer)
                newGameTime.secondHalfTimer = Int16(secondHalfTimer)
                newGameTime.secondHalfExtraTimer = Int16(secondHalfAddTimer)

                isHomeTeamEvent = true
                isShowNewEventSheet = true

            } label: {
                Image(systemName: "plus.circle")
                    .scaleEffect(3)
                    .frame(maxWidth: .infinity)
                
            }
            .disabled(!(isFirstHalfGoing || isSecondHalfGoing))

                
                Button {
                    
                    if firstHalfAddTimer > 0 {
                        isFirstHalfGoing = false
                        
                        if breakCounter > 0 {
                            isBreak = false
                            
                            if secondHalfAddTimer > 0 {
                                isSecondHalfGoing = false
                                matchIsOver = true
                                
                                try? moc.save()
                                
                            } else {
                                isSecondHalfGoing = true
                            }

                        } else {
                            isBreak = true
                        }

                    } else {
                        isFirstHalfGoing = true
                    }
                    
                } label: {
                        HStack {
                            
                            if !matchIsOver {
                            switch(isFirstHalfGoing, isSecondHalfGoing, isBreak) {
                            case (false, false, false): Text("Start first half")
                            case (true, false, false): Text("Stop first half")
                            case(false, false, true): Text("Start second half")
                            case(false, true, false): Text("Stop second half")
                            default: EmptyView()
                            }
                            } else {
                                Text("Match is over")
                            }
                        }
                        .frame(minWidth: 200)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .stroke(lineWidth: 1)
                        )
                    }
                    
                .disabled( (firstHalfTimer > 0 && firstHalfAddTimer == 0) || (secondHalfTimer > 0 && secondHalfAddTimer == 0) || matchIsOver )
                    
                    
                
            Button {
                
                newGameTime = GameTimer(context: moc)
                newGameTime.firstHalfTimer = Int16(firstHalfTimer)
                newGameTime.firstHalfExtraTimer = Int16(firstHalfAddTimer)
                newGameTime.secondHalfTimer = Int16(secondHalfTimer)
                newGameTime.secondHalfExtraTimer = Int16(secondHalfAddTimer)

                isHomeTeamEvent = false
                isShowNewEventSheet = true

            } label: {
                Image(systemName: "plus.circle")
                    .scaleEffect(3)
                    .frame(maxWidth: .infinity)
            }
            .disabled(!(isFirstHalfGoing || isSecondHalfGoing))
    
         }
         .padding()
           
            EventsList(match: match)
                .sheet(isPresented: $isShowNewEventSheet) {
                    NewEventSheet(match: match, moment: newGameTime, isHomeTeamEvent: isHomeTeamEvent )
                   }

            
     }
        .navigationBarHidden(true)
        .onReceive(time) { _ in

            to = CGFloat((secondHalfTimer == 0 ? firstHalfTimer : 0) + secondHalfTimer) / CGFloat(match.oneHalfDuration * 120)
            
            if isFirstHalfGoing == true {
                
                if firstHalfTimer < match.oneHalfDuration * 60 {
                    firstHalfTimer += 1
                    
                } else {
                    firstHalfAddTimer += 1
                }

            } else {
                
                if isSecondHalfGoing {
                    secondHalfCounter += 1
                    if secondHalfTimer < match.oneHalfDuration * 2 * 60 {
                    secondHalfTimer = Int(match.oneHalfDuration * 60) + secondHalfCounter
                    } else {
                        secondHalfAddTimer += 1
                    }
                }
            }
            
            if isBreak {
                breakCounter += 1
            }
        }
        .actionSheet(isPresented: $isStopMatchActionSheetShow) {
            ActionSheet(title: Text("Stop the match?"), message: Text("Do you want to stop current match?"), buttons: [
            
                .destructive(Text("Stop and delete match"), action: {
                    moc.delete(match)
                    try? moc.save()
                    presentationMode.wrappedValue.dismiss()
                    
                }),
                .default(Text("Stop and restart match"), action: {
                    
                    firstHalfTimer = 0
                    firstHalfAddTimer = 0
                    secondHalfTimer = 0
                    secondHalfAddTimer = 0
                    
                    isFirstHalfGoing = false
                    isSecondHalfGoing = false
                    isBreak = false
                    breakCounter = 0
                    secondHalfCounter = 0
                    matchIsOver = false
                    to = 0
                    
                    
                    match.events?.forEach { event in
                        moc.delete(event as! Event)
                    }
                    
                    try? moc.save()
                }),
                .cancel(Text("Cancel"))

            ])
        }
        
    }

}

extension Alignment {

    struct HA: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    struct VA: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    struct CircleAndText: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let circleAndText = Alignment(horizontal: HorizontalAlignment(HA.self), vertical: VerticalAlignment(VA.self))
}
