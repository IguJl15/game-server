import { IUserRepository } from "../repositories/UserRepositorie";
import { User } from "../entities/User";
import { IUserCredentials } from "../../api/Mutations";

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

        return existingUser;
    }
}

//deve existir um user com o mesmo nickname passado como parametro, entao jogar um novo erro
// encontrando o nickname vc deve conferir a senha passada como parametro eh igual a senha armazenada no user