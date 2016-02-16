require 'crypt/gost'
require 'fileutils'

describe "Crypt::Gost" do

	it "has a blocksize of 8" do
		gost = Crypt::Gost.new("Whatever happened to Yuri Gagarin?")
		expect(gost.block_size).to eql(8)
	end
	
	it "encrypts and decrypts 8-byte blocks" do
		gost = Crypt::Gost.new("Whatever happened to Yuri?")
    block = "norandom"
    encryptedBlock = gost.encrypt_block(block)
    expect(encryptedBlock).to eql(".Vy\xFF\x05\e3`".b())
    decryptedBlock = gost.decrypt_block(encryptedBlock)
    expect(decryptedBlock).to eql(block)
	end
	
	it "encrypts and decrypts strings" do
		length = 25 + rand(12)
    userkey = ""
    length.times { userkey << rand(256).chr }
    gost = Crypt::Gost.new(userkey)
    string = "This is a string which is not a multiple of 8 characters long"
    encryptedString = gost.encrypt_string(string)
    decryptedString = gost.decrypt_string(encryptedString)
    expect(decryptedString).to eql(string)
	end
	
	it "encrypts and decrypts a file" do
		plainText = "This is a multi-line string\nwhich is not a multiple of 8 \ncharacters long."
    plainFile = File.new('plain.txt', 'wb+')
    plainFile.puts(plainText)
    plainFile.close()
    gost = Crypt::Gost.new("Whatever happened to Yuri?")
    gost.encrypt_file('plain.txt', 'crypt.txt')
    gost.decrypt_file('crypt.txt', 'decrypt.txt')
    decryptFile = File.new('decrypt.txt', 'rb')
    decryptText = decryptFile.readlines().join('').chomp()
    decryptFile.close()
    expect(decryptText).to eql(plainText)
    FileUtils.rm('plain.txt')
    FileUtils.rm('crypt.txt')
    FileUtils.rm('decrypt.txt')
	end

end
