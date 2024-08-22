//
//  ContentView.swift
//  TinderSwipes
//
//  Created by daryl on 20/8/24.
//

import SwiftUI

struct ContentView: View {
   
   private var people: [String] = ["Daisy", "Emma", "Julie", "Sally", "Carol"].reversed()
   
    var body: some View {
        VStack {
           ZStack {
              ForEach(people, id: \.self) { person in
                 CardView(person: person)
              }
           }
        }
        .padding()
    }
}

struct CardView: View {
   
   var person: String
   @State private var offset = CGSize.zero
   @State private var color: Color = .black
   
   var body: some View {
      ZStack {
         Rectangle()
            .frame(width: 320, height: 420)
            .border(.blue, width: 6.0)
            .cornerRadius(24)
            .foregroundColor(color.opacity(0.8))
            .shadow(radius: 4)
         HStack {
            Text(person)
               .font(.largeTitle)
               .foregroundStyle(.white)
               .bold()
            Image(systemName: "heart.fill")
               .font(.largeTitle)
               .foregroundColor(.red)
         }
      }
      .offset(x: offset.width, y: offset.height * 0.4)
      .rotationEffect(.degrees(Double(offset.width / 40)))
      .gesture(
         DragGesture()
            .onChanged({ gesture in
               offset = gesture.translation
               withAnimation {
                  changeColor(width: offset.width)
               }
            })
            .onEnded({ _ in
               withAnimation {
                  swipeCard(width: offset.width)
                  changeColor(width: offset.width)
               }
            })
      )
   }
   
   func swipeCard(width: CGFloat) {
      switch width {
         
      case -500...(-150):
         print("\(person) removed")
         offset = CGSize(width: -500, height: 0)
         
      case 150...(500):
         print("\(person) added")
         offset = CGSize(width: 500, height: 0)
         
      default:
         offset = .zero
      }
   }
   
   func changeColor(width: CGFloat) {
      
      switch width {
         
      case -500...(-130):
         print("\(person) removed")
         color = .red
         
      case 130...(500):
         print("\(person) added")
         color = .green
         
      default:
         color = .black
      }
         
   }
   
}

#Preview {
    ContentView()
}
