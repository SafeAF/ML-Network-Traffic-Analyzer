module Crypt
# idea.rb  Richard Kernahan 

# IDEA (International Data Encryption Algorithm) by
# Xuejia Lai and James Massey (1992). Ported by Richard Kernahan 2005

class IDEA

  require 'crypt/cbc'
  include Crypt::CBC

  require 'digest/md5'

  USHORT  = 0x10000

  ENCRYPT = 0
  DECRYPT = 1
  
  attr_accessor(:subkeys)

  def block_size
    return(8)
  end

  def initialize(key128, mode)
    # IDEA is subject to attack unless the key is sufficiently random, so we
    # take an MD5 digest of a variable-length passphrase to ensure a solid key
    if (key128.class == String)
      digest = Digest::MD5.new().digest(key128.b).b()
      key128 = digest.unpack('n8')
    end
    raise "Key must be 128 bits (8 words)" unless (key128.class == Array) && (key128.length == 8)
    raise "Mode must be IDEA::ENCRYPT or IDEA::DECRYPT" unless ((mode == ENCRYPT) | (mode == DECRYPT))
    if (mode == ENCRYPT)
      @subkeys = generate_encryption_subkeys(key128)
    else
      @subkeys = generate_decryption_subkeys(key128)
    end
  end
  
  def mul(a, b)
    modulus = 0x10001
    return((1 - b) % USHORT) if (a == 0)
    return((1 - a) % USHORT) if (b == 0)
    return((a * b) % modulus % USHORT)   # fixed with % USHORT
  end

  def mulInv(x)
    modulus = 0x10001
    x = x.to_i % 0x10000
    return(x) if (x <= 1)
    t1 = modulus / x
    y  = modulus % x
    if (y == 1)
      inv = (1 - t1) & 0xFFFF
      return(inv)
    end
    t0 = 1
    while (y != 1)
      q = x / y
      x = x % y
      t0 = t0 + (q * t1)
      return(t0) if (x == 1)
      q = y / x
      y = y % x
      t1 = t1 + (q * t0)
    end
    inv = (1 - t1) & 0xFFFF
    return(inv)
  end

  def generate_encryption_subkeys(key)
    encrypt_keys = []
    encrypt_keys[0..7] = key.dup
    8.upto(51) { |i|
      a = ((i + 1) % 8 > 0) ? (i-7)  : (i-15)
      b = ((i + 2) % 8 < 2) ? (i-14) : (i-6)
      encrypt_keys[i] = ((encrypt_keys[a] << 9) | (encrypt_keys[b] >> 7)) % USHORT
    }
    return(encrypt_keys)
  end

  def generate_decryption_subkeys(key)
    encrypt_keys = generate_encryption_subkeys(key)
    decrypt_keys = []
    decrypt_keys[48] = mulInv(encrypt_keys.shift)
    decrypt_keys[49] = (-encrypt_keys.shift) % USHORT
    decrypt_keys[50] = (-encrypt_keys.shift) % USHORT
    decrypt_keys[51] = mulInv(encrypt_keys.shift)
    42.step(0, -6) { |i|
      decrypt_keys[i+4] = encrypt_keys.shift % USHORT
      decrypt_keys[i+5] = encrypt_keys.shift % USHORT
      decrypt_keys[i]   = mulInv(encrypt_keys.shift)
      if (i == 0)
        decrypt_keys[1] = (-encrypt_keys.shift) % USHORT
        decrypt_keys[2] = (-encrypt_keys.shift) % USHORT
      else
        decrypt_keys[i+2] = (-encrypt_keys.shift) % USHORT
        decrypt_keys[i+1] = (-encrypt_keys.shift) % USHORT
      end
      decrypt_keys[i+3] = mulInv(encrypt_keys.shift)
    }
    return(decrypt_keys)
  end

  def crypt_pair(l, r)
    word = [l, r].pack('NN').unpack('nnnn')
    k = @subkeys[0..51]
    8.downto(1) { |i|
      word[0] = mul(word[0], k.shift)
      word[1] = (word[1] + k.shift) % USHORT
      word[2] = (word[2] + k.shift) % USHORT
      word[3] = mul(word[3], k.shift)
      t2 = word[0] ^ word[2]
      t2 = mul(t2, k.shift)
      t1 = (t2 + (word[1] ^ word[3])) % USHORT
      t1 = mul(t1, k.shift)
      t2 = (t1 + t2) % USHORT
      word[0] ^= t1
      word[3] ^= t2
      t2 ^= word[1]
      word[1] = word[2] ^ t1
      word[2] = t2
    }
    result = []
    result << mul(word[0], k.shift)
    result << (word[2] + k.shift) % USHORT
    result << (word[1] + k.shift) % USHORT
    result << mul(word[3], k.shift)
    twoLongs = result.pack('nnnn').unpack('NN')
    return(twoLongs)
  end

  def encrypt_block(block)
    xl, xr = block.unpack('NN')
    xl, xr = crypt_pair(xl, xr)
    encrypted = [xl, xr].pack('NN')
    return(encrypted)
  end

  def decrypt_block(block)
    xl, xr = block.unpack('NN')
    xl, xr = crypt_pair(xl, xr)
    decrypted = [xl, xr].pack('NN')
    return(decrypted)
  end

end
end

