require "./spec_helper"

kflag(UserOptions, active, admin)

describe KFlag do
  it "smoke" do
    flag = KFlag.new

    flag.check_admin.should eq false
    flag.set_admin.should eq nil
    flag.check_admin.should eq true
    flag.clear_admin.should eq nil
    flag.check_admin.should eq false
  end

  it "macro" do
    flag = UserOptions.new

    flag.check_admin.should eq false
    flag.set_admin.should eq nil
    flag.check_admin.should eq true
    flag.clear_admin.should eq nil
    flag.check_admin.should eq false
  end
end
