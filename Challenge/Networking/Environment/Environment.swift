import Foundation

protocol EnvironmentDelegate: AnyObject {
    func path(_ endpoint: String) -> String
    func getBaseUrl() -> String
}

extension EnvironmentDelegate {
    
    func path(_ endpoint: String) -> String {
        return getBaseUrl() + endpoint
    }
}
