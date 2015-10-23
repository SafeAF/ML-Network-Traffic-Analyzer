require 'crypt/rijndael'
require 'fileutils'

describe "Crypt::Rijndael" do

	it "has a blocksize of 128, 192, or 256 bits" do
		expect {
			rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?", 64)
		}.to raise_error(RuntimeError)
		expect {
			rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?", 128, 64)
		}.to raise_error(RuntimeError)
		rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?", 128, 256)
		expect(rijndael.block_size).to eql(32)
		rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?", 256, 128)
		expect(rijndael.block_size).to eql(16)
	end
	
	it "encrypts and decrypts 8-byte blocks" do
		rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?", 128, 128)
    block = "This block \u00cd 16"  # unicode string of 16 bytes
    encryptedBlock = rijndael.encrypt_block(block)
    expect(encryptedBlock).to eql("\x8E\x88\x03\xB8> PnwR)\x93\x1A\xC9:\xC4".b())
    decryptedBlock = rijndael.decrypt_block(encryptedBlock)
    expect(decryptedBlock).to eql(block)
    # attempt to encrypt with wrong block size
    rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?", 128, 256)
    expect {
    	encryptedBlock = rijndael.encrypt_block(block)
    }.to raise_error(RuntimeError)
	end
	
	it "encrypts and decrypts strings" do
		rijndael = Crypt::Rijndael.new("Who is this John Galt guy, anyway?")
    string = "This is a string which is not a multiple of 8 characters long"
    encryptedString = rijndael.encrypt_string(string)
    decryptedString = rijndael.decrypt_string(encryptedString)
    expect(decryptedString).to eql(string)
	end
	
	it "encrypts and decrypts a file" do
		plainText = "This is a multi-line string\nwhich is not a multiple of 8 \ncharacters long."
    plainFile = File.new('plain.txt', 'wb+')
    plainFile.puts(plainText)
    plainFile.close()
    rijndael = Crypt::Rijndael.new("Whatever happened to Yuri?")
    rijndael.encrypt_file('plain.txt', 'crypt.txt')
    rijndael.decrypt_file('crypt.txt', 'decrypt.txt')
    decryptFile = File.new('decrypt.txt', 'rb')
    decryptText = decryptFile.readlines().join('').chomp()
    decryptFile.close()
    expect(decryptText).to eql(plainText)
    FileUtils.rm('plain.txt')
    FileUtils.rm('crypt.txt')
    FileUtils.rm('decrypt.txt')
	end

end
