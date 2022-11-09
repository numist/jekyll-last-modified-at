# frozen_string_literal: true

require 'spec_helper'

describe 'Date Tag' do
  context 'A committed post file' do
    def setup(file, layout)
      @post = setup_post(file)
      do_render(@post, layout)
    end

    it 'has date' do
      setup('no-date.md', 'date_with_format.html')
      expect(@post.output).to match(/Article created on 09-Nov-22/)
    end
  end

  context 'An uncommitted post file' do
    before(:all) do
      cheater_file = 'no-date.md'
      uncommitted_file = 'date_no.md'
      duplicate_post(cheater_file, uncommitted_file)
      @post = setup_post(uncommitted_file)
      do_render(@post, 'date_with_format.html')
    end

    it 'has date' do
      expect(@post.output).to match(Regexp.new("Article created on #{Time.new.utc.strftime('%d-%b-%y')}"))
    end
  end
end
