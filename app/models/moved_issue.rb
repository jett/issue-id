class MovedIssue < ActiveRecord::Base
    include Redmine::SafeAttributes

    belongs_to :issue

    validates_presence_of :issue, :old_key, :old_number
    validates_uniqueness_of :old_number, :scope => :old_key
    validates_length_of :old_key, :in => 1..Project::ISSUE_KEY_MAX_LENGTH
	if Redmine::VERSION::MAJOR >= 3
	    #validates_format_of :old_key, :with => %r{^[A-Z][A-Z0-9]*$}, :multiline => true
            validates_format_of :old_key, :with => %r{\A[A-Z][A-Z0-9]*\z}, :multiline => true
	else
		#validates_format_of :old_key, :with => %r{^[A-Z][A-Z0-9]*$}
                validates_format_of :old_key, :with => %r{\A[A-Z][A-Z0-9]*\z}
	end

    safe_attributes 'issue_id', 'old_key', 'old_number'
end
