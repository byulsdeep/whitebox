# White Box

White Boxへようこそ！White Boxは、オンラインでギフトを購入しながら、ソーシャルネットワークの環境で友達とつながることができるアプリです。
<br /><img src="docs/whitebox.gif" alt="White Box GIF" width="800">

## 概要

White Boxでは、販売者と顧客が完全に分離されており、販売者は商品の登録と販売にのみ責任を持ちます。顧客は他の顧客を友達として追加し、友達関係を築くことができます。顧客は販売者から商品を購入し、友達にギフトを送ることもできます。さらに、友達は送ったり受け取ったりしたギフトを表示することができます。

## 特徴

- 販売者と顧客が完全に分離されています。
- 顧客はお互いを友達として追加することができます。
- 顧客は販売者から商品を購入できます。
- 顧客は友達にギフトを送ることができます。
- 友達は送ったり受け取ったりしたギフトを表示することができます。

## 技術スタック

- フレームワーク：Spring MVC
- データベース：Oracle XE 11gR2
- サーバー：Apache Tomcat 9.0
- 言語：Java、JavaScript、jQuery、SQL、HTML、CSS

## 主な依存関係

- Spring Security
- メール認証
- LINEログイン
- Googleログイン
- Kakaoログイン
- SHA-1暗号化
- AES256エンコーディング
- ファイルのアップロード

## プロジェクトの詳細

- リーダー：[カンハンビョル]
- チーム人数：5人
- ジョブ数：65個
- ページ数：34ページ
- テーブル数：14個
- クラス数：49個
- 開発期間：2023.04.13 ~ 2023.05.30

## インストール

- リポジトリをクローンします。ファイルアップロードのため、ディレクトリは"C:/whitebox_workspace/whiteboxx"にしてください。
- Oracle XE 11gR2データベースをセットアップし、接続の詳細を設定します。
- ソーシャルログインおよびPayPal購入のためのAPIキーを取得します:
   - **Googleログイン**:
     - [Google Cloud Console](https://console.cloud.google.com/)にアクセスします。
     - 新しいプロジェクトを作成するか、既存のプロジェクトを選択します。
     - 必要なAPIを有効にします（Google Sign-In APIなど）。
     - OAuth認証情報を作成し、クライアントIDとクライアントシークレットを取得します。
   - **Kakaoログイン**:
     - [Kakao Developers](https://developers.kakao.com/)のウェブサイトにアクセスします。
     - 新しいアプリケーションを作成するか、既存のアプリケーションを選択します。
     - Kakao REST APIキーを取得します。
   - **LINEログイン**:
     - [LINE Developers](https://developers.line.biz/)のウェブサイトにアクセスします。
     - 新しいチャネルを作成するか、既存のチャネルを選択します。
     - LINEチャネルIDとチャネルシークレットを取得します。
   - **PayPal購入**:
     - PayPalビジネスアカウントにサインアップします（まだお持ちでない場合）。
     - PayPal APIクレデンシャル（クライアントIDとシークレット）を取得します。
- APIキーを以下のファイルに更新します：
   - `GoogleAuthentication.java`
   - `KakaoAuthentication.java`
   - `LineAuthentication.java`
   - `Service_BYUL`
   - `login.jsp`
- root-context.xmlでSMTP設定をします。
- プロジェクトをApache Tomcat 9.0にデプロイします。
- 提供されたURLを使用してアプリケーションにアクセスします。

## 使用方法

1. 販売者または顧客として登録します。
2. ログイン方法を選択してログインします（メール、LINE、Google、Kakao）。
3. 他の顧客を友達として追加し、友達関係を築きます。
4. 販売者がリストアップした商品を閲覧し、購入します。
5. 友達にギフトを送ります。
6. 送受信したギフトを表示します。

## 貢献者

- [カンハンビョル]（チームリーダー）
- [グォンダンビ]
- [グォンヒョクヒョン]
- [キムウンジ]
- [ソスンヨン]

## ライセンス

ここに書くべきものがわかりません :p

# White Box

Welcome to White Box! White Box allows you to shop for gifts online while connecting with your friends in a social network environment. 

## Overview

In White Box, sellers and customers are completely separated, with sellers solely responsible for registering and selling their products. Customers can add other customers as friends and establish friend relationships. Customers can purchase products from sellers and even send gifts to their friends. Moreover, friends can view the gifts they have sent and received.

## Features

- Sellers and customers are fully separated.
- Customers can add each other as friends.
- Customers can purchase products from sellers.
- Customers can send gifts to their friends.
- Friends can view the gifts they have sent and received.

## Technology Stack

- Framework: Spring MVC
- Database: Oracle XE 11gR2
- Server: Apache Tomcat 9.0
- Languages: Java, JavaScript, jQuery, SQL, HTML, CSS

## Key Dependencies

- Spring Security
- Email authentication
- LINE login
- Google login
- Kakao login
- SHA-1 encryption
- AES256 encoding
- File upload

## Project Details

- Leader: [Kang Han Byul]
- Team Size: 5
- Jobs: 65
- Pages: 34
- Tables: 14
- Classes: 49
- Development Period: 2023.04.13 ~ 2023.05.30

## Installation

- Clone the repository. Save the project to "C:/whitebox_workspace/whiteboxx" for file uploads to work properly.
- Set up the Oracle XE 11gR2 database and configure the connection details.
- Obtain API keys for social logins and PayPal purchase:
  - **Google Authentication**:
    - Go to the [Google Cloud Console](https://console.cloud.google.com/).
    - Create a new project or select an existing one.
    - Enable the necessary APIs (e.g., Google Sign-In API).
    - Create OAuth credentials and obtain the client ID and client secret.
  - **Kakao Authentication**:
    - Go to the [Kakao Developers](https://developers.kakao.com/) website.
    - Create a new application or select an existing one.
    - Obtain the Kakao REST API key.
  - **LINE Authentication**:
    - Go to the [LINE Developers](https://developers.line.biz/) website.
    - Create a new channel or select an existing one.
    - Obtain the LINE Channel ID and Channel Secret.
  - **PayPal Purchase**:
    - Sign up for a PayPal account (if you don't have one already).
    - Obtain the PayPal API credentials (client ID and secret).
- Update the API keys in the following files:
  - `GoogleAuthentication.java`
  - `KakaoAuthentication.java`
  - `LineAuthentication.java`
  - `Service_BYUL`
  - `login.jsp`
- Set up SMTP settings in root-context.xml.
- Deploy the project on Apache Tomcat 9.0.
- Access the application through the provided URL.

## Usage

1. Register as a seller or customer.
2. Log in using your preferred login method (email, LINE, Google, Kakao).
3. Add other customers as friends and establish friend relationships.
4. Browse products listed by sellers and make purchases.
5. Send gifts to your friends.
6. View the gifts you have sent and received from your friends.

## Contributors

- [Kang Han Byul] (Team Leader)
- [Kwon Dan Bi]
- [Kwon Hyuk Hyun]
- [Kim Eun Ji]
- [So Sun Yeong]

## License

I don't know what to write here :p
