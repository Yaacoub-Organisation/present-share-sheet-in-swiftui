import PlaygroundSupport
import SwiftUI



//MARK:- View

struct ContentView: View {
    
  @State private var isPresentingShareSheet = false
    
    var body: some View {
        Button("Present Share Sheet") { isPresentingShareSheet = true }
        .shareSheet(isPresented: $isPresentingShareSheet, items: ["Share me!"])
  }
    
}



//MARK:- Extensions

extension UIApplication {
    
    static let keyWindow = keyWindowScene?.windows.filter(\.isKeyWindow).first
    static let keyWindowScene = shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    
}

extension View {
    
    func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {
        guard isPresented.wrappedValue else { return self }
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in isPresented.wrappedValue = false }
        guard let presentedViewController = UIApplication.keyWindow?.rootViewController?.presentedViewController else {
            print("The presented view controller is not available through the Playground")
            return self
        }
        presentedViewController.present(activityViewController, animated: true)
        return self
    }
    
}



//MARK:- Live View

PlaygroundPage.current.setLiveView(ContentView().frame(width: 400, height: 400))
