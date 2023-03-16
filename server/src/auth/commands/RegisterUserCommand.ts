import { IUserRegister } from "../../api/Mutations";
import Utils from "../../game/utils/Utils";
import { IUserRepository } from "../repositories/UserRepositorie";
import { User } from "../entities/User";


export default
    class RegisterUserCommand {
    constructor(
        public repository: IUserRepository
    ) { }

    validate(params: IUserRegister) {
        const exsinstingUser = this.repository.getUserByNickname(params.userName)

        if (exsinstingUser) {
            throw new Error('Esse usuario ja existe')
        }

        const passwordsAreEqual = params.password == params.confimedPassword
        if (!passwordsAreEqual) {
            throw new Error('As senhas nao sao iguais')
        }

    }

    execute(params: IUserRegister) {
        this.validate(params)

        const newUser = new User(Utils.generateId(), params.userName, params.password);
        const savedNewUser = this.repository.saveUser(newUser);
        return newUser
    }
}