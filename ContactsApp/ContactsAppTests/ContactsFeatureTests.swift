import ComposableArchitecture
import Testing
import Foundation
@testable import ContactsApp

@MainActor
struct ContactsFeatureTests {

    @Test
    func addFlow() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                )
            )
        }
        
        await store.send(\.destination.addContact.setName, "Test User 1") {
            $0.destination?.modify(\.addContact) { $0.contact.name = "Test User 1" }
        }
        
        await store.send(\.destination.addContact.saveButtonTapped)
        
        await store.receive(
            \.destination.addContact.delegate.saveContact, Contact(id: UUID(0), name: "Test User 1")
        ) {
            $0.contacts = [ Contact(id: UUID(0), name: "Test User 1") ]
        }
        
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }
    
    
    @Test
    func addFlowNonExhaustive() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
        await store.send(.addButtonTapped)
        await store.send(\.destination.addContact.setName, "Test User 2")
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.skipReceivedActions()
        store.assert {
            $0.contacts = [
                Contact(id: UUID(0), name: "Test User 2")
            ]
            $0.destination = nil
        }
    }
    
    
    @Test
    func deleteContact() async {
        let store = TestStore(initialState: ContactFeature.State(contacts: [
            Contact(id: UUID(0), name: "Test User 1"),
            Contact(id: UUID(1), name: "Test User 2"),
        ])) {
            ContactFeature()
        }
        
        await store.send(.deleteButtonTapped(id: UUID(1))) {
            $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
        }
        
        await store.send(\.destination.alert.confirmDeletion, UUID(1)) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Test User 1")
            ]
            $0.destination = nil
        }

    }

}
