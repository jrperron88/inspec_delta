# frozen_string_literal: true

require 'csv'

module InspecDelta
  module Commands
    # This class will take care of operations related to STIG manipulation
    class STIG < Thor
      desc 'checklist', 'Generate a checklist for the STIG controls'
      method_option :stig_file_path,
                    aliases: %w[-s --st],
                    desc: 'The path to the stig file to generate the checklist.',
                    required: true
      method_option :output_path,
                    aliases: %w[-o --out],
                    desc: 'The path to place the file.',
                    required: true
      def checklist
        benchmark = InspecDelta::Parser::Benchmark.get_benchmark(options[:stig_file_path])
        CSV.open(options[:output_path], "wb") do |csv|
          csv << ["Control", "Title", "Status", "Owner", "Group", "JIRA", "Pull Request", "Description","Check", "Fix"]

          benchmark.each do |control_id, control|
            benchmark_control = InspecDelta::Object::Control.from_benchmark(control)
            csv << [benchmark_control.id, benchmark_control.title,"Not Started", "", "", "", "", benchmark_control.descriptions[:default],control[:check],control[:fix]]
          end
        end
      end
    end
  end
end
