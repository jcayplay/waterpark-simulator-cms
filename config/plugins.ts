export default ({ env }) => ({
    // Email plugin configuration
    email: {
        config: {
            provider: 'amazon-ses',
            providerOptions: {
                key: env('AWS_SES_KEY'),
                secret: env('AWS_SES_SECRET'),
                amazon: `https://email.${env('AWS_SES_REGION', 'us-east-1')}.amazonaws.com`, // https://docs.aws.amazon.com/general/latest/gr/ses.html
            },
            settings: {
                defaultFrom: 'no-reply@thaliatrandesign.com',
                defaultReplyTo: 'no-reply@thaliatrandesign.com',
            },
        },
    },
});