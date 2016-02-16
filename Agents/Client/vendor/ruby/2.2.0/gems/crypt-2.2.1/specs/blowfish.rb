require 'crypt/blowfish'
require 'fileutils'

describe "Crypt::Blowfish" do
	
	it "has a blocksize of 8" do
		bf = Crypt::Blowfish.new("Who is John Galt?")  # Schneier's test key
		expect(bf.block_size).to eql(8)
	end
	
	it "requires a key of 1-56 bytes" do
		expect {
			b0 = Crypt::Blowfish.new("")
		}.to raise_error(RuntimeError)
		expect {
			b1 = Crypt::Blowfish.new("1")
		}.not_to raise_error()
		expect {
			b56 = Crypt::Blowfish.new("1"*56)
		}.not_to raise_error()
		expect {
			b57 = Crypt::Blowfish.new("1"*57)
		}.to raise_error(RuntimeError)
	end
	
	it "encrypts and decrypts 4-byte pairs" do
		bf = Crypt::Blowfish.new("Who is John Galt?")
		orig_l, orig_r = [0xfedcba98, 0x76543210]
		l, r = bf.encrypt_pair(orig_l, orig_r)
		expect(l).to eql(0xcc91732b)
		expect(r).to eql(0x8022f684)
		l, r = bf.decrypt_pair(l, r)
		expect(l).to eql(orig_l)
		expect(r).to eql(orig_r)
	end
	
	it "encrypts and decrypts 8-byte blocks" do
		bf = Crypt::Blowfish.new("Who is John Galt?")
    block = "8 byte\u00cd"   # unicode string of 8 bytes
    encryptedBlock = bf.encrypt_block(block)
    expect(encryptedBlock).to eql("\xC4G\xD3\xFD7\xF4\x1E\xD0".b())
    decryptedBlock = bf.decrypt_block(encryptedBlock)
    expect(decryptedBlock).to eql(block)
	end
	
	it "encrypts and decrypts strings" do
		length = 30 + rand(26)
    userkey = ""
    length.times { userkey << rand(256).chr }
    bf = Crypt::Blowfish.new(userkey)
    string = "This is a string which is not a multiple of 8 characters long"
    encryptedString = bf.encrypt_string(string)
    decryptedString = bf.decrypt_string(encryptedString)
    expect(decryptedString).to eql(string)
    secondstring = "This is another string to check repetitive use."
    encryptedString = bf.encrypt_string(secondstring)
    decryptedString = bf.decrypt_string(encryptedString)
    expect(decryptedString).to eql(secondstring)
	end
	
	it "encrypts and decrypts a file" do
		plainText = "This is a multi-line string\nwhich is not a multiple of 8 \ncharacters long."
    plainFile = File.new('plain.txt', 'wb+')
    plainFile.puts(plainText)
    plainFile.close()
    bf = Crypt::Blowfish.new("Who is John Galt?")
    bf.encrypt_file('plain.txt', 'crypt.txt')
    bf.decrypt_file('crypt.txt', 'decrypt.txt')
    decryptFile = File.new('decrypt.txt', 'rb')
    decryptText = decryptFile.readlines().join('').chomp()
    decryptFile.close()
    expect(decryptText).to eql(plainText)
    FileUtils.rm('plain.txt')
    FileUtils.rm('crypt.txt')
    FileUtils.rm('decrypt.txt')
	end
	
end


