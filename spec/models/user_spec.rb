require 'spec_helper'

describe User do
  subject { build :user }
  it "could be created" do
    expect(subject).to_not eq(nil)
  end
  
  it "email is required" do
    subject.email = nil
    expect(subject.valid?).to eq(false)
    expect(subject.errors[:email].length).to eq(1)
  end
  
  it "password is required" do
    subject.password = nil
    expect(subject.valid?).to eq(false)
    expect(subject.errors[:password].length).to eq(2) # empty + length
  end
  
  it "password length" do
    subject.password = 'ab'
    expect(subject.valid?).to eq(false)
    expect(subject.errors[:password].length).to eq(1) # length
  end
  
  it "generate valid and uniq token" do
    t1 = subject.class.get_token
    t2 = subject.class.get_token
    expect(t1).to_not eq(t2)
    expect(t1).to match(/[0-9a-z]{32}/)
    expect(t2).to match(/[0-9a-z]{32}/)
  end
  
  context "login" do
    it "return nil when user not found" do
      allow(User).to receive(:where).and_return(double("u", {first: nil}))
      expect(described_class.login('aaa','bbb')).to eq(nil)
    end
    it "return token for existing user" do
      subject.save
      allow(User).to receive(:where).and_return(double("u", {first: subject }))
      token = described_class.login(subject.email, subject.password)
      expect(token).to_not be_empty
      expect(token).to eq(subject.reload.token)
    end
    
  end
end
