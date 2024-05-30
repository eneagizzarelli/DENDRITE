import time

from client_data import initialize_client_data, increment_client_number_of_connections

def main():
    session_start_time = time.time()

    initialize_client_data(session_start_time)
    increment_client_number_of_connections()

if __name__ == "__main__":
    main()