//
//  ReminderRepositoryTest.swift
//  RewindTests
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

import XCTest
@testable import Rewind
import Nimble
import Quick
import Foundation

class ReminderRepositoryTest: QuickSpec {
    
    private let repository = ReminderRepository()
    
    override func spec() {
        beforeEach {
            
        }
        
        describe("Save Method") {
            context("When the Object is Valid") {
                let reminder = Reminder(title: "Teste", time: Date())
                let result = self.repository.save(reminder)
                it("Should Not Fail") {
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        fail()
                    }
                }
                it("Should Save Name Correctly") {
                    switch result {
                    case .success(let object):
                        expect(object.first?.title)
                            .to(be(reminder.title))
                    case .failure(_):
                        fail()
                    }
                }
            }
        }
        
        describe("Save Method") {
            context("When the Title is Invalid") {
                let reminder = Reminder(title: nil, time: Date())
                let result = self.repository.save(reminder)
                it("Should Fail") {
                    switch result {
                    case .success(_):
                        fail()
                    case .failure(_):
                        succeed()
                    }
                }
                it("Should Throw Title is Nil"){
                    switch result {
                    case .success(_):
                        fail()
                    case .failure(let error):
                        expect(error.cause).to(equal(ManagedObjectError.Lembrete.TitleIsNil))
                    }
                }
            }
            context("When the Time is Invalid") {
                let reminder = Reminder(title: "Teste", time: nil)
                let result = self.repository.save(reminder)
                it("Should Fail") {
                    switch result {
                    case .success(_):
                        fail()
                    case .failure(_):
                        succeed()
                    }
                }
                it("Should Throw Time is Nil"){
                    switch result {
                    case .success(_):
                        fail()
                    case .failure(let error):
                        expect(error.cause)
                            .to(equal(ManagedObjectError.Lembrete.TimeIsNil))
                    }
                }
            }
        }
    }
    
}
