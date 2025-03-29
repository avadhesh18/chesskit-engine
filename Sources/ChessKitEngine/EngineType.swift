//
//  EngineType+.swift
//  ChessKitEngine
//

import ChessKitEngineCore

/// Possible engines available in `ChessKitEngine`.
public enum EngineType: Int {

    case stockfish
    case lc0

    /// Internal mapping from Swift to Obj-C type.
    var objc: EngineType_objc {
        switch self {
        case .stockfish: .stockfish
        case .lc0:       .lc0
        }
    }

    /// The user-readable name of the engine.
    public var name: String {
        switch self {
        case .stockfish: "Stockfish"
        case .lc0:       "LeelaChessZero (Lc0)"
        }
    }

    /// The current version of the given engine.
    public var version: String {
        switch self {
        case .stockfish: "17"
        case .lc0:       "0.31.1"
        }
    }

    /// Engine-specific options to configure at initialization.
    var setupCommands: [EngineCommand] {
        switch self {
        case .stockfish:
            let fileOptions = [
                "EvalFile": "nn-1111cefa1111",
                "EvalFileSmall": "nn-37f18f62d772"
            ].compactMapValues {
                Bundle.main.url(forResource: $0, withExtension: "nnue")?.path(percentEncoded: false)
            }

            return fileOptions.map(EngineCommand.setoption)
        case .lc0:
            let fileOptions = [
                "WeightsFile": "192x15_network"
            ].compactMapValues {
                Bundle.main.url(forResource: $0, withExtension: nil)?.path(percentEncoded: false)
            }

            return fileOptions.map(EngineCommand.setoption)
        }
    }

}

// MARK: - CaseIterable

extension EngineType: CaseIterable {

}

// MARK: - Equatable

extension EngineType: Equatable {

}

// MARK: - Identifiable

extension EngineType: Identifiable {

    public var id: Self { self }

}
