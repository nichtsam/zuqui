const _appEnv = String.fromEnvironment("APP_ENV");
const _coreApiUrl = String.fromEnvironment("CORE_API_URL");

enum AppEnv { local, prod }

sealed class Env {
  static final appEnv = AppEnv.values.firstWhere(
    (e) => e.name == _appEnv,
    orElse: () => throw StateError('Invalid environment: APP_ENV'),
  );
  static const coreApiUrl = _coreApiUrl;
}
