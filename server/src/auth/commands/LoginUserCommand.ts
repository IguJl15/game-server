import { IUserRepository } from "../repositories/UserRepository";
import { IUserCredentials } from "../../api/Mutations";
import Session from "../entities/Session";
import Utils from "../../game/utils/Utils";

export default
    class LoginUserCommand {
    constructor(
        public repository: IUserRepository
    ) { }


    execute(user: IUserCredentials) {
        const existingUser = this.repository.getUserByNickname(user.userName)

        if (existingUser == null) {
            throw new Error("Usuario nao encontrado")
        }

        const existingPassword = existingUser.password

        if (existingPassword != user.password) {
            throw new Error("A senha esta incorreta")
        }

        const newSessionId = Utils.generateId();

        existingUser.sessionId = newSessionId;

        this.repository.saveUser(existingUser);

        return new Session(existingUser.sessionId, existingUser.nickName);
    }
}