"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const core_1 = require("@nestjs/core");
const mongoose_1 = require("@nestjs/mongoose");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const auth_module_1 = require("./auth/auth.module");
const role_guard_1 = require("./auth/roles/role.guard");
const user_schema_1 = require("./auth/schemas/user.schema");
const comment_module_1 = require("./comments/comment.module");
const items_module_1 = require("./items/items.module");
const user_controller_1 = require("./user/user.controller");
const user_module_1 = require("./user/user.module");
const user_service_1 = require("./user/user.service");
let AppModule = class AppModule {
};
exports.AppModule = AppModule;
exports.AppModule = AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            mongoose_1.MongooseModule.forFeature([{ name: 'User', schema: user_schema_1.UserSchema }]),
            config_1.ConfigModule.forRoot({
                envFilePath: '.env',
                isGlobal: true,
            }),
            mongoose_1.MongooseModule.forRoot(process.env.DB_URL),
            user_module_1.UserModule,
            items_module_1.ItemsModule,
            auth_module_1.AuthModule,
            user_module_1.UserModule,
            comment_module_1.CommentModule
        ],
        controllers: [app_controller_1.AppController, user_controller_1.UserController],
        providers: [app_service_1.AppService, {
                provide: core_1.APP_GUARD,
                useClass: role_guard_1.RolesGuard,
            }, user_service_1.UserService],
    })
], AppModule);
//# sourceMappingURL=app.module.js.map