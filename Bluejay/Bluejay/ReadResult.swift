//
//  ReadResult.swift
//  Bluejay
//
//  Created by Jeremy Chiang on 2017-01-03.
//  Copyright © 2017 Steamclock Software. All rights reserved.
//

import Foundation

/// Indicates a successful, cancelled, or failed read attempt, where the success case contains the value read.
public enum ReadResult<R> {
    /// The read is successful and the value read is captured in the associated value.
    case success(R)
    /// The read has failed unexpectedly with an error.
    case failure(Error)
}

extension ReadResult where R: Receivable {

    /// Create a typed read result from raw data.
    init(dataResult: ReadResult<Data?>) {
        guard case .success(let data) = dataResult, let data else {
            self = .failure(BluejayError.missingData)
            return
        }
        
        do {
            self = .success(try R(bluetoothData: data))
        } catch {
            self = .failure(error)
        }
    }

}
