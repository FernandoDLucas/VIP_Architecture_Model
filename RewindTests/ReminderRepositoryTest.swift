//
//  ReminderRepositoryTest.swift
//  RewindTests
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

@testable import Rewind
import Nimble
import Quick
import Foundation

class ReminderRepositoryTest: QuickSpec {
    
    private let repository = ReminderRepository()
    
    override func spec() {
        
        describe("Save Method") {
            self.repository.service = CoreDataService<Lembrete>(saveon: .inMemory)
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
            
            context("When the Title is Invalid") {
                let reminder = Reminder(title: nil, time: Date())
                let result = self.repository.save(reminder)
                it("Should Fail") {
                    if case .success(_) = result{ fail() }
                }
                it("Should Throw Title is Nil"){
                    if case .success(_) = result { fail() }
                    if case .failure(let error) = result {
                        expect(error.cause).to(equal(ManagedObjectError.Lembrete.TitleIsNil))
                    }
                }
            }
            
            context("When the Time is Invalid") {
                let reminder = Reminder(title: "Teste", time: nil)
                let result = self.repository.save(reminder)
                it("Should Fail") {
                    if case .success(_) = result{ fail() }
                }
                it("Should Throw Time is Nil"){
                    if case .success(_) = result { fail() }
                    if case .failure(let error) = result {
                        expect(error.cause).to(equal(ManagedObjectError.Lembrete.TimeIsNil))
                    }
                }
            }
        }
    }
}
