export class CreateUserDto {
  firstname: string;
  lastname: string;
  email: string;
  phone: string;
  password: string;
  image?: string;
  notification_token?: string;
}
