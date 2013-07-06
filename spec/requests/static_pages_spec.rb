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
end
