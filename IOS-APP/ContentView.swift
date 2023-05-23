import SwiftUI

struct ContentView: View {
    @State private var isRegistrationScreenPresented = false
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Image("Wallpaper") // Replace "Wallpaper" with your actual image name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width)
                
                VStack {
                    Spacer()
                    
                    Text("AGL")
                        .font(.title)
                        .padding(.top, 50)
                        .bold()
                        .italic()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Discover new games, keep track of the ones you want to play, and connect with friends")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 60)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                        .background(Color.black.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .top)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Button(action: {
                            // Code for Register button action
                            print("Register button tapped")
                            isRegistrationScreenPresented = true
                        }) {
                            Text("Register")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 2/3)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                        .background(Color.black.opacity(0.8))
                                )
                        }
                        .buttonStyle(.plain)
                        .sheet(isPresented: $isRegistrationScreenPresented) {
                            RegistrationView()
                        }
                        
                        Button(action: {
                            // Code for Login button action
                            print("Login button tapped")
                        }) {
                            Text("Login")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 2/3)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                        .background(Color.black.opacity(0.8))
                                )
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Spacer()
                    
                    Spacer()
                }
                .padding(.bottom, geometry.size.height * 0.2) // Adjust the bottom spacing as needed
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

