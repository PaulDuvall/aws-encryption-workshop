import aws_encryption_sdk

kms_key_provider = aws_encryption_sdk.KMSMasterKeyProvider(key_ids=[
    'arn:aws:kms:us-east-1:2222222222222:key/22222222-2222-2222-2222-222222222222',
    'arn:aws:kms:us-east-1:3333333333333:key/33333333-3333-3333-3333-333333333333'
])
my_plaintext = b'This is secret data!!'

print ("my_plaintext %s\n" % my_plaintext)

my_ciphertext, encryptor_header = aws_encryption_sdk.encrypt(
    source=my_plaintext,
    key_provider=kms_key_provider
)

print ("my_ciphertext %s\n" % my_ciphertext)

decrypted_plaintext, decryptor_header = aws_encryption_sdk.decrypt(
    source=my_ciphertext,
    key_provider=kms_key_provider
)

print ("decrypted_plaintext %s" % decrypted_plaintext)


assert my_plaintext == decrypted_plaintext
assert encryptor_header.encryption_context == decryptor_header.encryption_context