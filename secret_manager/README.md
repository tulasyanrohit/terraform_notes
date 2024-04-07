TASK:
Do not use secrets directly when creating resources.
Instead use AWS Secret Manager to access the credentials.

NOTE:
In this example terraform is using "local" backend but it is suggested to use some cloud backend like AWS s3

Step 01-A:
First Create a Secret Manager
<img width="1217" alt="image" src="https://github.com/tulasyanrohit/terraform_notes/assets/159639918/b836d721-79b8-476a-bef2-0c66e7f00eed">

Step 01-B:
Enter key-pair values
<img width="1142" alt="image" src="https://github.com/tulasyanrohit/terraform_notes/assets/159639918/f77c4c37-a71d-44b7-be9d-426f3b4ea3cb">

Step 01-C:
Give a name to your secret [Note this name will used in terraform to connect to this secret]
<img width="1050" alt="image" src="https://github.com/tulasyanrohit/terraform_notes/assets/159639918/1141a294-732e-43bd-a71c-b1d108c58f50">

Step 01-D:
Keep rest everthing as default
