export class User {
    constructor(
        public id: string,
        public nickName: string,
        public password: string,
        
        public sessionId: string,

        public boardIds = []
    ) { }
}