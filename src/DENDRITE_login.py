import time

from client_data import initialize_client_data, increment_client_number_of_connections

def main():
    # start session timer
    session_start_time = time.time()

    # the following functions have self-explanatory names and are executed for the 
    # IP address of the client that is currently connected
    initialize_client_data(session_start_time)
    increment_client_number_of_connections()

if __name__ == "__main__":
    main()