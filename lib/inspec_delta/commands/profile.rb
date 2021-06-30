# frozen_string_literal: true

module InspecDelta
  module Commands
    # This class will take care of operations related to profile manipulation
    class Profile < Thor
      desc 'update', 'Update profile from STIG file'
      method_option :profile_path,
                    aliases: %w[-p --pr],
                    desc: 'The path to the directory that contains the profile to modify.',
                    required: true
      method_option :stig_file_path,
                    aliases: %w[-s --st],
                    desc: 'The path to the stig file to apply to the profile.',
                    required: true
      def update
        prof = InspecDelta::Object::Profile.new(options[:profile_path])
        prof.update(options[:stig_file_path])
        prof.format
      end
      desc 'control_checklist', 'Generate a checklist for the STIG controls'
      method_option :stig_file_path,
                    aliases: %w[-s --st],
                    desc: 'The path to the stig file to generate the checklist.',
                    required: true
      method_option :output_path,
                    aliases: %w[-o --out],
                    desc: 'The path to place the file.',
                    required: true
      def control_checklist
        prof = InspecDelta::Object::Profile.new(options[:profile_path])
        prof.update(options[:stig_file_path])
        prof.format
      end
    end
  end
end
