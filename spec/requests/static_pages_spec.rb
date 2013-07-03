require 'spec_helper'

describe "Static pages" do
  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_content('Referans Data')
    end

    it "should have the h1 'Referans Data'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => "Referans Data") # :text need not be exact match, any substring would do as well
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Referans Data") # :text need not be exact match, any substring would do as well
    end

    it "should not have a custom page title" do
      visit "/static_pages/home"
      page.should_not have_selector("title", :text => " | Home")
    end
  end

  describe "Help page" do

    it "should have the content 'help'" do
      visit '/static_pages/help'
      page.should have_content('Referans Data')
    end

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => "Referans Data") # :text need not be exact match, any substring would do as well
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "Referans Data | Help") # :text need not be exact match, any substring would do as well
    end

  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content("Referans Data")
    end

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => "Referans Data") # :text need not be exact match, any substring would do as well
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "Referans Data | About Us") # :text need not be exact match, any substring would do as well
    end

  end
end
