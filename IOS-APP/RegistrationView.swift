import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
            )
            .foregroundColor(.white)
    }
}

struct RegistrationView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPasswordMismatchAlert = false
    
    private let backgroundImage: String // Image name or URL
    
    init() {
        self.backgroundImage = "Wallpaper" // Set the background image name here
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(backgroundImage) // Use the provided background image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    TextField("", text: $username)
                        .textFieldStyle(CustomTextFieldStyle())
                        .foregroundColor(.white) // Set text color to white
                        .colorScheme(.dark) // Ensure the placeholder color is applied
                        .overlay(
                            Text("Username")
                                .foregroundColor(Color.gray)
                                .opacity(username.isEmpty ? 1 : 0)
                                .alignmentGuide(.leading, computeValue: { _ in
                                    geometry.size.width * 0.1 // Adjust the alignment as needed
                                })
                        )
                        .multilineTextAlignment(.center) // Align entered text centrally
                    
                    SecureField("", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                        .foregroundColor(.white) // Set text color to white
                        .colorScheme(.dark) // Ensure the placeholder color is applied
                        .overlay(
                            Text("Password")
                                .foregroundColor(Color.gray)
                                .opacity(password.isEmpty ? 1 : 0)
                                .alignmentGuide(.leading, computeValue: { _ in
                                    geometry.size.width * 0.1 // Adjust the alignment as needed
                                })
                        )
                        .multilineTextAlignment(.center) // Align entered text centrally
                    
                    SecureField("", text: $confirmPassword)
                        .textFieldStyle(CustomTextFieldStyle())
                        .foregroundColor(.white) // Set text color to white
                        .colorScheme(.dark) // Ensure the placeholder color is applied
                        .overlay(
                            Text("Confirm Password")
                                .foregroundColor(Color.gray)
                                .opacity(confirmPassword.isEmpty ? 1 : 0)
                                .alignmentGuide(.leading, computeValue: { _ in
                                    geometry.size.width * 0.1 // Adjust the alignment as needed
                                })
                        )
                        .multilineTextAlignment(.center) // Align entered text centrally
                    
                    Button(action: {
                        // Check if passwords match
                        if password == confirmPassword {
                            // Passwords match, perform registration
                            print("Registration successful")
                        } else {
                            // Passwords do not match, show an alert
                            showPasswordMismatchAlert = true
                        }
                    }) {
                        Text("Submit")
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
                    .padding()
                }
                .padding()
            }
        }
        .alert(isPresented: $showPasswordMismatchAlert) {
            Alert(
                title: Text("Password Mismatch"),
                message: Text("The passwords entered do not match. Please try again."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

