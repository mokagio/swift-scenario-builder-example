@testable import ScenarioBuilderExample
import XCTest

class TestExample: XCTestCase {

    func testExampleWithVanilla() {
        let medicalBackend = MedicalBackend(
            name: "medical backend",
            registrationID: "123ABC",
            address: Address(
                streetNumber: "123",
                street: "a street",
                city: "a city",
                state: "a state",
                postCode: "2ABC"
            )
        )
        let doctor = Doctor(name: "a name", license: "1234", specialty: .generalPractitioner)
        medicalBackend.employ(doctor: doctor)
        let patient = Patient(
            name: "another name",
            dateOfBirth: Date(year: 2010, month: 01, day: 01),
            address: Address(
                streetNumber: "234",
                street: "a street",
                city: "a city",
                state: "a state",
                postCode: "12ABC"
            )
        )
        medicalBackend.onboard(patient: patient)
        medicalBackend.register(patient: patient, with: doctor)

        let script = medicalBackend.issueScript(
            forDrug: Drug.fixture(minimumAge: 21),
            quantity: .grams(2),
            repetition: 4,
            to: patient,
            from: doctor
        )

        guard case .failure(let error) = script else { return XCTFail("Expected error, got \(script)") }
        XCTAssertEqual(error, .patientUnderAgeForDrug)
    }

    func testExampleWithFixtures() {
        let medicalBackend = MedicalBackend(
            name: "medical backend",
            registrationID: "123ABC",
            address: .fixture()
        )
        let doctor = Doctor.fixture()
        medicalBackend.employ(doctor: doctor)
        let patient = Patient.fixture(dateOfBirth: Date(year: 2010, month: 01, day: 01))
        medicalBackend.onboard(patient: patient)
        medicalBackend.register(patient: patient, with: doctor)

        let script = medicalBackend.issueScript(
            forDrug: Drug.fixture(minimumAge: 21),
            quantity: .grams(2),
            repetition: 4,
            to: patient,
            from: doctor
        )

        guard case .failure(let error) = script else { return XCTFail("Expected error, got \(script)") }
        XCTAssertEqual(error, .patientUnderAgeForDrug)
    }

    func testExampleWithScenarioBuilder() {
        let (medicalBackend, doctor, patient) = ScenarioBuilder().withPatientAge(10).build()

        let script = medicalBackend.issueScript(
            forDrug: Drug.fixture(minimumAge: 21),
            quantity: .grams(2),
            repetition: 4,
            to: patient,
            from: doctor
        )

        guard case .failure(let error) = script else { return XCTFail("Expected error, got \(script)") }
        XCTAssertEqual(error, .patientUnderAgeForDrug)
    }
}
