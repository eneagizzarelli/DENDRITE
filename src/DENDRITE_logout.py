import os
import time
import json

def get_client_ip():
    ssh_connection_info = os.environ.get("SSH_CLIENT")

    if ssh_connection_info:
        client_ip = ssh_connection_info.split()[0]
    # TODO: handle cases in which IP address not available
    else:
        raise KeyboardInterrupt

    return client_ip

client_ip = get_client_ip()

logs_ip_path = "/home/enea/DENDRITE/logs/" + client_ip
logs_ip_data_path = logs_ip_path + "/" + client_ip + "_data.json"
database_path = "/home/enea/DENDRITE/data/GeoLite2-City.mmdb"

def write_client_session_duration_in_seconds(session_end_time):
    with open(logs_ip_data_path, "r") as client_data_file:
        data = json.load(client_data_file)
    
    session_start_time = data["session_durations_in_seconds"][-1]
    session_duration_in_seconds = session_end_time - session_start_time
    session_duration_in_seconds = round(session_duration_in_seconds, 2)
        
    data["session_durations_in_seconds"][-1] = session_duration_in_seconds

    with open(logs_ip_data_path, "w") as client_data_file:
        json.dump(data, client_data_file, indent=4)
        client_data_file.write("\n")

def main():
    session_end_time = time.time()
    
    write_client_session_duration_in_seconds(session_end_time)

if __name__ == "__main__":
    main()