export default
class Utils {
    private static 
    readonly letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    static generateId(): string {
        return Array.from({length: 5}, (v, i) => {
            // letra aleatória
            const random = Math.floor(Math.random() * this.letters.length);
            return this.letters[random];
        }).join("")
    }
}