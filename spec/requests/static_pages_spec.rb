require 'spec_helper'

describe "Static pages" do

  subject { page } # now page.should can be replaced by should

  describe "Home page" do

    before { visit root_path} # before is a synonym for before(:each){}

    #it "should have the content 'Sample App'" do
      #visit root_path
      #page.should have_content('Referans Data')
    #end
    it { should have_content('ReferansData') }

    #it "should have the h1 'Referans Data'" do
    #  visit root_path
    #  page.should have_selector('h1', :text => "Referans Data") # :text need not be exact match, any substring would do as well
    #end
    it { should have_selector('h1', text: 'ReferansData') }

    #it "should have the base title" do
      #visit root_path
      #page.should have_selector('title', :text => "Referans Data") # :text need not be exact match, any substring would do as well
    #end
    it { should have_selector('title', text: full_title('') ) }

  end

  describe "Help page" do

    before { visit help_path }

    it { should have_content('ReferansData') }

    it { should have_selector('h1', :text => "ReferansData") } # :text need not be exact match, any substring would do as well


    it { should have_selector('title', :text => full_title('Help') ) } # :text need not be exact match, any substring would do as well

  end

  describe "About page" do

    before { visit about_path }

    it { should have_content("ReferansData") }


    it { should have_selector('h1', :text => "ReferansData") } # :text need not be exact match, any substring would do as well


    it { should have_selector('title', :text => full_title('About Us') ) } # :text need not be exact match, any substring would do as well


  end

  describe "Contact page" do

    before { visit contact_path }

    it { should have_selector('h1', text: "Contact") }

    it { should have_selector('title', text: full_title('Contact') ) } # :text need not be exact match, any substring would do as well

  end

  describe 'for signed-in users' do
    let(:user ) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:post, user: user, content: 'Lorem')
      FactoryGirl.create(:post, user: user, content: 'Ipsum')
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
      end
    end

    describe 'followers/following counts' do
      let(:other_user) { FactoryGirl.create(:user) }
      before do
        other_user.follow!(user)
        visit root_path
      end

      it { should have_link('0 following', href: following_user_path(user)) }
      it { should have_link('1 follower',  href: followers_user_path(user)) }
    end
  end
end
