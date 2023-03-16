export default abstract class Cloneable {
    deepCopy(): any {
        if (Array.isArray(this)) return this.map<any>(item => item instanceof Cloneable ? item.deepCopy() : item)
        else if (this instanceof Date) return new Date(this.getTime())
        else if (this && typeof this === 'object') {
            return Object.getOwnPropertyNames(this).reduce((o, prop) => {
                Object.defineProperty(o, prop, Object.getOwnPropertyDescriptor(this, prop)!);
                const value = ((this as { [key: string]: any })[prop])
                o[prop] = value instanceof Cloneable ? value.deepCopy() : value;
                return o;
            }, Object.create(Object.getPrototypeOf(this)))
        }
        return this
    }
}