"Example using @bzlparty_quickjs//:qjs in `genrule`"

def generate_message(name, message):
    "Generate a file with a given message"
    native.genrule(
        name = name,
        outs = ["%s.out" % name],
        cmd = "$(locations @qjs//:qjs) --eval 'console.log(\"%s\")' > $(OUTS)" % message,
        tools = ["@qjs//:qjs"],
    )
