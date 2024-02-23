import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Image("logoHeaven")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50)

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Start") {
                    // Aquí deberías añadir tu lógica de autenticación
                    self.isAuthenticated = true
                }
                .padding()
                .background(NavigationLink(destination: MapViewControllerRepresentable(), isActive: $isAuthenticated) { EmptyView() }.hidden())
            }
            .navigationTitle("HavenConnect")
        }
    }
}

