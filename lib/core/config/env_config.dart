enum Environment { dev, staging, prod }

class EnvConfig {
  EnvConfig._();

  static Environment environment = Environment.dev;

  static String get baseUrl {
    switch (environment) {
      case Environment.dev:
        return 'https://api.dev.example.com';
      case Environment.staging:
        return 'https://api.staging.example.com';
      case Environment.prod:
        return 'https://api.example.com';
    }
  }
}
