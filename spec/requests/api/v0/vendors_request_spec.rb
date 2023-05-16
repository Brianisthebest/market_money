require 'rails_helper'

RSpec.describe 'Vendors API' do
  describe 'GET /api/v0/vendors/:id' do
    it 'returns a specific vendor' do
      vendor = create(:vendor, credit_accepted: false)

      get "/api/v0/vendors/#{vendor.id}"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_an(String)
      expect(json[:data][:id]).to eq(vendor.id.to_s)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('vendor')

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes][:name]).to be_a(String)
      expect(json[:data][:attributes][:name]).to eq(vendor.name)

      expect(json[:data][:attributes]).to have_key(:description)
      expect(json[:data][:attributes][:description]).to be_a(String)
      expect(json[:data][:attributes][:description]).to eq(vendor.description)
      
      expect(json[:data][:attributes]).to have_key(:contact_name)
      expect(json[:data][:attributes][:contact_name]).to be_a(String)
      expect(json[:data][:attributes][:contact_name]).to eq(vendor.contact_name)
      
      expect(json[:data][:attributes]).to have_key(:contact_phone)
      expect(json[:data][:attributes][:contact_phone]).to be_a(String)
      expect(json[:data][:attributes][:contact_phone]).to eq(vendor.contact_phone)

      expect(json[:data][:attributes]).to have_key(:credit_accepted)
      expect(json[:data][:attributes][:credit_accepted]).to be_in([true, false])
      expect(json[:data][:attributes][:credit_accepted]).to eq(vendor.credit_accepted)
    end

    it 'returns a 404 if the vendor is not found' do
      get '/api/v0/vendors/1'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end

  describe 'POST /api/v0/vendors' do
    it 'creates a new vendor' do
      vendor_params = ({ "name": "Test Vendor", 
                        "description": "Test Description", 
                        "contact_name": "Test Contact", 
                        "contact_phone": "Test Phone", 
                        "credit_accepted": true 
                        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)
    
      created_vendor = Vendor.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(created_vendor.name).to eq(vendor_params[:name])
      expect(created_vendor.description).to eq(vendor_params[:description])
      expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
      expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
      expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
    end

    it 'returns an error if missing vendor info' do
      vendor_params = ({ "name": "Test Vendor", 
                        "description": "Test Description", 
                        "contact_name": "Test Contact" 
                        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors][0][:detail]).to eq("Validations failed: Contact phone can't be blank and Credit accepted is not included in the list")
    end
  end

  describe 'PATCH /api/v0/vendors/:id' do
    it 'updates a vendor' do
      vendor_id = create(:vendor).id
      previous_name = Vendor.last.name
      vendor_params = { name: "New Vendor Name" }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v0/vendors/#{vendor_id}", headers: headers, params: JSON.generate({vendor: vendor_params})
      vendor = Vendor.find_by(id: vendor_id)

      expect(response).to be_successful
      expect(vendor.name).to_not eq(previous_name)
      expect(vendor.name).to eq("New Vendor Name")
    end

    it 'returns an error if vendor field is nil' do
      vendor_id = create(:vendor).id
      vendor_params = { name: nil }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v0/vendors/#{vendor_id}", headers: headers, params: JSON.generate({vendor: vendor_params})
      vendor = Vendor.find_by(id: vendor_id)

      expect(response).to_not be_successful
      expect(vendor.name).to_not eq(nil)
      expect(response.status).to eq(400)

      json = JSON.parse(body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors][0][:detail]).to eq("Validations failed: Name can't be blank")
    end

    it 'returns an error if vendor can not be found' do
      patch "/api/v0/vendors/9999999999"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors][0][:detail]).to eq('Couldn\'t find Vendor with \'id\'=9999999999')
    end
  end
end