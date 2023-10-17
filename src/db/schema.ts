import { pgTable, serial, text, varchar } from "drizzle-orm/pg-core";

export const schema = pgTable("users", {
    id:serial("id").primaryKey(),
    name:varchar("name"),
    surname:varchar("surname"),
    email:varchar("email"),
    password:text("password"),
});