import time
import subprocess

from client_data import initialize_client_data, increment_client_number_of_connections, write_client_session_duration_in_seconds

def main():
    initialize_client_data()
    increment_client_number_of_connections()

    session_start_time = time.time()
    try:
        subprocess.run(['/bin/bash', '--norc', '--noprofile'], check=True)
    except KeyboardInterrupt:
        print("\n", end="")
    except EOFError:
        print("\n", end="")
    print("logout")

    session_end_time = time.time()
    session_duration_in_seconds = session_end_time - session_start_time
    session_duration_in_seconds = round(session_duration_in_seconds, 2)
    
    write_client_session_duration_in_seconds(session_duration_in_seconds)

if __name__ == "__main__":
    main()