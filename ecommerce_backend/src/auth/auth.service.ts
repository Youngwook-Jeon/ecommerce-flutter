import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/user/user.entity';
import { Repository } from 'typeorm';
import { RegisterUserDto } from './dto/register-user.dto';
import { LoginUserDto } from './dto/login-user.dto';
import { compare } from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User) private userRepository: Repository<User>,
    private jwtService: JwtService,
  ) {}

  async register(user: RegisterUserDto) {
    const { email, phone } = user;
    const emailExist = await this.userRepository.findOneBy({ email });
    if (emailExist)
      return new HttpException(
        'Your email was alredy registered.',
        HttpStatus.CONFLICT,
      );

    const phoneExist = await this.userRepository.findOneBy({ phone });
    if (phoneExist)
      return new HttpException(
        'Your phone was alredy registered.',
        HttpStatus.CONFLICT,
      );

    const newUser = this.userRepository.create(user);
    return this.userRepository.save(newUser);
  }

  async login(loginData: LoginUserDto) {
    const { email, password } = loginData;
    const userFound = await this.userRepository.findOneBy({ email });

    if (!userFound)
      return new HttpException(
        'The email does not exist.',
        HttpStatus.NOT_FOUND,
      );

    const isPasswordValid = await compare(password, userFound.password);
    if (!isPasswordValid)
      return new HttpException(
        'The password is incorrect.',
        HttpStatus.UNAUTHORIZED,
      );

    const payload = { id: userFound.id, firstname: userFound.firstname };
    const token = this.jwtService.sign(payload);
    const data = {
      user: userFound,
      token,
    };

    return data;
  }
}
