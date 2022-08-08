# Stake Wars: Episode III. 

## Challenge 001

### Create a wallet
https://wallet.shardnet.near.org/

Follow the insttructions

### Setup NEAR-CLI
	
```
#Let's make sure the linux machine is up-to-date.
sudo apt update && sudo apt upgrade -y

# Install developer tools, Node.js, and npm
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install build-essential nodejs
PATH="$PATH"

node -v
> v18.x.x

npm -v
> 8.x.x

# Install NEAR-CLI
sudo npm install -g near-cli
```

### Validator Stats
The environment will need to be set each time a new shell is launched to select the correct network.

```
echo 'export NEAR_ENV=shardnet' >> ~/.bashrc
```

Useful coommands
```
near proposals
near validators current
near validators next
```

## Challenge 002

### Setup your node
#### Server Requirements
Please see the hardware requirement below:

| Hardware       | Chunk-Only Producer  Specifications                                   |
| -------------- | ---------------------------------------------------------------       |
| CPU            | 4-Core CPU with AVX support                                           |
| RAM            | 8GB DDR4                                                              |
| Storage        | 500GB SSD                                                             |

### Select a Cloud server

Let's use a Dedicated sefrver from Hetzner with NVME SSD

![img](./images/hetzner.jpg)

There is no extra cost.

Estimated cost per month: **€40.80**


### Install 
```
# Install developer and buil tools:
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo clang build-essential make

# Install Rust & Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

You will see the following:

![img](./images/rust.png)

Press 1 and press enter.

##### Source the environment
```
source $HOME/.cargo/env
```
