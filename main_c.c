#include <stdio.h>

#include "qstruct/compiler.h"
#include "qstruct/builder.h"


#define ERR_BUF_LEN 1024

void debug_def(const struct qstruct_definition *def)
{
    uint32_t i;
    const struct qstruct_definition *qstruct = def;
    struct qstruct_item *item;

    printf("Loaded %zu items\n", def->num_items);

    do
    {
        printf("name: %.*s\n", (int)qstruct->name_len, qstruct->name);
        printf("size: %u\n", qstruct->body_size);
        printf("items:\n");

        for (i = 0; i < qstruct->num_items; i++)
        {
            item = &qstruct->items[i];
            printf("\tname: %.*s\n", (int)item->name_len, item->name);
            printf("\ttype: %d\n", item->type);
        }
    }
    while ((qstruct = qstruct->next));
}

struct User
{
    size_t id;
    char name[15];
};

int main()
{
    struct User *user;

    char *schema = "qstruct User { id @0 uint64; name @1 string; }";
    char err_buf[ERR_BUF_LEN];
    struct qstruct_definition *def;
    struct qstruct_builder *builder;

    char* message;
    size_t message_size;

    def = parse_qstructs(schema, strlen(schema), err_buf, ERR_BUF_LEN);

    if (def == NULL)
    {
        fprintf(stderr, "%s", err_buf);
        exit(EXIT_FAILURE);
    }

//    debug_def(def);

    // build the User
    builder = qstruct_builder_new(0, def->body_size, 1);

    qstruct_builder_set_uint64(builder, 0, 0, 0xdeadbeefcafebabe);
    qstruct_builder_set_pointer(builder, 0, 8, "haxxor", 6, 1, NULL);

    message = qstruct_builder_get_buf(builder);
    message_size = qstruct_builder_get_msg_size(builder);

//    user = (struct User*)(message + 16);

    fwrite(message, message_size, 1, stdout);
//    printf("%zu\n", user->id);
//    printf("%s\n", user->name);

    qstruct_builder_free(builder);
    free_qstruct_definitions(def);

    return 0;
}
