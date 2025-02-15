
# staking-move-sample

## Giới thiệu

**staking-move-sample** là một module được viết bằng ngôn ngữ Move trên nền tảng Aptos, cho phép người dùng gửi và rút tài sản staking. Dự án cung cấp các chức năng như tạo tài khoản staking, gửi tài sản, rút tài sản, và quản lý các loại token hỗ trợ staking.

## Tính năng chính

-   **Gửi tài sản staking (**`**deposit**`**)**: Người dùng có thể gửi một số lượng token vào tài khoản staking của họ. Nếu tài khoản staking chưa tồn tại, hệ thống sẽ tạo một tài khoản mới và đăng ký token.
    
-   **Rút tài sản staking (**`**withdraw**`**)**: Cho phép người dùng rút số lượng token đã staking.
    
-   **Quản lý các loại token (**`**coins**`**)**: Cung cấp các chức năng tạo và quản lý token như BTC, USDT, bao gồm đúc (`mint`) và ghi (`burn`) token.
    

## Cài đặt và sử dụng

### Yêu cầu hệ thống

-   Máy ảo Move
    
-   Aptos CLI
    
-   Một tài khoản trên mạng Aptos
    

### Triển khai hợp đồng

1.  Clone repository:
    
    ```
    git clone https://github.com/nhan958/staking-move-sample.git
    cd staking-move-sample
    ```
    
2.  Biên dịch module Move:
    
    ```
    aptos move compile
    ```
    
3.  Triển khai hợp đồng lên mạng Aptos:
    
    ```
    aptos move publish --profile default
    ```
    

## Hướng dẫn sử dụng

### Gửi tài sản staking

Người dùng có thể gửi token bằng cách gọi hàm `deposit`:

```
staking_admin::stake::deposit<staking_admin::coins::BTC>(&signer, 1000);
```

### Rút tài sản staking

Để rút tài sản staking, người dùng gọi hàm `withdraw`:

```
staking_admin::stake::withdraw<staking_admin::coins::BTC>(&signer, 500);
```

### Kiểm tra số dư tài khoản

Để kiểm tra số dư tài khoản, sử dụng hàm `balanceOf`:

```
staking_admin::coins::balanceOf<staking_admin::coins::BTC>(address);
```

## Cấu trúc thư mục

```
staking-move-sample/
├── sources/
│   ├── staking.move         # Module quản lý staking
│   ├── simplecoin.move      # Module quản lý token
├── Move.toml              # Cấu hình dự án Move
└── README.md              # Tài liệu hướng dẫn
```

## Lỗi phổ biến và cách khắc phục

Mã lỗi

Mô tả

`0`

Tài khoản staking chưa tồn tại

`1`

Tài khoản staking đã tồn tại

`2`

Tài sản đã được rút

`3`

Chỉ chủ sở hữu mới được phép thực hiện hành động

## Đóng góp

Chúng tôi hoan nghênh mọi đóng góp để cải thiện dự án. Vui lòng gửi pull request hoặc mở issue trên GitHub.

## Giấy phép

Dự án này được phát hành dưới giấy phép MIT.

----------

**Liên hệ**: Nếu có bất kỳ câu hỏi nào, vui lòng liên hệ qua email hoặc mở issue trên GitHub.
