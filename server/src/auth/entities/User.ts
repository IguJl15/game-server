export interface ObfuscateUser {
    id: string,
    nickName: string,
}

export class User {
    constructor(
        public id: string,
        public nickName: string,
        public password: string,
        
        public sessionId: string,

        public boardIds = []
    ) { }

    obfuscate(): ObfuscateUser {
        return {
            id: this.id,
            nickName: this.nickName
        }
    }
}