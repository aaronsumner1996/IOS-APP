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
    @State private var accessToken: String = ""

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
                    Text("Create an account") // Title text
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50) // Adjust top padding as needed
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
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
                            
                            // Make the API request to get the access token
                            let url = URL(string: "http://localhost:8130/users/register")!
                            var request = URLRequest(url: url)
                            request.httpMethod = "POST"
                            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            
                            let jsonBody: [String: Any] = [
                                "username": username,
                                "password": password
                            ]
                            
                            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody) else {
                                print("Error creating JSON data")
                                return
                            }
                            
                            request.httpBody = jsonData
                            
                            URLSession.shared.dataTask(with: request) { data, response, error in
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                    return
                                }
                                
                                // Parse the response and extract the access token
                                if let data = data {
                                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                        if let accessToken = json["access_token"] as? String {
                                            self.accessToken = accessToken
                                            // Use the access token in another API call or store it as needed
                                            print("Access token: \(accessToken)")
                                        }
                                    }
                                }
                            }.resume()
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

