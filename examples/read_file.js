import { open } from "std";
const file = open(scriptArgs[1], "r")
print(file.readAsString())
