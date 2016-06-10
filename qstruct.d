module qstruct;

import core.stdc.stdint;

// compiler.h
extern(C)
{
    struct qstruct_definition
    {
        char *name;
        size_t name_len;
        qstruct_item *items;
        size_t num_items;
        uint32_t body_size;
        qstruct_definition *next;
    }

    struct qstruct_item
    {
        char *name;
        size_t name_len;
        int type;
        uint32_t fixed_array_size;
        uint32_t byte_offset;
        int bit_offset;
        qstruct_definition *nested_def;
        char *nested_name;
        size_t nested_name_len;
        size_t item_order;
    }

    qstruct_definition *parse_qstructs(
        char *schema, size_t schema_size, char *err_buf, size_t err_buf_size
    );
    void free_qstruct_definitions(qstruct_definition *def);
}

// builder.h
extern(C)
{
    struct qstruct_builder
    {
        ubyte *buf;
        size_t buf_size;
        size_t msg_size;
        uint32_t body_size;
        uint32_t body_count;
    }

    int qstruct_builder_emplace_glue(
        qstruct_builder *builder, uint64_t magic_id, uint32_t body_size, uint32_t body_count
    );
    qstruct_builder *qstruct_builder_new_glue(
        uint64_t magic_id, uint32_t body_size, uint32_t body_count
    );
    void qstruct_builder_free_buf_glue(qstruct_builder *builder);
    void qstruct_builder_free_glue(qstruct_builder *builder);
    size_t qstruct_builder_get_msg_size_glue(qstruct_builder *builder);
    ubyte *qstruct_builder_get_buf_glue(qstruct_builder *builder);
    ubyte *qstruct_builder_steal_buf_glue(qstruct_builder *builder);
    int qstruct_builder_give_buf_glue(
        qstruct_builder *builder,
        ubyte *buf,
        size_t buf_size
    );
    int qstruct_builder_expand_msg_glue(
        qstruct_builder *builder,
        size_t new_buf_size
    );
    int qstruct_builder_set_uint64_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        uint64_t value
    );
    int qstruct_builder_set_uint32_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        uint32_t value
    );
    int qstruct_builder_set_uint16_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        uint16_t value
    );
    int qstruct_builder_set_uint8_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        uint8_t value
    );
    int qstruct_builder_set_bool_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        int bit_offset,
        int value
    );
    int qstruct_builder_set_pointer_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        char *value,
        size_t value_size,
        int alignment,
        size_t *output_data_start
    );
    int qstruct_builder_set_raw_bytes_glue(
        qstruct_builder *builder,
        uint32_t body_index,
        uint32_t byte_offset,
        ubyte *value,
        size_t value_size
    );

}

// loader.h
extern(C)
{
    int qstruct_sanity_check_glue(
        const ubyte *buf,
        size_t buf_size
    );

    int qstruct_unpack_header_glue(
        const ubyte *buf,
        size_t buf_size,
        uint64_t *output_magic_id,
        uint32_t *output_body_size,
        uint32_t *output_body_count
    );

    int qstruct_get_uint64_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        uint64_t *output
    );

    int qstruct_get_uint32_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        uint32_t *output
    );

    int qstruct_get_uint16_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        uint16_t *output
    );

    int qstruct_get_uint8_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        uint8_t *output
    );

    int qstruct_get_bool_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        int bit_offset,
        int *output
    );

    int qstruct_get_pointer_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        char **output,
        size_t *output_size,
        int alignment
    );

    int qstruct_get_raw_bytes_glue(
        const ubyte *buf,
        size_t buf_size,
        uint32_t body_index,
        uint32_t byte_offset,
        size_t length,
        ubyte **output,
        size_t *output_size
    );
}
