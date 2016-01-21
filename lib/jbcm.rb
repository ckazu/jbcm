require 'jbcm/version'
require 'faraday'
require 'json'
require 'ox'

module Jbcm
  class Client
    attr_reader :user_name, :api_token, :password, :scheme, :hostname, :port

    def initialize(opts = {})
      @user_name = opts[:user_name]
      @api_token = opts[:api_token]
      @api_token = opts[:password] if opts[:password]
      @scheme = opts[:scheme] || 'https'
      @hostname = opts[:hostname]
      @port = opts[:port] || '443'
    end

    def conn
      conn ||= Faraday::Connection.new(url: "#{scheme}://#{user_name}:#{api_token}@#{hostname}:#{port}") do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Adapter::NetHttp
      end
    end

    def jobs(opts={})
      Jbcm::Client::Job.new(self).list(opts)
    end

    def job(job_name)
      Jbcm::Client::Job.new(self, job_name)
    end

    class Job
      attr_reader :cli, :job_name

      def initialize(cli, job_name = nil)
        @cli = cli
        @job_name = job_name
      end

      def list(raw: false)
        response = cli.conn.get('api/json')
        if raw
          JSON.parse(response.body)
        else
          JSON.parse(response.body)['jobs']
        end
      end

      def config
        @config ||= Ox.parse(cli.conn.get("job/#{job_name}/config.xml").body)
      end

      def build_command
        config.project.builders.send('hudson.tasks.Shell').command.nodes
      end

      def build_commnad=(build_command)
        config.project.builders.send('hudson.tasks.Shell').command.nodes.pop
        config.project.builders.send('hudson.tasks.Shell').command.nodes.push(build_command)
      end

      def update
        cli.conn.post do |req|
          req.url "job/#{job_name}/config.xml"
          req.headers['Content-Type'] = 'application/xml'
          req.body = Ox.dump(config)
        end
      end

      def update!
        request_result = update
        if request_result.status == 200
          $stdout.puts 'update successfully.'
        else
          fail "Update failed! return #{request_result.status}"
        end
      end
    end
  end
end
