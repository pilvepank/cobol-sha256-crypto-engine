#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

typedef struct {
    uint32_t state[8];
    uint64_t count;
    uint8_t buffer[64];
} SHA256_CTX;

static inline uint32_t ror(uint32_t x, int n) { return (x >> n) | (x << (32 - n)); }
static inline uint32_t sig0(uint32_t x) { return ror(x, 7) ^ ror(x, 18) ^ (x >> 3); }
static inline uint32_t sig1(uint32_t x) { return ror(x, 17) ^ ror(x, 19) ^ (x >> 10); }
static inline uint32_t sum0(uint32_t x) { return ror(x, 2) ^ ror(x, 13) ^ ror(x, 22); }
static inline uint32_t sum1(uint32_t x) { return ror(x, 6) ^ ror(x, 11) ^ ror(x, 25); }
static inline uint32_t ch(uint32_t x, uint32_t y, uint32_t z) { return (x & y) ^ (~x & z); }
static inline uint32_t maj(uint32_t x, uint32_t y, uint32_t z) { return (x & y) ^ (x & z) ^ (y & z); }

static const uint32_t K[64] = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
};

static void transform(uint32_t state[8], const uint8_t block[64]) {
    uint32_t W[64];
    for (int i = 0; i < 16; i++) {
        W[i] = ((uint32_t)block[i*4] << 24) | ((uint32_t)block[i*4+1] << 16) | ((uint32_t)block[i*4+2] << 8) | (uint32_t)block[i*4+3];
    }
    for (int i = 16; i < 64; i++) {
        W[i] = W[i-16] + sig0(W[i-15]) + W[i-7] + sig1(W[i-2]);
    }
    uint32_t a = state[0], b = state[1], c = state[2], d = state[3], e = state[4], f = state[5], g = state[6], h = state[7];
    for (int t = 0; t < 64; t++) {
        uint32_t T1 = h + sum1(e) + ch(e, f, g) + K[t] + W[t];
        uint32_t T2 = sum0(a) + maj(a, b, c);
        h = g; g = f; f = e; e = d + T1;
        d = c; c = b; b = a; a = T1 + T2;
    }
    state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    state[4] += e; state[5] += f; state[6] += g; state[7] += h;
}

void sha256_init(SHA256_CTX *ctx) {
    ctx->state[0] = 0x6a09e667; ctx->state[1] = 0xbb67ae85;
    ctx->state[2] = 0x3c6ef372; ctx->state[3] = 0xa54ff53a;
    ctx->state[4] = 0x510e527f; ctx->state[5] = 0x9b05688c;
    ctx->state[6] = 0x1f83d9ab; ctx->state[7] = 0x5be0cd19;
    ctx->count = 0;
}

void sha256_update(SHA256_CTX *ctx, const uint8_t *data, size_t len) {
    size_t i = 0;
    size_t buffer_index = (size_t)(ctx->count & 63);
    ctx->count += len;
    if (buffer_index > 0) {
        size_t left = 64 - buffer_index;
        if (len < left) {
            memcpy(ctx->buffer + buffer_index, data, len);
            return;
        }
        memcpy(ctx->buffer + buffer_index, data, left);
        transform(ctx->state, ctx->buffer);
        i += left;
    }
    for (; i + 63 < len; i += 64) {
        transform(ctx->state, data + i);
    }
    if (i < len) {
        memcpy(ctx->buffer, data + i, len - i);
    }
}

void sha256_final(SHA256_CTX *ctx, uint8_t digest[32]) {
    size_t buffer_index = (size_t)(ctx->count & 63);
    ctx->buffer[buffer_index++] = 0x80;
    if (buffer_index > 56) {
        memset(ctx->buffer + buffer_index, 0, 64 - buffer_index);
        transform(ctx->state, ctx->buffer);
        buffer_index = 0;
    }
    memset(ctx->buffer + buffer_index, 0, 56 - buffer_index);
    uint64_t bits = ctx->count * 8;
    for (int i = 0; i < 8; i++) {
        ctx->buffer[63 - i] = (uint8_t)(bits >> (i * 8));
    }
    transform(ctx->state, ctx->buffer);
    for (int i = 0; i < 8; i++) {
        digest[i*4]   = (uint8_t)(ctx->state[i] >> 24);
        digest[i*4+1] = (uint8_t)(ctx->state[i] >> 16);
        digest[i*4+2] = (uint8_t)(ctx->state[i] >> 8);
        digest[i*4+3] = (uint8_t)(ctx->state[i]);
    }
}

void cobol_sha256(const char *in_str, const int *in_len, char *hex_out) {
    SHA256_CTX ctx;
    uint8_t digest[32];
    sha256_init(&ctx);
    int len = *in_len;
    if (len > 0) {
        sha256_update(&ctx, (const uint8_t*)in_str, len);
    }
    sha256_final(&ctx, digest);
    char buf[65];
    for (int i = 0; i < 32; i++) {
        sprintf(buf + i * 2, "%02x", digest[i]);
    }
    memcpy(hex_out, buf, 64);
}

void cobol_hmac_sha256(const char *key, const int *key_len, const char *data, const int *data_len, char *hex_out) {
    int klen = *key_len;
    int dlen = *data_len;
    uint8_t k[64] = {0};
    if (klen > 64) {
        SHA256_CTX kctx;
        sha256_init(&kctx);
        sha256_update(&kctx, (const uint8_t*)key, klen);
        sha256_final(&kctx, k);
    } else {
        memcpy(k, key, klen);
    }
    uint8_t ipad[64], opad[64];
    for (int i = 0; i < 64; i++) {
        ipad[i] = k[i] ^ 0x36;
        opad[i] = k[i] ^ 0x5c;
    }
    SHA256_CTX inner;
    sha256_init(&inner);
    sha256_update(&inner, ipad, 64);
    if (dlen > 0) {
        sha256_update(&inner, (const uint8_t*)data, dlen);
    }
    uint8_t inner_digest[32];
    sha256_final(&inner, inner_digest);

    SHA256_CTX outer;
    sha256_init(&outer);
    sha256_update(&outer, opad, 64);
    sha256_update(&outer, inner_digest, 32);
    uint8_t outer_digest[32];
    sha256_final(&outer, outer_digest);

    char buf[65];
    for (int i = 0; i < 32; i++) {
        sprintf(buf + i * 2, "%02x", outer_digest[i]);
    }
    memcpy(hex_out, buf, 64);
}
