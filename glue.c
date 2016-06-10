#include "qstruct/utils.h"
#include "qstruct/compiler.h"
#include "qstruct/builder.h"
#include "qstruct/loader.h"

// builder glue code
int qstruct_builder_emplace_glue(struct qstruct_builder *builder, uint64_t magic_id, uint32_t body_size, uint32_t body_count) {
    return qstruct_builder_emplace(builder, magic_id, body_size, body_count);
}

struct qstruct_builder *qstruct_builder_new_glue(uint64_t magic_id, uint32_t body_size, uint32_t body_count) {
    return qstruct_builder_new(magic_id, body_size, body_count);
}

void qstruct_builder_free_buf_glue(struct qstruct_builder *builder) {
    qstruct_builder_free_buf(builder);
}

void qstruct_builder_free_glue(struct qstruct_builder *builder) {
    qstruct_builder_free(builder);
}

size_t qstruct_builder_get_msg_size_glue(struct qstruct_builder *builder) {
    return qstruct_builder_get_msg_size(builder);
}

char *qstruct_builder_get_buf_glue(struct qstruct_builder *builder) {
    return qstruct_builder_get_buf(builder);
}

char *qstruct_builder_steal_buf_glue(struct qstruct_builder *builder) {
    return qstruct_builder_steal_buf(builder);
}

int qstruct_builder_give_buf_glue(struct qstruct_builder *builder, char *buf, size_t buf_size) {
    return qstruct_builder_give_buf(builder, buf, buf_size);
}

int qstruct_builder_expand_msg_glue(struct qstruct_builder *builder, size_t new_buf_size) {
    return qstruct_builder_expand_msg(builder, new_buf_size);
}

int qstruct_builder_set_uint64_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, uint64_t value) {
    return qstruct_builder_set_uint64(builder, body_index, byte_offset, value);
}

int qstruct_builder_set_uint32_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, uint32_t value) {
    return qstruct_builder_set_uint32(builder, body_index, byte_offset, value);
}

int qstruct_builder_set_uint16_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, uint16_t value) {
    return qstruct_builder_set_uint16(builder, body_index, byte_offset, value);
}

int qstruct_builder_set_uint8_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, uint8_t value) {
    return qstruct_builder_set_uint8(builder, body_index, byte_offset, value);
}

int qstruct_builder_set_bool_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, int bit_offset, int value) {
    return qstruct_builder_set_bool(builder, body_index, byte_offset, bit_offset, value);
}

int qstruct_builder_set_pointer_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, char *value, size_t value_size, int alignment, size_t *output_data_start) {
    return qstruct_builder_set_pointer(builder, body_index, byte_offset, value, value_size, alignment, output_data_start);
}

int qstruct_builder_set_raw_bytes_glue(struct qstruct_builder *builder, uint32_t body_index, uint32_t byte_offset, char *value, size_t value_size) {
    return qstruct_builder_set_raw_bytes(builder, body_index, byte_offset, value, value_size);
}

// loader glue code
int qstruct_sanity_check_glue(const char *buf, size_t buf_size) {
    return qstruct_sanity_check(buf, buf_size);
}

int qstruct_unpack_header_glue(const char *buf, size_t buf_size, uint64_t *output_magic_id, uint32_t *output_body_size, uint32_t *output_body_count) {
    return qstruct_unpack_header(buf, buf_size, output_magic_id, output_body_size, output_body_count);
}

int qstruct_get_uint64_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, uint64_t *output) {
    return qstruct_get_uint64(buf, buf_size, body_index, byte_offset, output);
}

int qstruct_get_uint32_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, uint32_t *output) {
    return qstruct_get_uint32(buf, buf_size, body_index, byte_offset, output);
}

int qstruct_get_uint16_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, uint16_t *output) {
    return qstruct_get_uint16(buf, buf_size, body_index, byte_offset, output);
}

int qstruct_get_uint8_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, uint8_t *output) {
    return qstruct_get_uint8(buf, buf_size, body_index, byte_offset, output);
}

int qstruct_get_bool_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, int bit_offset, int *output) {
    return qstruct_get_bool(buf, buf_size, body_index, byte_offset, bit_offset, output);
}

int qstruct_get_pointer_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, char **output, size_t *output_size, int alignment) {
    return qstruct_get_pointer(buf, buf_size, body_index, byte_offset, output, output_size, alignment);
}

int qstruct_get_raw_bytes_glue(const char *buf, size_t buf_size, uint32_t body_index, uint32_t byte_offset, size_t length, char **output, size_t *output_size) {
    return qstruct_get_raw_bytes(buf, buf_size, body_index, byte_offset, length, output, output_size);
}
