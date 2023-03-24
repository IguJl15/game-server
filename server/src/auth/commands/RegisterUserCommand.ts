import { IUserRegister } from "../../api/Mutations";
import Utils from "../../game/utils/Utils";
import { IUserRepository } from "../repositories/UserRepository";
import { User } from "../entities/User";
import Session from "../entities/Session";


export default
    class RegisterUserCommand {
    constructor(
        public repository: IUserRepository
    ) { }

    validate(params: IUserRegister) {
        const existingUser = this.repository.getUserByNickname(params.userName)

        if (existingUser) {
            throw new Error('Esse usuario ja existe')
        }

        const passwordsAreEqual = params.password == params.confirmedPassword
        if (!passwordsAreEqual) {
            throw new Error('As senhas nao sao iguais')
        }

    }

    execute(params: IUserRegister): Session {
        this.validate(params)

        const newUser = new User(
            Utils.generateId(),
            params.userName,
            params.password,
            Utils.generateId(),
        );

        this.repository.saveUser(newUser);

        return new Session(newUser.sessionId, newUser.nickName)
    }
}