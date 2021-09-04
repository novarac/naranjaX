import UIKit

class ManagerFilters {

    func storeFilters(filters: FilterModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(filters) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedFilters")
        }
    }
    
    func loadFilters() -> FilterModel? {
        let defaults = UserDefaults.standard
        if let savedFilters = defaults.object(forKey: "SavedFilters") as? Data {
            let decoder = JSONDecoder()
            if let loadedFilters = try? decoder.decode(FilterModel.self, from: savedFilters) {
                return loadedFilters
            }
        }
        return nil
    }
}
