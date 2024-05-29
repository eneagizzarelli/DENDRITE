import time

from client_data import write_client_session_duration_in_seconds

def main():
    session_end_time = time.time()
    
    write_client_session_duration_in_seconds(session_end_time)

if __name__ == "__main__":
    main()