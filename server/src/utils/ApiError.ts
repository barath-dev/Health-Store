class ApiError extends Error {

    status:string;
    statusCode:number;
    isOperational:boolean;

    constructor(status:string, statusCode:number, message:string, isOperational:boolean) {
        super(message);
        this.status = status;
        this.statusCode = statusCode;
        this.isOperational = isOperational;

        Error.captureStackTrace(this, this.constructor);
    }

    static badRequest(msg:string) {
        return new ApiError('error', 400, msg, true);
    }

    static internal(msg:string) {
        return new ApiError('error', 500, msg, true);
    }

    static forbidden(msg:string) {
        return new ApiError('error', 403, msg, true);
    }

    static notFound(msg:string) {
        return new ApiError('error', 404, msg, true);
    }

    static conflict(msg:string) {
        return new ApiError('error', 409, msg, true);
    }

    static unauthorized(msg:string) {
        return new ApiError('error', 401, msg, true);
    }
}

export default ApiError;