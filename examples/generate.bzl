"Example using @bzlparty_quickjs//:qjs in `genrule`"

def generate_message(name, message):
    "Generate a file with a given message"
    native.genrule(
        name = name,
        outs = ["%s.out" % name],
        cmd = "$(locations @bzlparty_quickjs//:qjs) --eval 'console.log(\"%s\")' > $(OUTS)" % message,
        tools = ["@bzlparty_quickjs//:qjs"],
    )
