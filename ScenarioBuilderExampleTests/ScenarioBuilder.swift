@testable import ScenarioBuilderExample

struct ScenarioBuilder {

    // FIXME: Use reasonable defaults here
    private var date: Date = Date()
    private var patientDOB: Date = Date() // this would have to be something like 21 years ago

    func withDate(year: Int, month: Int = 1, day: Int = 1) -> ScenarioBuilder {
        var newScenarioBuilder = self
        newScenarioBuilder.date = date
        return newScenarioBuilder
    }

    func withPatientAge(age: Int) -> ScenarioBuilder {
        var newScenarioBuilder = self
        // TODO: Calculate date of birth
        newScenarioBuilder.patientDOB = Date()
        return newScenarioBuilder
    }

    func build() -> (MedicalBackend, Doctor, Patient) {
        let medicalBackend = MedicalBackend(
            name: "a name",
            registrationID: "ABC123",
            address: .fixture()
        )

        let doctor = Doctor.fixture()

        medicalBackend.employ(doctor: doctor)

        let patient = Patient.fixture(dateOfBirth: patientDOB)

        medicalBackend.onboard(patient: patient)
        medicalBackend.register(patient: patient, with: doctor)

        return (medicalBackend, doctor, patient)
    }
}


