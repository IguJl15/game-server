class AlreadyMarkedError extends Error {
    constructor() {
        super("Posição já preenchida")
    }
}