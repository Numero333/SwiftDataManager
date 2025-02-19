//
//  SwiftDataManager.swift
//  SwiftDataManager
//
//  Created by François-Xavier MEITE on 19/02/2025.
//

import Foundation
import SwiftData

public protocol SwiftDataManagerProtocol {
    associatedtype T: PersistentModel
    
    func addItem(_ item: T) throws
    func fetchItems(predicate: Predicate<T>?, sortDescriptors: [SortDescriptor<T>]) throws -> [T]
    func fetchItem(predicate: Predicate<T>) throws -> T?
    func updateItem(_ item: T, modify: (T) -> Void) throws
    func removeItem(_ item: T) throws
}

public class SwiftDataManager<T: PersistentModel>: SwiftDataManagerProtocol {
    
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    private(set) var isDebugModeEnabled: Bool
    
    public init(debugMode: Bool = false) throws {
        self.isDebugModeEnabled = debugMode
        do {
            self.modelContainer = try ModelContainer(for: T.self)
            self.modelContext = ModelContext(modelContainer)
            log("DataManager initialized successfully.", level: .info)
        } catch {
            throw DataManagerError.initializationFailed
        }
    }

    deinit {
        log("DataManager deinitialized.", level: .info)
    }
    
    // MARK: - addItem
    public func addItem(_ item: T) throws {
        modelContext.insert(item)
        do {
            try modelContext.save()
            log(DataManagerAction.addItem.description, level: .success)
        } catch {
            throw DataManagerError.addItemFailed(error.localizedDescription)
        }
    }

    // MARK: - fetchItems
    public func fetchItems(predicate: Predicate<T>? = nil,
                      sortDescriptors: [SortDescriptor<T>] = []) throws -> [T] {
        do {
            let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortDescriptors)
            let results = try modelContext.fetch(fetchDescriptor)
            log(DataManagerAction.fetchItems.description + " (\(results.count) retrieved)", level: .info)
            return results
        } catch {
            log("Failed to fetch items: \(error.localizedDescription)", level: .error)
            throw DataManagerError.fetchItemsFailed(error.localizedDescription)
        }
    }
    
    // MARK: - fetchItem
    public func fetchItem(predicate: Predicate<T>) throws -> T? {
        let results = try fetchItems(predicate: predicate)
        guard let item = results.first else {
            log("No matching item found.", level: .warning)
            throw DataManagerError.fetchItemFailed("No matching item found.")
        }
        log(DataManagerAction.fetchItem.description, level: .success)
        return item
    }

    // MARK: - updateItem
    public func updateItem(_ item: T, modify: (T) -> Void) throws {
        modify(item)
        do {
            try modelContext.save()
            log(DataManagerAction.updateItem.description, level: .success)
        } catch {
            log("Failed to update item: \(error.localizedDescription)", level: .error)
            throw DataManagerError.updateItemFailed(error.localizedDescription)
        }
    }

    // MARK: - removeItem
    public func removeItem(_ item: T) throws {
        modelContext.delete(item)
        do {
            try modelContext.save()
            log(DataManagerAction.removeItem.description, level: .success)
        } catch {
            log("Failed to delete item: \(error.localizedDescription)", level: .error)
            throw DataManagerError.removeItemFailed(error.localizedDescription)
        }
    }
    
    // MARK: - log
    private func log(_ message: String, level: LogLevel) {
        guard isDebugModeEnabled else { return }
        print(level.prefix + " " + message)
    }
}

// MARK: - LogLevel
public enum LogLevel {
    case info
    case warning
    case error
    case success
    
    var prefix: String {
        switch self {
        case .info: return "ℹ️ INFO:"
        case .warning: return "⚠️ WARNING:"
        case .error: return "❌ ERROR:"
        case .success: return "✅ SUCCESS:"
        }
    }
}

// MARK: - DataManagerAction
public enum DataManagerAction {
    case addItem
    case fetchItems
    case fetchItem
    case updateItem
    case removeItem
    
    var description: String {
        switch self {
        case .addItem: return "Item successfully added."
        case .fetchItems: return "Items successfully retrieved."
        case .fetchItem: return "Single item successfully retrieved."
        case .updateItem: return "Item successfully updated."
        case .removeItem: return "Item successfully deleted."
        }
    }
}

// MARK: - DataManagerError
public enum DataManagerError: Error {
    case initializationFailed
    case addItemFailed(String)
    case fetchItemsFailed(String)
    case fetchItemFailed(String)
    case updateItemFailed(String)
    case removeItemFailed(String)
    
    var description: String {
        switch self {
        case .initializationFailed:
            return "Failed to initialize ModelContainer."
        case .addItemFailed(let reason):
            return "Failed to add item: \(reason)"
        case .fetchItemsFailed(let reason):
            return "Failed to fetch items: \(reason)"
        case .fetchItemFailed(let reason):
            return "Failed to fetch single item: \(reason)"
        case .updateItemFailed(let reason):
            return "Failed to update item: \(reason)"
        case .removeItemFailed(let reason):
            return "Failed to delete item: \(reason)"
        }
    }
}

