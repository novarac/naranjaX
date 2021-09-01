import Foundation

class APIEnvironment: EnvironmentDelegate {
    
    func getBaseUrl() -> String {
        // Intentional forced unwrap. If there's no API endpoint in hte plist crash it's fine
        return Bundle.main.object(forInfoDictionaryKey: Constants.Plist.baseUrlKey) as? String ?? ""
    }
}
