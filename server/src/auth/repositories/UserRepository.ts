import { User } from "../entities/User";

export interface IUserRepository {
    getUserByNickname(nickname: string): User | null;
    getUserBySessionId(sessionId: string): User | null;
    saveUser(user: User): string;
}

export default
class UserRepository implements IUserRepository {
    private readonly users: Map<string, User> = new Map()
    
    getUserByNickname(nickname: string): User | null {
        const item = this.users.get(nickname) ?? null
        return item;
    }
    
    getUserBySessionId(sessionId: string): User | null {
        for(const [key, value] of this.users.entries()){
            if(sessionId == value.sessionId) return value;
        }

        return null;
    }

    saveUser(user: User): string {
        this.users.set(user.nickName, user)
        return user.id;
    }
}
