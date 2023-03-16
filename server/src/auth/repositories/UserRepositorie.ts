import { User } from "../entities/User";

export interface IUserRepository {
    getUserByNickname(nickname: string): User | null;
    saveUser(user: User): string;
}

export default
class UserRepository implements IUserRepository {
    private readonly users: Map<string, User> = new Map()

    getUserByNickname(nickname: string): User | null {
        const item = this.users.get(nickname) ?? null
        return item;
    }

    saveUser(user: User): string {
        this.users.set(user.nickname, user)
        return user.id;
    }
}
