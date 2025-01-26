//

//  MeditationView.swift

//  Better Gator

//

//  Created by Nannapaneni, Shalini on 1/25/25.

//



import Foundation

import SwiftUI



struct MeditationView: View {

    

    @State var isCenter = true

    @State var isCenter2 = true

    @State var isClicked = false;

    @State var isExpanded = true;

    var body: some View{

        VStack {

            ZStack(alignment: .leading){

                HStack {

                    VStack(alignment: .leading) {

                        Text("Let's Meditate")

                            .font(.title2)

                            .frame(maxWidth: .infinity, alignment: .center)

                        Text(isClicked ? "Click to Finish": "Click to Start")

                            .font(.subheadline)

                            .frame(maxWidth: .infinity, alignment: .center)

                    }

                }

                Spacer()

            }


            ZStack{

                Circle()

                    .frame(width: 100, height: 100)

                    .foregroundColor(Color.green.opacity(0.2))

                    .offset(x: isCenter ? 0: 50)

                    .rotationEffect(Angle(degrees: isCenter2 ? 0: 360))

                Circle()

                    .frame(width: 100, height: 100)

                    .foregroundColor(Color.green.opacity(0.2))

                    .offset(x: isCenter ? 0: -50)

                    .rotationEffect(Angle(degrees: isCenter2 ? 0: 360))

                Circle()

                    .frame(width: 100, height: 100)

                    .foregroundColor(Color.green.opacity(0.2))

                    .offset(y: isCenter ? 0: 50)

                    .rotationEffect(Angle(degrees: isCenter2 ? 0: 360))

                Circle()

                    .frame(width: 100, height: 100)

                    .foregroundColor(Color.green.opacity(0.2))

                    .offset(y: isCenter ? 0: -50)

                    .rotationEffect(Angle(degrees: isCenter2 ? 0: 360))

                Spacer()

            }

            .onTapGesture(){

                isClicked.toggle()

                if isClicked{

                    let animation = Animation.linear(duration: 4)

                    withAnimation(animation.repeatForever(autoreverses: true)){

                        self.isCenter = false

                        self.isCenter2 = false

                    }

                    startBreathing()

                }

                else{

                    withAnimation{

                        self.isCenter = true

                        self.isCenter2 = true

                    }

                }

            }

            .padding(100)

           if isClicked{

               Text(isExpanded ? "Breathe In": "Breathe Out")

                   .font(.title3)

                   .animation(.easeInOut, value: isExpanded)

           }

        }

    }

   private func startBreathing(){

       Timer.scheduledTimer(withTimeInterval: 4, repeats: true){timer in

           if !isClicked{

               timer.invalidate()

           }

           else{

               isExpanded.toggle()

           }

       }

   } 

}


#Preview {
    MeditationView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
