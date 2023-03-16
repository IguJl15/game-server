import { IUserRepository } from "../repositories/UserRepository";
import { ObfuscateUser } from "../entities/User";

export default
class AuthorizeUserCommand {
    constructor(
        public repository: IUserRepository
    ) { }

    execute(sessionId: string): ObfuscateUser {
        const existingUser = this.repository.getUserBySessionId(sessionId)

        if (existingUser == null) {
            throw new Error("Sessão não encontrada")
        }

        return existingUser.obfuscate();
    }
}