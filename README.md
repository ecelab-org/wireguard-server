# ecelab/wireguard-server
Wrapper around `linuxserver/wireguard` + `ngoduykhanh/wireguard-ui` docker images.

Super-fast WireGuard server setup.

## Prerequisites:
- Linux kernel &ge;5.6
- docker + docker compose plugin
- make


## Usage
- Clone and setup repo:
  ```
  git clone git@github.com:ecelab-org/wireguard-server.git
  cd wireguard-server
  git update-index --skip-worktree .env
  ```

- Set variables in `.env` file accordingly:
  - `CL_SERVER_DOMAIN` - Domain name (or IP) of the hosting server
  - `CL_UI_PORT` - Listen port for the UI
  - [Optional] `CL_UI_USER`, `CL_UI_PASS` - username and password for accessing the UI

- Build and (re)start the WireGuard server:
  ```
  make
  ```

- Access the UI:
  - Open `CL_SERVER_DOMAIN:CL_UI_PORT` with a browser (substitute with `.env` values)
  - Username and password as set in `.env` (default `admin`/`admin`)

- Shutdown server:
  ```
  make stop
  ```

- Cleanup generated server data files (`./data`):
  ```
  make clean
  ```
