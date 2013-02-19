require "faraday"

module RaygunRuby
  class RaygunClient


    def self.send_exception(exception, tags=nil, userCustomData=nil, env=nil)
      msg = self.build_message(exception, env)
      self.send_msg(msg)

    end

    def self.build_message(errorException, env)

      message = RaygunMessage.new()
      message.build(errorException, env)

    end

    def self.send_msg(message)
      begin
        apiKey = RaygunRuby::Config::read["apiKey"]
      rescue 
        raise "API_KEY not valid, cannot send message to Raygun"
      end
      bdy = message.to_json

        connection = Faraday.new 'https://api.raygun.io', :ssl => {:ca_file => "../../vendor/cacert.crt"} do |faraday|
            faraday.response :logger                  # log requests to STDOUT
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

        request = connection.post do |req|
          req.url "/entries"
          req.headers["X-ApiKey"] = apiKey
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.headers['User-Agent'] = "Hai Raygun"
          req.body = bdy

        end

        puts request.body

              

    end


  end
end





=begin
    public function __construct($key)
    {
        $this->apiKey = $key;
    }

   
    * Transmits an error to the Raygun.io API
    * @param int $errorno The error number
    * @param string $errstr The error string
    * @param string $errfile The file the error occurred in
    * @param int $errline The line the error occurred on
    * @param array $tags An optional array of string tags used to provide metadata for the message
    * @param array $userCustomData An optional associative array that can be used to place custom key-value
    * data in the message payload
    * @return The HTTP status code of the result when transmitting the message to Raygun.io

    public function SendError($errno, $errstr, $errfile, $errline, $tags = null, $userCustomData = null)
    {
      $message = $this->BuildMessage(new \ErrorException($errstr, $errno, 0, $errfile, $errline));

      if ($tags != null)
      {
          $this->AddTags($message, $tags);
      }
      if ($userCustomData != null)
      {
          $this->AddUserCustomData($message, $userCustomData);
      }
      return $this->Send($message);
    }
=end
=begin
    /*
    * Transmits an exception to the Raygun.io API
    * @param \Exception $exception An exception object to transmit
    * @param array $tags An optional array of string tags used to provide metadata for the message
    * @param array $userCustomData An optional associative array that can be used to place custom key-value
    * data in the message payload
    * @return The HTTP status code of the result when transmitting the message to Raygun.io
    */
    public function SendException($exception, $tags = null, $userCustomData = null)
    {
      $message = $this->BuildMessage($exception);

      if ($tags != null)
      {
          $this->AddTags($message, $tags);
      }
      if ($userCustomData != null)
      {
          $this->AddUserCustomData($message, $userCustomData);
      }

      $result = $this->Send($message);
      return $result;
    }
=end
=begin
    /*
     * Sets the version number of your project that will be transmitted
     * to Raygun.io.
     * @param string $version The version number in the form of x.x.x.x,
     * where x is a positive integer.
     *
     */
    public function SetVersion($version)
    {
        $this->version = $version;
    }
=end
=begin
    /*
     * Sets a string array of tags relating to the message,
     * used for identification. These will be transmitted along with messages that
     * are sent.
     * @param array $tags The tags relating to your project's version
    */
    private function BuildMessage($errorException)
    {
        $message = new RaygunMessage();
        $message->Build($errorException);
        $message->Details->Version = $this->version;
        return $message;
    }

    private function AddTags(&$message, $tags)
    {
        if (is_array($tags))
        {
            $message->Details->Tags = $tags;
        }
        else
        {
            throw new \Raygun4php\Raygun4PhpException("Tags must be an array");
        }
    }

    private function AddUserCustomData(&$message, $userCustomData)
    {
        if ($this->is_assoc($userCustomData))
        {
            $message->Details->UserCustomData = $userCustomData;
        }
        else
        {
            throw new \Raygun4php\Raygun4PhpException("UserCustomData must be an associative array");
        }
    }

    private function is_assoc($array) {
      return (bool)count(array_filter(array_keys($array), 'is_string'));
    }
=end
=begin
    /*
     * Transmits an exception or ErrorException to the Raygun.io API
     * @throws Raygun4php\Raygun4PhpException
     * @param \ErrorException $errorException
     * @return The HTTP status code of the result after transmitting the message to Raygun.io
     * 200 if accepted, 403 if invalid JSON payload
     */
    public function Send($message)
    {
        if (empty($this->apiKey))
        {
            throw new \Raygun4php\Raygun4PhpException("API not valid, cannot send message to Raygun");
        }

        $httpData = curl_init('https://api.raygun.io/entries');
        curl_setopt($httpData, CURLOPT_POSTFIELDS, json_encode($message));
        curl_setopt($httpData, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($httpData, CURLINFO_HEADER_OUT, true);
        curl_setopt($httpData, CURLOPT_CAINFO, realpath(__DIR__.'/cacert.crt'));
        curl_setopt($httpData, CURLOPT_HTTPHEADER, array(
            'X-ApiKey: '.$this->apiKey
        ));

        curl_exec($httpData);
        $info = curl_getinfo($httpData);

        curl_close($httpData);
        return $info['http_code'];
    }
  }
}
=end