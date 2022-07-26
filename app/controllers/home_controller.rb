class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=0&API_KEY=07BF694B-6467-4E2E-B5BB-1F1B9CD474A7'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    @zipcodesearch = params[:zipcode]

    # Check for empty return result
    if @output.empty?
      @final_output = "Error:"
    elsif !@output
      @final_output = "Error:"      
    else
      @final_output = @output[0]['AQI']
      @report_area = @output[0]['ReportingArea']
    end
    
    if @final_output == "Error"
      @api_color = "red"
      @api_description = @final_output.to_s + ": " + @zipcodesearch+" does not exist"
    elsif @final_output >= 0 && @final_output <= 50
      @api_color = "green"
      @api_description = "Good	(0 to 50) - Air quality is satisfactory, and air pollution poses little or no risk."
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
      @api_description = "Moderate 	(51 to 100) - Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
      @api_description = "Unhealthy for Sensitive Groups	(101 to 150) - Members of sensitive groups may experience health effects. The general public is less likely to be affected."
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
      @api_description = "Unhealthy	(151 to 200) - Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
      @api_description = "Very Unhealthy	(201 to 300) - Health alert: The risk of health effects is increased for everyone."
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
      @api_description = "Hazardous	(301 and higher) - Health warning of emergency conditions: everyone is more likely to be affected."
    end
  end

  def zipcode
    @zip_query = params[:zipcode]
    if params[:zipcode] == ""
      @zip_query = "Please enter a valid zipcode"
    elsif params[:zipcode]
      require 'net/http'
      require 'json'
  
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query + '&distance=0&API_KEY=07BF694B-6467-4E2E-B5BB-1F1B9CD474A7'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
      @zipcodesearch = params[:zipcode]
  
      # Check for empty return result
      if @output.empty?
        @final_output = "Error:"
      elsif !@output
        @final_output = "Error:"      
      else
        @final_output = @output[0]['AQI']
        @report_area = @output[0]['ReportingArea']
      end
      
      if @final_output == "Error"
        @api_color = "red"
        @api_description = @final_output.to_s + ": " + @zipcodesearch+" does not exist"
      elsif @final_output.to_i <= 50
        @api_color = "green"
        @api_description = "Good	(0 to 50) - Air quality is satisfactory, and air pollution poses little or no risk."
      elsif @final_output.to_i >= 51 && @final_output.to_i <= 100
        @api_color = "yellow"
        @api_description = "Moderate 	(51 to 100) - Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
      elsif @final_output.to_i >= 101 && @final_output.to_i <= 150
        @api_color = "orange"
        @api_description = "Unhealthy for Sensitive Groups	(101 to 150) - Members of sensitive groups may experience health effects. The general public is less likely to be affected."
      elsif @final_output.to_i >= 151 && @final_output.to_i <= 200
        @api_color = "red"
        @api_description = "Unhealthy	(151 to 200) - Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
      elsif @final_output.to_i >= 201 && @final_output.to_i <= 300
        @api_color = "purple"
        @api_description = "Very Unhealthy	(201 to 300) - Health alert: The risk of health effects is increased for everyone."
      elsif @final_output.to_i >= 301 && @final_output.to_i <= 500
        @api_color = "maroon"
        @api_description = "Hazardous	(301 and higher) - Health warning of emergency conditions: everyone is more likely to be affected."
      end
    end
  end
end
