describe Komonjo::Model::User do
  describe 'to_markdown' do
    let(:user) do
      Komonjo::Model::User.create(name: 'test01', profile: { image_48: 'icon_url' })
    end
    subject { user.to_markdown }

    it { is_expected.to eq "* ![test01 icon](icon_url)" }
  end
end
