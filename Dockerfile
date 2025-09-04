FROM alpine:edge

WORKDIR /tmp



RUN apk update
RUN apk add --no-cache git lazygit fzf curl neovim ripgrep alpine-sdk python3 py3-pip npm bash strace make unzip gcc ripgrep  ansible

RUN pip3 install ansible-lint --break-system-packages


RUN adduser nvim -S /bin/bash

USER nvim
RUN git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

COPY init.lua /home/nvim/.config/nvim/init.lua
COPY plugins/* /home/nvim/.config/nvim/lua/custom/plugins/

RUN mkdir /home/nvim/.config/nvim/lua/custom/include
COPY include/* /home/nvim/config/nvim/lua/custom/include/



# allow initialization
RUN timeout 60 nvim --headless || true

RUN nvim --headless -c 'MasonInstall ansible-language-server'  -c qa
RUN nvim --headless -c 'MasonInstall ansible-lint'  -c qa
RUN nvim --headless -c 'MasonInstall bash-language-server'  -c qa
RUN nvim --headless -c 'MasonInstall shellcheck'  -c qa
# RUN nvim --headless -c 'MasonInstall basedpyright'  -c qa



RUN cd /home/nvim

# CMD [ "/bin/bash" ]
