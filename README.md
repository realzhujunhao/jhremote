# jhremote
aws cli scripts written in bash



### ?

[example](https://mdimage.s3.amazonaws.com/20240223_002209_show.gif)

### !

```bash
git clone https://github.com/realzhujunhao/jhremote.git
cd jhremote
```

#### Bash

```bash
echo "export PATH=\$PATH:$(pwd)/remote" >> ~/.bashrc
echo "export PATH=\$PATH:$(pwd)/tmux" >> ~/.bashrc
echo "export PATH=\$PATH:$(pwd)/util" >> ~/.bashrc
source ~/.bashrc
```

#### Fish

```shell
echo "set -gx PATH $(pwd)/remote \$PATH" >> ~/.config/fish/config.fish
echo "set -gx PATH $(pwd)/tmux \$PATH" >> ~/.config/fish/config.fish
echo "set -gx PATH $(pwd)/util \$PATH" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

### ...

#### Dependencies

- aws cli
- tmux

#### Configurations

> Name is all you need : )

- jhstart

  - name

    <img src="https://mdimage.s3.amazonaws.com/20240223_003306_image-20240223003306110.png" alt="image-20240223003306110" style="zoom:30%;" />

- jhbind

  - your domain name in route53

    <img src="https://mdimage.s3.amazonaws.com/20240223_003610_image-20240223003610182.png" alt="image-20240223003610182" style="zoom:30%;" />

- kafka

  - do not use this
