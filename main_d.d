import core.stdc.string;
import std.conv;
import std.exception;
import std.stdio;
import std.string;

import qstruct;

struct User
{
  public:

    static this()
    {
        string schema = "qstruct User { id @0 uint64; name @1 string; }";
        def_ = load(schema);
    }

    this(ulong id, string name)
    {
        qstruct_builder builder = void;

        if (qstruct_builder_emplace_glue(&builder, 0, def_.body_size, 1))
        {
            throw new Error("Unable to allocate buffer");
        }

        if (qstruct_builder_set_uint64_glue(&builder, 0, 0, id))
        {
            throw new Exception("Unable to set 'id'");
        }

        if (qstruct_builder_set_pointer_glue(&builder, 0, 8, cast(char*)(name.ptr), name.length, 1, null) != 0)
        {
            throw new Exception("Unable to set 'name'");
        }

        buf_ = qstruct_builder_steal_buf_glue(&builder)[0..qstruct_builder_get_msg_size_glue(&builder)].assumeUnique();
    }

    this(immutable ubyte[] message)
    {
        if (qstruct_sanity_check_glue(message.ptr, message.length))
        {
            throw new Exception("Message failed sanity check");
        }

        ulong magicId = void;
        uint bodySize = void;
        uint bodyCount = void;

        if (qstruct_unpack_header_glue(message.ptr, message.length, &magicId, &bodySize, &bodyCount))
        {
            throw new Exception("Failed to unpack message header");
        }

        buf_ = message;
    }

    ~this()
    {
    }

    static ~this()
    {
        free_qstruct_definitions(def_);
    }

    @property size_t id() const
    {
        size_t id;
        if (qstruct_get_uint64_glue(buf_.ptr, buf_.length, 0, 0, &id) != 0)
        {
            throw new Exception("Unable to get 'id'");
        }
        return id;
    }

    @property string name() const
    {
        char *name;
        size_t name_len;

        if (qstruct_get_pointer_glue(buf_.ptr, buf_.length, 0, 8, &name, &name_len, 1) != 0)
        {
            throw new Exception("Unbale to get 'name'");
        }

        return name[0..name_len].assumeUnique();
    }

    immutable(ubyte)[] toQStruct() const
    {
        return buf_;
    }

    string toString() const
    {
        return "(User id=%d name='%s')".format(id, name);
    }

  private:
    static qstruct_definition* def_;

    immutable ubyte[] buf_;
}

qstruct_definition *load(string schema)
{
    char[] mutableSchema = schema.to!(char[]);

    char errorBuffer[2048];

    auto def = parse_qstructs(
        mutableSchema.ptr, mutableSchema.length, errorBuffer.ptr, errorBuffer.length
    );

    if (def is null)
    {
        throw new Exception(fromStringz(errorBuffer.ptr).to!string);
    }

    return def;
}

void main()
{
    auto user = User(1, "John Doe");
    auto message = user.toQStruct();

    writeln(user);

    auto user2 = User(message);
    writeln(user2);

}
