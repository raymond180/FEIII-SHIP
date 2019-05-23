import pandas as pd
import numpy as np

def read_data(path='RawData/2018/BillofLadingSummary-2018.csv'):
    # Ignore 'trade_update_date', 'run_date', 'vessel_name', 'secondary_notify_party_1','container_number'
    usecols = ['identifier','port_of_unlading','estimated_arrival_date','foreign_port_of_lading'
               ,'record_status_indicator','place_of_receipt', 'port_of_destination'
               ,'foreign_port_of_destination','actual_arrival_date'
               ,'consignee_name','consignee_address','consignee_contact_name'
               ,'consignee_comm_number_qualifier','consignee_comm_number'
               ,'shipper_party_name', 'shipper_address','shipper_contact_name'
               ,'shipper_comm_number_qualifier','shipper_comm_number'
               ,'description_sequence_number', 'piece_count', 'description_text'
               ,'harmonized_number', 'harmonized_value'
               ,'harmonized_weight','harmonized_weight_unit']
    dtype = {'identifier':str,'port_of_unlading':'category','foreign_port_of_lading':'category'
         ,'record_status_indicator':'category','place_of_receipt':'category'
         ,'port_of_destination':'category','foreign_port_of_destination':'category'
         ,'consignee_name':str,'consignee_address':str,'consignee_contact_name':str
         ,'consignee_comm_number_qualifier':str,'consignee_comm_number':str
         ,'shipper_party_name':str,'shipper_address':str,'shipper_contact_name':str
         ,'shipper_comm_number_qualifier':str,'shipper_comm_number':str
         ,'description_sequence_number':'int16', 'piece_count':'float32', 'description_text':str
         ,'harmonized_number':str, 'harmonized_value':'float32'
         ,'harmonized_weight':'float32','harmonized_weight_unit':'category'}
    parse_dates = ['estimated_arrival_date','actual_arrival_date']
    data= pd.read_csv(path,usecols=usecols,dtype=dtype,parse_dates=parse_dates)
    return data