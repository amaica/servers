--
-- PostgreSQL database dump
--

\restrict AfnUCq3nQq0uTdqz4EkaHI8QopO2o4tfseUXh9XduDO96fYYWJvN48Jh40ApLQh

-- Dumped from database version 14.20 (Debian 14.20-1.pgdg13+1)
-- Dumped by pg_dump version 14.20 (Debian 14.20-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DeviceMessage; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DeviceMessage" AS ENUM (
    'ios',
    'android',
    'web',
    'unknown',
    'desktop'
);


ALTER TYPE public."DeviceMessage" OWNER TO postgres;

--
-- Name: DifyBotType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DifyBotType" AS ENUM (
    'chatBot',
    'textGenerator',
    'agent',
    'workflow'
);


ALTER TYPE public."DifyBotType" OWNER TO postgres;

--
-- Name: InstanceConnectionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."InstanceConnectionStatus" AS ENUM (
    'open',
    'close',
    'connecting'
);


ALTER TYPE public."InstanceConnectionStatus" OWNER TO postgres;

--
-- Name: OpenaiBotType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OpenaiBotType" AS ENUM (
    'assistant',
    'chatCompletion'
);


ALTER TYPE public."OpenaiBotType" OWNER TO postgres;

--
-- Name: SessionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SessionStatus" AS ENUM (
    'opened',
    'closed',
    'paused'
);


ALTER TYPE public."SessionStatus" OWNER TO postgres;

--
-- Name: TriggerOperator; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TriggerOperator" AS ENUM (
    'contains',
    'equals',
    'startsWith',
    'endsWith',
    'regex'
);


ALTER TYPE public."TriggerOperator" OWNER TO postgres;

--
-- Name: TriggerType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TriggerType" AS ENUM (
    'all',
    'keyword',
    'none',
    'advanced'
);


ALTER TYPE public."TriggerType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Chat" (
    id text NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    labels jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "instanceId" text NOT NULL,
    name character varying(100),
    "unreadMessages" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Chat" OWNER TO postgres;

--
-- Name: Chatwoot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Chatwoot" (
    id text NOT NULL,
    enabled boolean DEFAULT true,
    "accountId" character varying(100),
    token character varying(100),
    url character varying(500),
    "nameInbox" character varying(100),
    "signMsg" boolean DEFAULT false,
    "signDelimiter" character varying(100),
    number character varying(100),
    "reopenConversation" boolean DEFAULT false,
    "conversationPending" boolean DEFAULT false,
    "mergeBrazilContacts" boolean DEFAULT false,
    "importContacts" boolean DEFAULT false,
    "importMessages" boolean DEFAULT false,
    "daysLimitImportMessages" integer,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    logo character varying(500),
    organization character varying(100),
    "ignoreJids" jsonb
);


ALTER TABLE public."Chatwoot" OWNER TO postgres;

--
-- Name: Contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contact" (
    id text NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "pushName" character varying(100),
    "profilePicUrl" character varying(500),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Contact" OWNER TO postgres;

--
-- Name: Dify; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dify" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "botType" public."DifyBotType" NOT NULL,
    "apiUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    description character varying(255),
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."Dify" OWNER TO postgres;

--
-- Name: DifySetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DifySetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "difyIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."DifySetting" OWNER TO postgres;

--
-- Name: Evoai; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Evoai" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "agentUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Evoai" OWNER TO postgres;

--
-- Name: EvoaiSetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EvoaiSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "evoaiIdFallback" character varying(100),
    "instanceId" text NOT NULL
);


ALTER TABLE public."EvoaiSetting" OWNER TO postgres;

--
-- Name: EvolutionBot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EvolutionBot" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "apiUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."EvolutionBot" OWNER TO postgres;

--
-- Name: EvolutionBotSetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EvolutionBotSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "botIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."EvolutionBotSetting" OWNER TO postgres;

--
-- Name: Flowise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Flowise" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "apiUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."Flowise" OWNER TO postgres;

--
-- Name: FlowiseSetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlowiseSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "flowiseIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."FlowiseSetting" OWNER TO postgres;

--
-- Name: Instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Instance" (
    id text NOT NULL,
    name character varying(255) NOT NULL,
    "connectionStatus" public."InstanceConnectionStatus" DEFAULT 'open'::public."InstanceConnectionStatus" NOT NULL,
    "ownerJid" character varying(100),
    "profilePicUrl" character varying(500),
    integration character varying(100),
    number character varying(100),
    token character varying(255),
    "clientName" character varying(100),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "profileName" character varying(100),
    "businessId" character varying(100),
    "disconnectionAt" timestamp without time zone,
    "disconnectionObject" jsonb,
    "disconnectionReasonCode" integer
);


ALTER TABLE public."Instance" OWNER TO postgres;

--
-- Name: IntegrationSession; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IntegrationSession" (
    id text NOT NULL,
    "sessionId" character varying(255) NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "pushName" text,
    status public."SessionStatus" NOT NULL,
    "awaitUser" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    parameters jsonb,
    context jsonb,
    "botId" text,
    type character varying(100)
);


ALTER TABLE public."IntegrationSession" OWNER TO postgres;

--
-- Name: IsOnWhatsapp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IsOnWhatsapp" (
    id text NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "jidOptions" text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    lid character varying(100)
);


ALTER TABLE public."IsOnWhatsapp" OWNER TO postgres;

--
-- Name: Kafka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kafka" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Kafka" OWNER TO postgres;

--
-- Name: Label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Label" (
    id text NOT NULL,
    "labelId" character varying(100),
    name character varying(100) NOT NULL,
    color character varying(100) NOT NULL,
    "predefinedId" character varying(100),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Label" OWNER TO postgres;

--
-- Name: Media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Media" (
    id text NOT NULL,
    "fileName" character varying(500) NOT NULL,
    type character varying(100) NOT NULL,
    mimetype character varying(100) NOT NULL,
    "createdAt" date DEFAULT CURRENT_TIMESTAMP,
    "messageId" text NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Media" OWNER TO postgres;

--
-- Name: Message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Message" (
    id text NOT NULL,
    key jsonb NOT NULL,
    "pushName" character varying(100),
    participant character varying(100),
    "messageType" character varying(100) NOT NULL,
    message jsonb NOT NULL,
    "contextInfo" jsonb,
    source public."DeviceMessage" NOT NULL,
    "messageTimestamp" integer NOT NULL,
    "chatwootMessageId" integer,
    "chatwootInboxId" integer,
    "chatwootConversationId" integer,
    "chatwootContactInboxSourceId" character varying(100),
    "chatwootIsRead" boolean,
    "instanceId" text NOT NULL,
    "webhookUrl" character varying(500),
    "sessionId" text,
    status character varying(30)
);


ALTER TABLE public."Message" OWNER TO postgres;

--
-- Name: MessageUpdate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MessageUpdate" (
    id text NOT NULL,
    "keyId" character varying(100) NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "fromMe" boolean NOT NULL,
    participant character varying(100),
    "pollUpdates" jsonb,
    status character varying(30) NOT NULL,
    "messageId" text NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."MessageUpdate" OWNER TO postgres;

--
-- Name: N8n; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."N8n" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "webhookUrl" character varying(255),
    "basicAuthUser" character varying(255),
    "basicAuthPass" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."N8n" OWNER TO postgres;

--
-- Name: N8nSetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."N8nSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "n8nIdFallback" character varying(100),
    "instanceId" text NOT NULL
);


ALTER TABLE public."N8nSetting" OWNER TO postgres;

--
-- Name: Nats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Nats" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Nats" OWNER TO postgres;

--
-- Name: OpenaiBot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenaiBot" (
    id text NOT NULL,
    "assistantId" character varying(255),
    model character varying(100),
    "systemMessages" jsonb,
    "assistantMessages" jsonb,
    "userMessages" jsonb,
    "maxTokens" integer,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "openaiCredsId" text NOT NULL,
    "instanceId" text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "botType" public."OpenaiBotType" NOT NULL,
    description character varying(255),
    "functionUrl" character varying(500),
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."OpenaiBot" OWNER TO postgres;

--
-- Name: OpenaiCreds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenaiCreds" (
    id text NOT NULL,
    "apiKey" character varying(255),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    name character varying(255)
);


ALTER TABLE public."OpenaiCreds" OWNER TO postgres;

--
-- Name: OpenaiSetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenaiSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "openaiCredsId" text NOT NULL,
    "openaiIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "speechToText" boolean DEFAULT false,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."OpenaiSetting" OWNER TO postgres;

--
-- Name: Proxy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Proxy" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    host character varying(100) NOT NULL,
    port character varying(100) NOT NULL,
    protocol character varying(100) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Proxy" OWNER TO postgres;

--
-- Name: Pusher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pusher" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    "appId" character varying(100) NOT NULL,
    key character varying(100) NOT NULL,
    secret character varying(100) NOT NULL,
    cluster character varying(100) NOT NULL,
    "useTLS" boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Pusher" OWNER TO postgres;

--
-- Name: Rabbitmq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rabbitmq" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Rabbitmq" OWNER TO postgres;

--
-- Name: Session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Session" (
    id text NOT NULL,
    "sessionId" text NOT NULL,
    creds text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Session" OWNER TO postgres;

--
-- Name: Setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Setting" (
    id text NOT NULL,
    "rejectCall" boolean DEFAULT false NOT NULL,
    "msgCall" character varying(100),
    "groupsIgnore" boolean DEFAULT false NOT NULL,
    "alwaysOnline" boolean DEFAULT false NOT NULL,
    "readMessages" boolean DEFAULT false NOT NULL,
    "readStatus" boolean DEFAULT false NOT NULL,
    "syncFullHistory" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "wavoipToken" character varying(100)
);


ALTER TABLE public."Setting" OWNER TO postgres;

--
-- Name: Sqs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sqs" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Sqs" OWNER TO postgres;

--
-- Name: Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Template" (
    id text NOT NULL,
    "templateId" character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    template jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "webhookUrl" character varying(500)
);


ALTER TABLE public."Template" OWNER TO postgres;

--
-- Name: Typebot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Typebot" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    url character varying(500) NOT NULL,
    typebot character varying(100) NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "triggerType" public."TriggerType",
    "triggerOperator" public."TriggerOperator",
    "triggerValue" text,
    "instanceId" text NOT NULL,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    description character varying(255),
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."Typebot" OWNER TO postgres;

--
-- Name: TypebotSetting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TypebotSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "debounceTime" integer,
    "typebotIdFallback" character varying(100),
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE public."TypebotSetting" OWNER TO postgres;

--
-- Name: View_Contacts_With_Groups; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."View_Contacts_With_Groups" AS
 SELECT c.id,
    c."remoteJid",
    c."pushName",
    ch.name AS "chatName",
        CASE
            WHEN (((c."pushName" IS NULL) OR (btrim((c."pushName")::text) = ''::text)) AND ((c."remoteJid")::text ~~ '%@lid'::text)) THEN ch.name
            ELSE c."pushName"
        END AS name,
    c."profilePicUrl",
    c."createdAt",
    c."updatedAt",
    c."instanceId",
    (COALESCE(i.name, ''::character varying))::text AS instance_name
   FROM ((public."Contact" c
     LEFT JOIN public."Chat" ch ON (((ch."remoteJid")::text = (c."remoteJid")::text)))
     LEFT JOIN public."Instance" i ON ((i.id = c."instanceId")))
  WHERE ((
        CASE
            WHEN (((c."pushName" IS NULL) OR (btrim((c."pushName")::text) = ''::text)) AND ((c."remoteJid")::text ~~ '%@lid'::text)) THEN ch.name
            ELSE c."pushName"
        END IS NOT NULL) AND (btrim((
        CASE
            WHEN (((c."pushName" IS NULL) OR (btrim((c."pushName")::text) = ''::text)) AND ((c."remoteJid")::text ~~ '%@lid'::text)) THEN ch.name
            ELSE c."pushName"
        END)::text) <> ''::text) AND ((
        CASE
            WHEN (((c."pushName" IS NULL) OR (btrim((c."pushName")::text) = ''::text)) AND ((c."remoteJid")::text ~~ '%@lid'::text)) THEN ch.name
            ELSE c."pushName"
        END)::text ~ '[a-zA-Z]'::text))
  ORDER BY
        CASE
            WHEN ((c."remoteJid")::text ~~ '%@g.us'::text) THEN 1
            ELSE 0
        END, (btrim((
        CASE
            WHEN (((c."pushName" IS NULL) OR (btrim((c."pushName")::text) = ''::text)) AND ((c."remoteJid")::text ~~ '%@lid'::text)) THEN ch.name
            ELSE c."pushName"
        END)::text));


ALTER TABLE public."View_Contacts_With_Groups" OWNER TO postgres;

--
-- Name: Webhook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Webhook" (
    id text NOT NULL,
    url character varying(500) NOT NULL,
    enabled boolean DEFAULT true,
    events jsonb,
    "webhookByEvents" boolean DEFAULT false,
    "webhookBase64" boolean DEFAULT false,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    headers jsonb
);


ALTER TABLE public."Webhook" OWNER TO postgres;

--
-- Name: Websocket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Websocket" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE public."Websocket" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: message_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.message_view AS
 SELECT m.id AS message_table_id,
    (m.key ->> 'id'::text) AS message_unique_id,
    (m.key ->> 'fromMe'::text) AS is_sent_by_user,
    (m.key ->> 'remoteJid'::text) AS sender_or_recipient_id,
    (m.key ->> 'participant'::text) AS participant_id,
    (m.message ->> 'conversation'::text) AS message_text_content,
    ((m.message -> 'messageContextInfo'::text) ->> 'messageSecret'::text) AS message_secret_key,
    m."pushName" AS sender_display_name,
    m."messageType" AS message_type,
    m."messageTimestamp" AS message_timestamp,
    m."instanceId" AS instance_identifier,
    m."webhookUrl" AS webhook_url,
    m.source,
    m."sessionId" AS session_identifier,
    m.status AS message_status,
    (m.message ->> 'mediaUrl'::text) AS media_url,
    ((m.message -> 'imageMessage'::text) ->> 'url'::text) AS image_url,
    ((m.message -> 'imageMessage'::text) ->> 'mimetype'::text) AS image_mimetype,
    ((m.message -> 'imageMessage'::text) ->> 'mediaKey'::text) AS image_media_key,
    ((m.message -> 'videoMessage'::text) ->> 'url'::text) AS video_url,
    ((m.message -> 'videoMessage'::text) ->> 'mimetype'::text) AS video_mimetype,
    ((m.message -> 'videoMessage'::text) ->> 'mediaKey'::text) AS video_media_key,
    ((m.message -> 'audioMessage'::text) ->> 'url'::text) AS audio_url,
    ((m.message -> 'audioMessage'::text) ->> 'mimetype'::text) AS audio_mimetype,
    ((m.message -> 'documentMessage'::text) ->> 'url'::text) AS document_url,
    ((m.message -> 'documentMessage'::text) ->> 'mimetype'::text) AS document_mimetype,
    ((m.message -> 'documentMessage'::text) ->> 'fileName'::text) AS document_filename,
    ((m.message -> 'stickerMessage'::text) ->> 'url'::text) AS sticker_url,
    ((m.message -> 'contactMessage'::text) ->> 'displayName'::text) AS contact_display_name,
    ((m.message -> 'locationMessage'::text) ->> 'latitude'::text) AS location_latitude,
    ((m.message -> 'locationMessage'::text) ->> 'longitude'::text) AS location_longitude,
    ((m.message -> 'extendedTextMessage'::text) ->> 'text'::text) AS extended_text_message,
    COALESCE((m.message ->> 'conversation'::text), ((m.message -> 'extendedTextMessage'::text) ->> 'text'::text), ((m.message -> 'reactionMessage'::text) ->> 'text'::text), ((m.message -> 'imageMessage'::text) ->> 'caption'::text), ((m.message -> 'videoMessage'::text) ->> 'caption'::text), ((m.message -> 'documentMessage'::text) ->> 'caption'::text)) AS message_text_content_resolved,
        CASE
            WHEN ((m.status)::text = 'READ'::text) THEN 1
            ELSE 0
        END AS sort_unread,
        CASE
            WHEN ((m.status)::text = 'DELIVERY_ACK'::text) THEN 0
            WHEN ((m.status)::text = 'SERVER_ACK'::text) THEN 1
            WHEN ((m.status)::text = 'READ'::text) THEN 2
            ELSE 1
        END AS status_rank,
    m."instanceId" AS instance_id,
    COALESCE(i.name, ''::character varying) AS instance_name,
    i."ownerJid" AS instance_owner_jid
   FROM (public."Message" m
     LEFT JOIN public."Instance" i ON ((i.id = m."instanceId")));


ALTER TABLE public.message_view OWNER TO postgres;

--
-- Name: cahts_message_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.cahts_message_view AS
 SELECT mv.sender_or_recipient_id,
    mv.instance_identifier,
    mv.message_text_content_resolved,
    mv.message_timestamp,
    mv.message_table_id,
    mv.is_sent_by_user,
    mv.media_url,
    mv.image_url,
    mv.video_url,
    mv.audio_url,
    mv.document_url,
    mv.sticker_url,
    mv.sender_display_name,
    COALESCE(mv.instance_id, mv.instance_identifier) AS instance_id,
    (COALESCE(mv.instance_name, ''::character varying))::text AS instance_name,
    (mv.instance_owner_jid)::text AS instance_owner_jid
   FROM public.message_view mv;


ALTER TABLE public.cahts_message_view OWNER TO postgres;

--
-- Name: cahts_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cahts_settings (
    key character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.cahts_settings OWNER TO postgres;

--
-- Data for Name: Chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Chat" (id, "remoteJid", labels, "createdAt", "updatedAt", "instanceId", name, "unreadMessages") FROM stdin;
\.


--
-- Data for Name: Chatwoot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Chatwoot" (id, enabled, "accountId", token, url, "nameInbox", "signMsg", "signDelimiter", number, "reopenConversation", "conversationPending", "mergeBrazilContacts", "importContacts", "importMessages", "daysLimitImportMessages", "createdAt", "updatedAt", "instanceId", logo, organization, "ignoreJids") FROM stdin;
\.


--
-- Data for Name: Contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Contact" (id, "remoteJid", "pushName", "profilePicUrl", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Dify; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Dify" (id, enabled, "botType", "apiUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId", description, "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: DifySetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DifySetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "difyIdFallback", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Evoai; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Evoai" (id, enabled, description, "agentUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: EvoaiSetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."EvoaiSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "createdAt", "updatedAt", "evoaiIdFallback", "instanceId") FROM stdin;
\.


--
-- Data for Name: EvolutionBot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."EvolutionBot" (id, enabled, description, "apiUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: EvolutionBotSetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."EvolutionBotSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "botIdFallback", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Flowise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Flowise" (id, enabled, description, "apiUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: FlowiseSetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlowiseSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "flowiseIdFallback", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Instance" (id, name, "connectionStatus", "ownerJid", "profilePicUrl", integration, number, token, "clientName", "createdAt", "updatedAt", "profileName", "businessId", "disconnectionAt", "disconnectionObject", "disconnectionReasonCode") FROM stdin;
7988b509-225a-4a67-8501-a64d641f662d	95903798004	close	\N	\N	WHATSAPP-BAILEYS	5595903798004	D9B8969C-0EC9-42AF-9185-A0C64A00C6D8	evolution	2026-02-25 22:51:14.455	2026-02-25 22:51:14.455	\N	\N	\N	\N	\N
\.


--
-- Data for Name: IntegrationSession; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."IntegrationSession" (id, "sessionId", "remoteJid", "pushName", status, "awaitUser", "createdAt", "updatedAt", "instanceId", parameters, context, "botId", type) FROM stdin;
\.


--
-- Data for Name: IsOnWhatsapp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."IsOnWhatsapp" (id, "remoteJid", "jidOptions", "createdAt", "updatedAt", lid) FROM stdin;
cmkmnio0118myqo4kea3qhi9n	555496298276@s.whatsapp.net	555496298276@s.whatsapp.net,5554996298276@s.whatsapp.net	2026-01-20 13:50:13.62	2026-01-20 13:50:13.62	\N
cmkmnio0518mzqo4kgoezfo3s	555599998205@s.whatsapp.net	555599998205@s.whatsapp.net,5555999998205@s.whatsapp.net	2026-01-20 13:50:13.62	2026-01-20 13:50:13.62	\N
cmkmnio0618n0qo4kw02d3y1m	555596575876@s.whatsapp.net	555596575876@s.whatsapp.net,5555996575876@s.whatsapp.net	2026-01-20 13:50:13.62	2026-01-20 13:50:13.62	\N
cmkmnio0818n1qo4knduiedj4	554791961410@s.whatsapp.net	554791961410@s.whatsapp.net,5547991961410@s.whatsapp.net	2026-01-20 13:50:13.62	2026-01-20 13:50:13.62	\N
cmkmnio0918n2qo4kgdi6e6ca	555182899669@s.whatsapp.net	555182899669@s.whatsapp.net,5551982899669@s.whatsapp.net	2026-01-20 13:50:13.621	2026-01-20 13:50:13.621	\N
cmkmnio0a18n3qo4kg96jsiyt	555491223200@s.whatsapp.net	555491223200@s.whatsapp.net,5554991223200@s.whatsapp.net	2026-01-20 13:50:13.621	2026-01-20 13:50:13.621	\N
cmkmnio0i18n6qo4kwnraxxk3	555596421212@s.whatsapp.net	555596421212@s.whatsapp.net,5555996421212@s.whatsapp.net	2026-01-20 13:50:13.622	2026-01-20 13:50:13.622	\N
cmkmnio0h18n5qo4kkfeycq87	555491578337@s.whatsapp.net	555491578337@s.whatsapp.net,5554991578337@s.whatsapp.net	2026-01-20 13:50:13.622	2026-01-20 13:50:13.622	\N
cmkmnio0k18n7qo4kta60s9pc	555491867846@s.whatsapp.net	555491867846@s.whatsapp.net,5554991867846@s.whatsapp.net	2026-01-20 13:50:13.622	2026-01-20 13:50:13.622	\N
cmkmnio0l18n8qo4knwv3myay	555491299637@s.whatsapp.net	555491299637@s.whatsapp.net,5554991299637@s.whatsapp.net	2026-01-20 13:50:13.622	2026-01-20 13:50:13.622	\N
cmkmnio0l18n9qo4kq051jj84	555484090342@s.whatsapp.net	555484090342@s.whatsapp.net,5554984090342@s.whatsapp.net	2026-01-20 13:50:13.623	2026-01-20 13:50:13.623	\N
cmkmnio0p18naqo4kyre169vh	555491034332@s.whatsapp.net	555491034332@s.whatsapp.net,5554991034332@s.whatsapp.net	2026-01-20 13:50:13.623	2026-01-20 13:50:13.623	\N
cmkmnio0r18ncqo4k36ormk9a	555496651630@s.whatsapp.net	555496651630@s.whatsapp.net,5554996651630@s.whatsapp.net	2026-01-20 13:50:13.629	2026-01-20 13:50:13.629	\N
cmkmnio0r18ndqo4kwt96i86c	555592019967@s.whatsapp.net	555592019967@s.whatsapp.net,5555992019967@s.whatsapp.net	2026-01-20 13:50:13.624	2026-01-20 13:50:13.624	\N
cmkmnio2018neqo4kz9sx47lf	555592241221@s.whatsapp.net	555592241221@s.whatsapp.net,5555992241221@s.whatsapp.net	2026-01-20 13:50:13.639	2026-01-20 13:50:13.639	\N
cmkmnio2318nfqo4ktyxt66em	555591453713@s.whatsapp.net	555591453713@s.whatsapp.net,5555991453713@s.whatsapp.net	2026-01-20 13:50:13.683	2026-01-20 13:50:13.683	\N
cmkmnio2318ngqo4k1824fryh	555433241099@s.whatsapp.net	555433241099@s.whatsapp.net,5554933241099@s.whatsapp.net	2026-01-20 13:50:13.692	2026-01-20 13:50:13.692	\N
cmkmnio2418nhqo4kabx31skk	555184219074@s.whatsapp.net	555184219074@s.whatsapp.net,5551984219074@s.whatsapp.net	2026-01-20 13:50:13.695	2026-01-20 13:50:13.695	\N
cmkmnio2418niqo4kjdy9amfz	555491798155@s.whatsapp.net	555491798155@s.whatsapp.net,5554991798155@s.whatsapp.net	2026-01-20 13:50:13.717	2026-01-20 13:50:13.717	\N
cmkmnio2618njqo4kwlqcrby7	555484284850@s.whatsapp.net	555484284850@s.whatsapp.net,5554984284850@s.whatsapp.net	2026-01-20 13:50:13.732	2026-01-20 13:50:13.732	\N
cmkmnio2918nkqo4katjntc3c	555491566872@s.whatsapp.net	555491566872@s.whatsapp.net,5554991566872@s.whatsapp.net	2026-01-20 13:50:13.741	2026-01-20 13:50:13.741	\N
cmkmnio2a18nlqo4k7k689fzr	555492629677@s.whatsapp.net	555492629677@s.whatsapp.net,5554992629677@s.whatsapp.net	2026-01-20 13:50:13.737	2026-01-20 13:50:13.737	\N
cmkmnio2a18nmqo4kll5uypu9	555584140500@s.whatsapp.net	555584140500@s.whatsapp.net,5555984140500@s.whatsapp.net	2026-01-20 13:50:13.747	2026-01-20 13:50:13.747	\N
cmkmnio2b18nnqo4kkty56tf9	555599178463@s.whatsapp.net	555599178463@s.whatsapp.net,5555999178463@s.whatsapp.net	2026-01-20 13:50:13.755	2026-01-20 13:50:13.755	\N
cmkmnio2c18noqo4k9ocl0lpp	555599749826@s.whatsapp.net	555599749826@s.whatsapp.net,5555999749826@s.whatsapp.net	2026-01-20 13:50:13.757	2026-01-20 13:50:13.757	\N
cmkmnio2d18npqo4kaboofy7s	555491626210@s.whatsapp.net	555491626210@s.whatsapp.net,5554991626210@s.whatsapp.net	2026-01-20 13:50:13.771	2026-01-20 13:50:13.771	\N
cmkmnio2e18nrqo4kzcu56svv	555596239817@s.whatsapp.net	555596239817@s.whatsapp.net,5555996239817@s.whatsapp.net	2026-01-20 13:50:13.791	2026-01-20 13:50:13.791	\N
cmkmnio2e18nsqo4ke4hont9w	554789027056@s.whatsapp.net	554789027056@s.whatsapp.net,5547989027056@s.whatsapp.net	2026-01-20 13:50:13.796	2026-01-20 13:50:13.796	\N
cmkmnio2g18ntqo4kn9tg1o4o	555491155339@s.whatsapp.net	555491155339@s.whatsapp.net,5554991155339@s.whatsapp.net	2026-01-20 13:50:13.815	2026-01-20 13:50:13.815	\N
cmkmnio2g18nvqo4kgcwc6gfk	555591078085@s.whatsapp.net	555591078085@s.whatsapp.net,5555991078085@s.whatsapp.net	2026-01-20 13:50:13.829	2026-01-20 13:50:13.829	\N
cmkmnio2g18nuqo4kn86tlr79	555591331917@s.whatsapp.net	555591331917@s.whatsapp.net,5555991331917@s.whatsapp.net	2026-01-20 13:50:13.818	2026-01-20 13:50:13.818	\N
cmkmnio2h18nwqo4k2c0ukyu7	555599525143@s.whatsapp.net	555599525143@s.whatsapp.net,5555999525143@s.whatsapp.net	2026-01-20 13:50:13.838	2026-01-20 13:50:13.838	\N
cmkmnio2h18nxqo4klfcrnv2y	555591182011@s.whatsapp.net	555591182011@s.whatsapp.net,5555991182011@s.whatsapp.net	2026-01-20 13:50:13.843	2026-01-20 13:50:13.843	\N
cmkmnio2j18nyqo4kfqw5m8f4	555591512181@s.whatsapp.net	555591512181@s.whatsapp.net,5555991512181@s.whatsapp.net	2026-01-20 13:50:13.856	2026-01-20 13:50:13.856	\N
cmkmnio2k18o0qo4kbngp7s88	555491428073@s.whatsapp.net	555491428073@s.whatsapp.net,5554991428073@s.whatsapp.net	2026-01-20 13:50:13.871	2026-01-20 13:50:13.871	\N
cmkmnio2k18o1qo4kjpxvj0wa	555399018873@s.whatsapp.net	555399018873@s.whatsapp.net,5553999018873@s.whatsapp.net	2026-01-20 13:50:13.877	2026-01-20 13:50:13.877	\N
cmkmnio2m18o2qo4k332npf1e	555599121717@s.whatsapp.net	555599121717@s.whatsapp.net,5555999121717@s.whatsapp.net	2026-01-20 13:50:13.904	2026-01-20 13:50:13.904	\N
cmkmnio2n18o3qo4kzxaqbbj7	555584130459@s.whatsapp.net	555584130459@s.whatsapp.net,5555984130459@s.whatsapp.net	2026-01-20 13:50:13.911	2026-01-20 13:50:13.911	\N
cmkmnio2o18o4qo4kpwtxu7nd	555591051518@s.whatsapp.net	555591051518@s.whatsapp.net,5555991051518@s.whatsapp.net	2026-01-20 13:50:13.927	2026-01-20 13:50:13.927	\N
cmkmnio2o18o5qo4k7yhs1wh6	555591512702@s.whatsapp.net	555591512702@s.whatsapp.net,5555991512702@s.whatsapp.net	2026-01-20 13:50:13.93	2026-01-20 13:50:13.93	\N
cmkmnio2p18o7qo4kfb2wpu1w	555434553200@s.whatsapp.net	555434553200@s.whatsapp.net,5554934553200@s.whatsapp.net	2026-01-20 13:50:13.93	2026-01-20 13:50:13.93	\N
cmkmnio2q18o8qo4kb1s17tz6	555496644885@s.whatsapp.net	555496644885@s.whatsapp.net,5554996644885@s.whatsapp.net	2026-01-20 13:50:13.954	2026-01-20 13:50:13.954	\N
cmkmnio2r18o9qo4kpcfdouyj	555497122029@s.whatsapp.net	555497122029@s.whatsapp.net,5554997122029@s.whatsapp.net	2026-01-20 13:50:13.964	2026-01-20 13:50:13.964	\N
cmkmnio2r18oaqo4kdilhirpf	555599627636@s.whatsapp.net	555599627636@s.whatsapp.net,5555999627636@s.whatsapp.net	2026-01-20 13:50:13.968	2026-01-20 13:50:13.968	\N
cmkmninzy18mxqo4km0z5dvwu	555499321837@s.whatsapp.net	209517094658194@lid,555499321837@s.whatsapp.net,5554999321837@s.whatsapp.net	2026-01-20 13:50:13.62	2026-02-03 16:15:48.677	\N
cmkmnio2k18nzqo4k6mxi85ey	555599595119@s.whatsapp.net	231941202800688@lid,555599595119@s.whatsapp.net,5555999595119@s.whatsapp.net	2026-01-20 13:50:13.856	2026-02-21 10:48:38.948	\N
cmkmnio2o18o6qo4k5uigm2xy	555491696835@s.whatsapp.net	167808784683177@lid,555491696835@s.whatsapp.net,5554991696835@s.whatsapp.net	2026-01-20 13:50:13.95	2026-02-21 00:21:29.178	\N
cmkmnio0g18n4qo4k1zby4qb3	555491538776@s.whatsapp.net	175960582258750@lid,555491538776@s.whatsapp.net,5554991538776@s.whatsapp.net	2026-01-20 13:50:13.622	2026-02-21 00:21:28.957	\N
cmkmninzy18mwqo4kazaorqh3	555496993570@s.whatsapp.net	28797856415858@lid,555496993570@s.whatsapp.net,5554996993570@s.whatsapp.net	2026-01-20 13:50:13.619	2026-02-10 18:01:45.091	\N
cmkmnio2s18ocqo4ktazfghir	555591578421@s.whatsapp.net	555591578421@s.whatsapp.net,5555991578421@s.whatsapp.net	2026-01-20 13:50:13.988	2026-01-20 13:50:13.988	\N
cmkmnio2w18ohqo4kf5f2652s	555491767818@s.whatsapp.net	555491767818@s.whatsapp.net,5554991767818@s.whatsapp.net	2026-01-20 13:50:14.019	2026-01-20 13:50:14.019	\N
cmkmnio3618omqo4kla0jg253	555581372253@s.whatsapp.net	555581372253@s.whatsapp.net,5555981372253@s.whatsapp.net	2026-01-20 13:50:14.051	2026-01-20 13:50:14.051	\N
cmkmnio3b18osqo4klb88jjv2	555496732874@s.whatsapp.net	555496732874@s.whatsapp.net,5554996732874@s.whatsapp.net	2026-01-20 13:50:14.098	2026-01-20 13:50:14.098	\N
cmkmnio3j18p3qo4koipfpwp3	555596521478@s.whatsapp.net	555596521478@s.whatsapp.net,5555996521478@s.whatsapp.net	2026-01-20 13:50:14.198	2026-01-20 13:50:14.198	\N
cmkmnio3t18pdqo4k5sgh9was	555491387576@s.whatsapp.net	555491387576@s.whatsapp.net,5554991387576@s.whatsapp.net	2026-01-20 13:50:14.295	2026-01-20 13:50:14.295	\N
cmkmnio3z18pnqo4kdknh7g50	554792247943@s.whatsapp.net	554792247943@s.whatsapp.net,5547992247943@s.whatsapp.net	2026-01-20 13:50:14.379	2026-01-20 13:50:14.379	\N
cmkmnio4218ptqo4kno8xw04g	555381227890@s.whatsapp.net	555381227890@s.whatsapp.net,5553981227890@s.whatsapp.net	2026-01-20 13:50:14.462	2026-01-20 13:50:14.462	\N
cmkmnio4618q1qo4kb0y1w5br	555491130925@s.whatsapp.net	555491130925@s.whatsapp.net,5554991130925@s.whatsapp.net	2026-01-20 13:50:14.498	2026-01-20 13:50:14.498	\N
cmkmnio4a18q5qo4kg0f5gu6u	555492036697@s.whatsapp.net	555492036697@s.whatsapp.net,5554992036697@s.whatsapp.net	2026-01-20 13:50:14.52	2026-01-20 13:50:14.52	\N
cmkmnio4l18qaqo4kgc2p31ze	555584380001@s.whatsapp.net	555584380001@s.whatsapp.net,5555984380001@s.whatsapp.net	2026-01-20 13:50:14.555	2026-01-20 13:50:14.555	\N
cmkmnio4u18qjqo4k6cz08ds9	555581218121@s.whatsapp.net	555581218121@s.whatsapp.net,5555981218121@s.whatsapp.net	2026-01-20 13:50:14.643	2026-01-20 13:50:14.643	\N
cmkmnio5718qpqo4kcinsskcm	555591820705@s.whatsapp.net	555591820705@s.whatsapp.net,5555991820705@s.whatsapp.net	2026-01-20 13:50:14.675	2026-01-20 13:50:14.675	\N
cmkmniofb18qyqo4kvvflyidg	555496103400@s.whatsapp.net	555496103400@s.whatsapp.net,5554996103400@s.whatsapp.net	2026-01-20 13:50:15.335	2026-01-20 13:50:15.335	\N
cmkmniofy18r0qo4kqro453sy	559984411937@s.whatsapp.net	559984411937@s.whatsapp.net,5599984411937@s.whatsapp.net	2026-01-20 13:50:15.358	2026-01-20 13:50:15.358	\N
cmkmniog518r1qo4k8pei37pk	555491604757@s.whatsapp.net	555491604757@s.whatsapp.net,5554991604757@s.whatsapp.net	2026-01-20 13:50:15.365	2026-01-20 13:50:15.365	\N
cmkmnioj318r7qo4k018qta6z	555496163986@s.whatsapp.net	555496163986@s.whatsapp.net,5554996163986@s.whatsapp.net	2026-01-20 13:50:15.471	2026-01-20 13:50:15.471	\N
cmkmniok918reqo4k4k9bhivb	555491662787@s.whatsapp.net	555491662787@s.whatsapp.net,5554991662787@s.whatsapp.net	2026-01-20 13:50:15.514	2026-01-20 13:50:15.514	\N
cmkmniolh18rtqo4k747y67kf	555591385735@s.whatsapp.net	555591385735@s.whatsapp.net,5555991385735@s.whatsapp.net	2026-01-20 13:50:15.557	2026-01-20 13:50:15.557	\N
cmkmniolj18rvqo4kyvl0xxs7	5511985774210@s.whatsapp.net	551185774210@s.whatsapp.net,5511985774210@s.whatsapp.net	2026-01-20 13:50:15.559	2026-01-20 13:50:15.559	\N
cmkmniolm18rxqo4kdr2dmbl0	555491542777@s.whatsapp.net	555491542777@s.whatsapp.net,5554991542777@s.whatsapp.net	2026-01-20 13:50:15.562	2026-01-20 13:50:15.562	\N
cmkmniolp18s2qo4kkccb3sjs	555491775976@s.whatsapp.net	555491775976@s.whatsapp.net,5554991775976@s.whatsapp.net	2026-01-20 13:50:15.566	2026-01-20 13:50:15.566	\N
cmkmniolw18saqo4kkrgrarjh	555433246811@s.whatsapp.net	555433246811@s.whatsapp.net,5554933246811@s.whatsapp.net	2026-01-20 13:50:15.573	2026-01-20 13:50:15.573	\N
cmkmniom518sjqo4k4r94zs1b	555499980211@s.whatsapp.net	555499980211@s.whatsapp.net,5554999980211@s.whatsapp.net	2026-01-20 13:50:15.58	2026-01-20 13:50:15.58	\N
cmkmniomj18srqo4k4yo3uztu	555491675291@s.whatsapp.net	555491675291@s.whatsapp.net,5554991675291@s.whatsapp.net	2026-01-20 13:50:15.586	2026-01-20 13:50:15.586	\N
cmkmniomp18sxqo4kcyljuysn	5555999848933@s.whatsapp.net	555599848933@s.whatsapp.net,5555999848933@s.whatsapp.net	2026-01-20 13:50:15.59	2026-01-20 13:50:15.59	\N
cmkmniomt18t3qo4kkz8vvz24	555499887992@s.whatsapp.net	555499887992@s.whatsapp.net,5554999887992@s.whatsapp.net	2026-01-20 13:50:15.595	2026-01-20 13:50:15.595	\N
cmkmniomw18t7qo4kxscj6l6i	555499790658@s.whatsapp.net	555499790658@s.whatsapp.net,5554999790658@s.whatsapp.net	2026-01-20 13:50:15.598	2026-01-20 13:50:15.598	\N
cmkmnion118tfqo4kiae1fv7f	555491885639@s.whatsapp.net	555491885639@s.whatsapp.net,5554991885639@s.whatsapp.net	2026-01-20 13:50:15.604	2026-01-20 13:50:15.604	\N
cmkmnion418tjqo4kcuxp3yj8	555491660908@s.whatsapp.net	555491660908@s.whatsapp.net,5554991660908@s.whatsapp.net	2026-01-20 13:50:15.608	2026-01-20 13:50:15.608	\N
cmkmnionj18tsqo4kc2jpcljh	555491961143@s.whatsapp.net	555491961143@s.whatsapp.net,5554991961143@s.whatsapp.net	2026-01-20 13:50:15.625	2026-01-20 13:50:15.625	\N
cmkmnions18txqo4k1jicf8d8	555499421997@s.whatsapp.net	555499421997@s.whatsapp.net,5554999421997@s.whatsapp.net	2026-01-20 13:50:15.626	2026-01-20 13:50:15.626	\N
cmkmnioo018u4qo4k88libxpz	555599771443@s.whatsapp.net	555599771443@s.whatsapp.net,5555999771443@s.whatsapp.net	2026-01-20 13:50:15.628	2026-01-20 13:50:15.628	\N
cmkmniooc18u9qo4k7tet5ux0	555491722041@s.whatsapp.net	555491722041@s.whatsapp.net,5554991722041@s.whatsapp.net	2026-01-20 13:50:15.631	2026-01-20 13:50:15.631	\N
cmkmniooj18ufqo4kjy4bxbz7	555599387424@s.whatsapp.net	555599387424@s.whatsapp.net,5555999387424@s.whatsapp.net	2026-01-20 13:50:15.635	2026-01-20 13:50:15.635	\N
cmkmnioom18ujqo4k6h67ec53	555492810425@s.whatsapp.net	555492810425@s.whatsapp.net,5554992810425@s.whatsapp.net	2026-01-20 13:50:15.636	2026-01-20 13:50:15.636	\N
cmkmnioos18upqo4kqimacrep	555584265135@s.whatsapp.net	555584265135@s.whatsapp.net,5555984265135@s.whatsapp.net	2026-01-20 13:50:15.642	2026-01-20 13:50:15.642	\N
cmkmniop218uvqo4kcateqkv1	553197430592@s.whatsapp.net	553197430592@s.whatsapp.net,5531997430592@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniop518uyqo4kh50gxfms	555591730393@s.whatsapp.net	555591730393@s.whatsapp.net,5555991730393@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniop818v3qo4kmdrza8zw	555499070751@s.whatsapp.net	555499070751@s.whatsapp.net,5554999070751@s.whatsapp.net	2026-01-20 13:50:15.645	2026-01-20 13:50:15.645	\N
cmkmniopg18v8qo4kg5dxwd6n	555492202713@s.whatsapp.net	555492202713@s.whatsapp.net,5554992202713@s.whatsapp.net	2026-01-20 13:50:15.648	2026-01-20 13:50:15.648	\N
cmkmniopm18vdqo4k0gm6c6ox	555591751125@s.whatsapp.net	555591751125@s.whatsapp.net,5555991751125@s.whatsapp.net	2026-01-20 13:50:15.651	2026-01-20 13:50:15.651	\N
cmkmniomc18smqo4kpuf3qyrw	555491776567@s.whatsapp.net	105540281757749@lid,555491776567@s.whatsapp.net,5554991776567@s.whatsapp.net	2026-01-20 13:50:15.583	2026-01-24 18:05:51.909	\N
cmkmnion018tbqo4kn5zcv8t1	555491772419@s.whatsapp.net	165223281520869@lid,555491772419@s.whatsapp.net,5554991772419@s.whatsapp.net	2026-01-20 13:50:15.6	2026-02-12 15:11:29.336	\N
cmkmniom118seqo4kayamm9q0	555491999230@s.whatsapp.net	111020727091341@lid,555491999230@s.whatsapp.net,5554991999230@s.whatsapp.net	2026-01-20 13:50:15.576	2026-02-07 12:44:31.037	\N
cmkmnio3o18p7qo4kobtz1g6l	555491090546@s.whatsapp.net	273026859954404@lid,555491090546@s.whatsapp.net,5554991090546@s.whatsapp.net	2026-01-20 13:50:14.233	2026-02-05 13:13:55.904	\N
cmkmniolf18rsqo4kdb8x8me7	555491086023@s.whatsapp.net	143207161684146@lid,555491086023@s.whatsapp.net,5554991086023@s.whatsapp.net	2026-01-20 13:50:15.555	2026-02-13 14:48:12.022	\N
cmkmniofi18qzqo4kz20gw5g3	555491915061@s.whatsapp.net	2130488336540@lid,555491915061@s.whatsapp.net,5554991915061@s.whatsapp.net	2026-01-20 13:50:15.342	2026-02-21 00:21:29.116	\N
cmkmnio4o18qfqo4kqnak52v5	555484101047@s.whatsapp.net	246913509130310@lid,555484101047@s.whatsapp.net,5554984101047@s.whatsapp.net	2026-01-20 13:50:14.58	2026-02-24 18:37:45.283	lid
cmkmnio2t18oeqo4k9yvqj2cq	5511994499994@s.whatsapp.net	551194499994@s.whatsapp.net,5511994499994@s.whatsapp.net	2026-01-20 13:50:13.994	2026-01-20 13:50:13.994	\N
cmkmnio2x18ojqo4k7911k7cz	555491171385@s.whatsapp.net	555491171385@s.whatsapp.net,5554991171385@s.whatsapp.net	2026-01-20 13:50:14.025	2026-01-20 13:50:14.025	\N
cmkmnio3718ooqo4k9l5iqihd	555591138627@s.whatsapp.net	555591138627@s.whatsapp.net,5555991138627@s.whatsapp.net	2026-01-20 13:50:14.077	2026-01-20 13:50:14.077	\N
cmkmnio3c18otqo4kgq975y80	555491543216@s.whatsapp.net	555491543216@s.whatsapp.net,5554991543216@s.whatsapp.net	2026-01-20 13:50:14.111	2026-01-20 13:50:14.111	\N
cmkmnio3i18p0qo4k5dapfy4p	555484474914@s.whatsapp.net	555484474914@s.whatsapp.net,5554984474914@s.whatsapp.net	2026-01-20 13:50:14.176	2026-01-20 13:50:14.176	\N
cmkmnio3n18p4qo4kkehioo6e	555599407449@s.whatsapp.net	555599407449@s.whatsapp.net,5555999407449@s.whatsapp.net	2026-01-20 13:50:14.215	2026-01-20 13:50:14.215	\N
cmkmnio3q18p9qo4kv69ow466	555184464995@s.whatsapp.net	555184464995@s.whatsapp.net,5551984464995@s.whatsapp.net	2026-01-20 13:50:14.26	2026-01-20 13:50:14.26	\N
cmkmnio3w18piqo4kldfd97b7	555332512177@s.whatsapp.net	555332512177@s.whatsapp.net,5553932512177@s.whatsapp.net	2026-01-20 13:50:14.355	2026-01-20 13:50:14.355	\N
cmkmnio3y18pmqo4k5a4wvmf8	555497088887@s.whatsapp.net	555497088887@s.whatsapp.net,5554997088887@s.whatsapp.net	2026-01-20 13:50:14.392	2026-01-20 13:50:14.392	\N
cmkmnio4418pxqo4kau9nwf0u	555484044975@s.whatsapp.net	555484044975@s.whatsapp.net,5554984044975@s.whatsapp.net	2026-01-20 13:50:14.476	2026-01-20 13:50:14.476	\N
cmkmnio4718q2qo4kiqce252g	555484411937@s.whatsapp.net	555484411937@s.whatsapp.net,5554984411937@s.whatsapp.net	2026-01-20 13:50:14.512	2026-01-20 13:50:14.512	\N
cmkmnio4c18q7qo4k50zcsszs	555499987358@s.whatsapp.net	555499987358@s.whatsapp.net,5554999987358@s.whatsapp.net	2026-01-20 13:50:14.546	2026-01-20 13:50:14.546	\N
cmkmnio4m18qcqo4k41qo98ww	553791007768@s.whatsapp.net	553791007768@s.whatsapp.net,5537991007768@s.whatsapp.net	2026-01-20 13:50:14.58	2026-01-20 13:50:14.58	\N
cmkmnio4q18qhqo4ke43y1v56	555596525246@s.whatsapp.net	555596525246@s.whatsapp.net,5555996525246@s.whatsapp.net	2026-01-20 13:50:14.606	2026-01-20 13:50:14.606	\N
cmkmnio5318qnqo4kjt6an9fs	556792936014@s.whatsapp.net	556792936014@s.whatsapp.net,5567992936014@s.whatsapp.net	2026-01-20 13:50:14.672	2026-01-20 13:50:14.672	\N
cmkmnio5818qqqo4krkrbwmex	555491685321@s.whatsapp.net	555491685321@s.whatsapp.net,5554991685321@s.whatsapp.net	2026-01-20 13:50:14.675	2026-01-20 13:50:14.675	\N
cmkmnioeq18qtqo4kzal86ybx	555492445075@s.whatsapp.net	555492445075@s.whatsapp.net,5554992445075@s.whatsapp.net	2026-01-20 13:50:15.315	2026-01-20 13:50:15.315	\N
cmkmnioev18qvqo4ki7lz35bb	555599653434@s.whatsapp.net	555599653434@s.whatsapp.net,5555999653434@s.whatsapp.net	2026-01-20 13:50:15.32	2026-01-20 13:50:15.32	\N
cmkmniojg18r9qo4kjyl86ogh	555596815538@s.whatsapp.net	555596815538@s.whatsapp.net,5555996815538@s.whatsapp.net	2026-01-20 13:50:15.484	2026-01-20 13:50:15.484	\N
cmkmniolo18s0qo4khs8553pv	555596613776@s.whatsapp.net	555596613776@s.whatsapp.net,5555996613776@s.whatsapp.net	2026-01-20 13:50:15.564	2026-01-20 13:50:15.564	\N
cmkmniolp18s1qo4kr6usqu96	555499055851@s.whatsapp.net	555499055851@s.whatsapp.net,5554999055851@s.whatsapp.net	2026-01-20 13:50:15.565	2026-01-20 13:50:15.565	\N
cmkmniolv18s6qo4krrkcnhkw	555492217534@s.whatsapp.net	555492217534@s.whatsapp.net,5554992217534@s.whatsapp.net	2026-01-20 13:50:15.569	2026-01-20 13:50:15.569	\N
cmkmniolx18sbqo4kmfg4kxxu	555599062584@s.whatsapp.net	555599062584@s.whatsapp.net,5555999062584@s.whatsapp.net	2026-01-20 13:50:15.573	2026-01-20 13:50:15.573	\N
cmkmniom218sfqo4k1qgk601i	555499251916@s.whatsapp.net	555499251916@s.whatsapp.net,5554999251916@s.whatsapp.net	2026-01-20 13:50:15.576	2026-01-20 13:50:15.576	\N
cmkmniomf18snqo4kq5oyyrck	555591416311@s.whatsapp.net	555591416311@s.whatsapp.net,5555991416311@s.whatsapp.net	2026-01-20 13:50:15.583	2026-01-20 13:50:15.583	\N
cmkmnioml18stqo4k0t0g73at	555433221121@s.whatsapp.net	555433221121@s.whatsapp.net,5554933221121@s.whatsapp.net	2026-01-20 13:50:15.587	2026-01-20 13:50:15.587	\N
cmkmniomt18t2qo4kqomfta9t	555496765955@s.whatsapp.net	555496765955@s.whatsapp.net,5554996765955@s.whatsapp.net	2026-01-20 13:50:15.594	2026-01-20 13:50:15.594	\N
cmkmniomx18t8qo4kvdinjhqd	5511966195471@s.whatsapp.net	551166195471@s.whatsapp.net,5511966195471@s.whatsapp.net	2026-01-20 13:50:15.598	2026-01-20 13:50:15.598	\N
cmkmniomz18taqo4kbzvneibi	555591456361@s.whatsapp.net	555591456361@s.whatsapp.net,5555991456361@s.whatsapp.net	2026-01-20 13:50:15.599	2026-01-20 13:50:15.599	\N
cmkmnion218tgqo4k86eujg7e	555591496933@s.whatsapp.net	555591496933@s.whatsapp.net,5555991496933@s.whatsapp.net	2026-01-20 13:50:15.606	2026-01-20 13:50:15.606	\N
cmkmnion818toqo4kh38p4hat	555484090421@s.whatsapp.net	555484090421@s.whatsapp.net,5554984090421@s.whatsapp.net	2026-01-20 13:50:15.618	2026-01-20 13:50:15.618	\N
cmkmnionj18ttqo4kfjbgtgxn	555591550852@s.whatsapp.net	555591550852@s.whatsapp.net,5555991550852@s.whatsapp.net	2026-01-20 13:50:15.624	2026-01-20 13:50:15.624	\N
cmkmnionp18tvqo4kcxtngp4p	555491655430@s.whatsapp.net	555491655430@s.whatsapp.net,5554991655430@s.whatsapp.net	2026-01-20 13:50:15.625	2026-01-20 13:50:15.625	\N
cmkmnioo718u6qo4k7rwjq80b	555491963051@s.whatsapp.net	555491963051@s.whatsapp.net,5554991963051@s.whatsapp.net	2026-01-20 13:50:15.629	2026-01-20 13:50:15.629	\N
cmkmnioof18ubqo4kk9720vvn	555192669422@s.whatsapp.net	555192669422@s.whatsapp.net,5551992669422@s.whatsapp.net	2026-01-20 13:50:15.634	2026-01-20 13:50:15.634	\N
cmkmniool18uhqo4kapeayumw	5511981554905@s.whatsapp.net	551181554905@s.whatsapp.net,5511981554905@s.whatsapp.net	2026-01-20 13:50:15.636	2026-01-20 13:50:15.636	\N
cmkmniooz18urqo4kc5myulx9	555499622023@s.whatsapp.net	555499622023@s.whatsapp.net,5554999622023@s.whatsapp.net	2026-01-20 13:50:15.642	2026-01-20 13:50:15.642	\N
cmkmniop318uwqo4kjxwz7d8w	555491483799@s.whatsapp.net	555491483799@s.whatsapp.net,5554991483799@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniop518v0qo4k0ovvd222	555591949892@s.whatsapp.net	555591949892@s.whatsapp.net,5555991949892@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniop918v5qo4k6t7d526t	555491438392@s.whatsapp.net	555491438392@s.whatsapp.net,5554991438392@s.whatsapp.net	2026-01-20 13:50:15.646	2026-01-20 13:50:15.646	\N
cmkmniopg18vaqo4k6ry3h3w8	555492009424@s.whatsapp.net	555492009424@s.whatsapp.net,5554992009424@s.whatsapp.net	2026-01-20 13:50:15.648	2026-01-20 13:50:15.648	\N
cmkmniopm18vcqo4ko0vcs6b6	553499205209@s.whatsapp.net	553499205209@s.whatsapp.net,5534999205209@s.whatsapp.net	2026-01-20 13:50:15.653	2026-01-20 13:50:15.653	\N
cmkmniopt18viqo4kwiokkq71	555491796906@s.whatsapp.net	555491796906@s.whatsapp.net,5554991796906@s.whatsapp.net	2026-01-20 13:50:15.655	2026-01-20 13:50:15.655	\N
cmkmnioq318vpqo4k2inh9c40	555430456982@s.whatsapp.net	555430456982@s.whatsapp.net,5554930456982@s.whatsapp.net	2026-01-20 13:50:15.659	2026-01-20 13:50:15.659	\N
cmkmnioqc18vyqo4k1hrs8zzo	558007013196@s.whatsapp.net	558007013196@s.whatsapp.net,5580907013196@s.whatsapp.net	2026-01-20 13:50:15.663	2026-01-20 13:50:15.663	\N
cmkmniooo18umqo4knq6uc8iy	555499997655@s.whatsapp.net	216444910473291@lid,555499997655@s.whatsapp.net,5554999997655@s.whatsapp.net	2026-01-20 13:50:15.637	2026-02-24 19:21:26.162	\N
cmkmnionz18u2qo4kaja7bvrf	555581189717@s.whatsapp.net	555581189717@s.whatsapp.net,5555981189717@s.whatsapp.net	2026-01-20 13:50:15.628	2026-02-07 00:38:09.645	\N
cmkmnio3t18pfqo4klw33y5b9	555491023033@s.whatsapp.net	211342472556751@lid,555491023033@s.whatsapp.net,5554991023033@s.whatsapp.net	2026-01-20 13:50:14.326	2026-02-13 11:36:11.714	\N
cmkmniok518rcqo4k68ohtw5f	555491102923@s.whatsapp.net	219799313477637@lid,555491102923@s.whatsapp.net,5554991102923@s.whatsapp.net	2026-01-20 13:50:15.509	2026-02-21 00:21:29.042	\N
cmkmnioq718vtqo4kjw5k3q7e	555591493906@s.whatsapp.net	235497469276294@lid,555591493906@s.whatsapp.net,5555991493906@s.whatsapp.net	2026-01-20 13:50:15.66	2026-02-24 19:40:46.938	lid
cmkmnio2t18odqo4kithtlavm	555591796009@s.whatsapp.net	555591796009@s.whatsapp.net,5555991796009@s.whatsapp.net	2026-01-20 13:50:13.991	2026-01-20 13:50:13.991	\N
cmkmnio2x18oiqo4kefdzwngt	559991949222@s.whatsapp.net	559991949222@s.whatsapp.net,5599991949222@s.whatsapp.net	2026-01-20 13:50:14.016	2026-01-20 13:50:14.016	\N
cmkmnio3f18owqo4kzpsissxu	555492690345@s.whatsapp.net	555492690345@s.whatsapp.net,5554992690345@s.whatsapp.net	2026-01-20 13:50:14.139	2026-01-20 13:50:14.139	\N
cmkmnio3i18p1qo4kzge7hqsw	555492043316@s.whatsapp.net	555492043316@s.whatsapp.net,5554992043316@s.whatsapp.net	2026-01-20 13:50:14.181	2026-01-20 13:50:14.181	\N
cmkmnio3p18p8qo4k5qetwcxn	555491534581@s.whatsapp.net	555491534581@s.whatsapp.net,5554991534581@s.whatsapp.net	2026-01-20 13:50:14.236	2026-01-20 13:50:14.236	\N
cmkmnio3s18pcqo4k11vp529t	558006466444@s.whatsapp.net	558006466444@s.whatsapp.net,5580906466444@s.whatsapp.net	2026-01-20 13:50:14.288	2026-01-20 13:50:14.288	\N
cmkmnio3w18phqo4k57rn76uk	555484180240@s.whatsapp.net	555484180240@s.whatsapp.net,5554984180240@s.whatsapp.net	2026-01-20 13:50:14.343	2026-01-20 13:50:14.343	\N
cmkmnio3y18pkqo4krfly53zj	555491068997@s.whatsapp.net	555491068997@s.whatsapp.net,5554991068997@s.whatsapp.net	2026-01-20 13:50:14.375	2026-01-20 13:50:14.375	\N
cmkmnio4018ppqo4koz2leugw	555491828535@s.whatsapp.net	555491828535@s.whatsapp.net,5554991828535@s.whatsapp.net	2026-01-20 13:50:14.423	2026-01-20 13:50:14.423	\N
cmkmnio4318puqo4ky0wrdexa	555198266100@s.whatsapp.net	555198266100@s.whatsapp.net,5551998266100@s.whatsapp.net	2026-01-20 13:50:14.463	2026-01-20 13:50:14.463	\N
cmkmnio4618pzqo4kdkakwdx9	555591326802@s.whatsapp.net	555591326802@s.whatsapp.net,5555991326802@s.whatsapp.net	2026-01-20 13:50:14.486	2026-01-20 13:50:14.486	\N
cmkmnio4818q3qo4k8km0rha4	555599984245@s.whatsapp.net	555599984245@s.whatsapp.net,5555999984245@s.whatsapp.net	2026-01-20 13:50:14.512	2026-01-20 13:50:14.512	\N
cmkmnio4l18q9qo4kfiimt8ru	555491812563@s.whatsapp.net	555491812563@s.whatsapp.net,5554991812563@s.whatsapp.net	2026-01-20 13:50:14.55	2026-01-20 13:50:14.55	\N
cmkmnio4o18qeqo4kdkjhu22y	555484446088@s.whatsapp.net	555484446088@s.whatsapp.net,5554984446088@s.whatsapp.net	2026-01-20 13:50:14.58	2026-01-20 13:50:14.58	\N
cmkmnioew18qwqo4ko1uvcuqh	555199495137@s.whatsapp.net	555199495137@s.whatsapp.net,5551999495137@s.whatsapp.net	2026-01-20 13:50:15.32	2026-01-20 13:50:15.32	\N
cmkmnioj418r8qo4k08sxt9q3	554884696917@s.whatsapp.net	554884696917@s.whatsapp.net,5548984696917@s.whatsapp.net	2026-01-20 13:50:15.472	2026-01-20 13:50:15.472	\N
cmkmniols18s5qo4kjr09w67y	555499903724@s.whatsapp.net	555499903724@s.whatsapp.net,5554999903724@s.whatsapp.net	2026-01-20 13:50:15.568	2026-01-20 13:50:15.568	\N
cmkmniolw18s9qo4kji0316fq	555492532521@s.whatsapp.net	555492532521@s.whatsapp.net,5554992532521@s.whatsapp.net	2026-01-20 13:50:15.571	2026-01-20 13:50:15.571	\N
cmkmniolz18sdqo4k50me7uft	555596498778@s.whatsapp.net	555596498778@s.whatsapp.net,5555996498778@s.whatsapp.net	2026-01-20 13:50:15.575	2026-01-20 13:50:15.575	\N
cmkmniom918skqo4kqqbn4xp6	555491273418@s.whatsapp.net	555491273418@s.whatsapp.net,5554991273418@s.whatsapp.net	2026-01-20 13:50:15.581	2026-01-20 13:50:15.581	\N
cmkmniomg18spqo4komg9kson	555597143479@s.whatsapp.net	555597143479@s.whatsapp.net,5555997143479@s.whatsapp.net	2026-01-20 13:50:15.585	2026-01-20 13:50:15.585	\N
cmkmnioml18ssqo4kgqvedvdo	555492053122@s.whatsapp.net	555492053122@s.whatsapp.net,5554992053122@s.whatsapp.net	2026-01-20 13:50:15.587	2026-01-20 13:50:15.587	\N
cmkmniomp18svqo4kt3a6aw02	555491612000@s.whatsapp.net	555491612000@s.whatsapp.net,5554991612000@s.whatsapp.net	2026-01-20 13:50:15.589	2026-01-20 13:50:15.589	\N
cmkmnioms18t1qo4kwv4zv1u1	555591790652@s.whatsapp.net	555591790652@s.whatsapp.net,5555991790652@s.whatsapp.net	2026-01-20 13:50:15.594	2026-01-20 13:50:15.594	\N
cmkmniomw18t6qo4kycytz0h7	555596850552@s.whatsapp.net	555596850552@s.whatsapp.net,5555996850552@s.whatsapp.net	2026-01-20 13:50:15.597	2026-01-20 13:50:15.597	\N
cmkmnion018tcqo4kbtrfbhyi	555533228133@s.whatsapp.net	555533228133@s.whatsapp.net,5555933228133@s.whatsapp.net	2026-01-20 13:50:15.601	2026-01-20 13:50:15.601	\N
cmkmnion318tiqo4kcmzna9jz	556292508188@s.whatsapp.net	556292508188@s.whatsapp.net,5562992508188@s.whatsapp.net	2026-01-20 13:50:15.607	2026-01-20 13:50:15.607	\N
cmkmnion718tmqo4k6lqo60vg	555591011813@s.whatsapp.net	555591011813@s.whatsapp.net,5555991011813@s.whatsapp.net	2026-01-20 13:50:15.616	2026-01-20 13:50:15.616	\N
cmkmnionh18tqqo4kz93dbk0o	555391011701@s.whatsapp.net	555391011701@s.whatsapp.net,5553991011701@s.whatsapp.net	2026-01-20 13:50:15.621	2026-01-20 13:50:15.621	\N
cmkmnionu18tzqo4ktnw89cpq	555491167677@s.whatsapp.net	555491167677@s.whatsapp.net,5554991167677@s.whatsapp.net	2026-01-20 13:50:15.626	2026-01-20 13:50:15.626	\N
cmkmnionw18u0qo4kr4bw97nn	555491228830@s.whatsapp.net	555491228830@s.whatsapp.net,5554991228830@s.whatsapp.net	2026-01-20 13:50:15.628	2026-01-20 13:50:15.628	\N
cmkmnioo518u5qo4k348w4cfx	555596127943@s.whatsapp.net	555596127943@s.whatsapp.net,5555996127943@s.whatsapp.net	2026-01-20 13:50:15.628	2026-01-20 13:50:15.628	\N
cmkmnioog18ucqo4k54ryyjvt	555591051187@s.whatsapp.net	555591051187@s.whatsapp.net,5555991051187@s.whatsapp.net	2026-01-20 13:50:15.632	2026-01-20 13:50:15.632	\N
cmkmnioom18uiqo4k96lljlzk	555181119083@s.whatsapp.net	555181119083@s.whatsapp.net,5551981119083@s.whatsapp.net	2026-01-20 13:50:15.636	2026-01-20 13:50:15.636	\N
cmkmniooq18unqo4k5wa9ymwc	555493241323@s.whatsapp.net	555493241323@s.whatsapp.net,5554993241323@s.whatsapp.net	2026-01-20 13:50:15.638	2026-01-20 13:50:15.638	\N
cmkmniop118utqo4khmn7gzog	555596032885@s.whatsapp.net	555596032885@s.whatsapp.net,5555996032885@s.whatsapp.net	2026-01-20 13:50:15.643	2026-01-20 13:50:15.643	\N
cmkmniop918v4qo4kdt6rrf0n	554821060006@s.whatsapp.net	554821060006@s.whatsapp.net,5548921060006@s.whatsapp.net	2026-01-20 13:50:15.647	2026-01-20 13:50:15.647	\N
cmkmniopm18veqo4kv9z7jrr7	555491703780@s.whatsapp.net	555491703780@s.whatsapp.net,5554991703780@s.whatsapp.net	2026-01-20 13:50:15.654	2026-01-20 13:50:15.654	\N
cmkmnioq218vmqo4kwcjghgzh	555399265049@s.whatsapp.net	555399265049@s.whatsapp.net,5553999265049@s.whatsapp.net	2026-01-20 13:50:15.657	2026-01-20 13:50:15.657	\N
cmkmnioq518vsqo4k8uiv8kk4	555591524780@s.whatsapp.net	555591524780@s.whatsapp.net,5555991524780@s.whatsapp.net	2026-01-20 13:50:15.659	2026-01-20 13:50:15.659	\N
cmkmnioq818vuqo4kor2dfbsv	555596267178@s.whatsapp.net	555596267178@s.whatsapp.net,5555996267178@s.whatsapp.net	2026-01-20 13:50:15.662	2026-01-20 13:50:15.662	\N
cmkmnioqg18w0qo4kkfm0buq6	555491006136@s.whatsapp.net	555491006136@s.whatsapp.net,5554991006136@s.whatsapp.net	2026-01-20 13:50:15.663	2026-01-20 13:50:15.663	\N
cmkmnioqn18w4qo4kbxmvbsx1	555533244662@s.whatsapp.net	555533244662@s.whatsapp.net,5555933244662@s.whatsapp.net	2026-01-20 13:50:15.666	2026-01-20 13:50:15.666	\N
cmkmnioqy18w9qo4kh3o9e98q	555185790111@s.whatsapp.net	555185790111@s.whatsapp.net,5551985790111@s.whatsapp.net	2026-01-20 13:50:15.668	2026-01-20 13:50:15.668	\N
cmkmnio5818qrqo4ku0evpmr2	555591911818@s.whatsapp.net	242356532047907@lid,555591911818@s.whatsapp.net,5555991911818@s.whatsapp.net	2026-01-20 13:50:14.69	2026-01-22 12:22:51.438	\N
cmkmnio3a18orqo4kztwgl4hv	5518998203575@s.whatsapp.net	216530910482642@lid,551898203575@s.whatsapp.net,5518998203575@s.whatsapp.net	2026-01-20 13:50:14.092	2026-01-29 11:35:49.424	\N
cmkmniopg18v9qo4k5vbt9oma	555599260579@s.whatsapp.net	156847977812107@lid,555599260579@s.whatsapp.net,5555999260579@s.whatsapp.net	2026-01-20 13:50:15.649	2026-02-07 13:37:37.843	\N
cmkmniom318shqo4kjcuvul8j	555491145293@s.whatsapp.net	180259928457399@lid,555491145293@s.whatsapp.net,5554991145293@s.whatsapp.net	2026-01-20 13:50:15.578	2026-02-09 12:24:22.826	\N
cmkmnio4w18qlqo4kvk3wxd58	555491661612@s.whatsapp.net	175007099547676@lid,555491661612@s.whatsapp.net,5554991661612@s.whatsapp.net	2026-01-20 13:50:14.645	2026-02-24 12:07:24.948	\N
cmkmnio3718onqo4kt776x88j	555491819531@s.whatsapp.net	555491819531@s.whatsapp.net,5554991819531@s.whatsapp.net	2026-01-20 13:50:14.052	2026-02-21 00:21:29.221	\N
cmkmnio2u18ofqo4knba58dv8	554888164740@s.whatsapp.net	554888164740@s.whatsapp.net,5548988164740@s.whatsapp.net	2026-01-20 13:50:14.003	2026-01-20 13:50:14.003	\N
cmkmnio2x18okqo4kzhi2kc1e	555596792929@s.whatsapp.net	555596792929@s.whatsapp.net,5555996792929@s.whatsapp.net	2026-01-20 13:50:14.039	2026-01-20 13:50:14.039	\N
cmkmnio3718opqo4kky8vksh6	555599741154@s.whatsapp.net	555599741154@s.whatsapp.net,5555999741154@s.whatsapp.net	2026-01-20 13:50:14.054	2026-01-20 13:50:14.054	\N
cmkmnio3c18ouqo4k7zygift1	555183197788@s.whatsapp.net	555183197788@s.whatsapp.net,5551983197788@s.whatsapp.net	2026-01-20 13:50:14.122	2026-01-20 13:50:14.122	\N
cmkmnio3h18ozqo4kfroh2jxa	555491861560@s.whatsapp.net	555491861560@s.whatsapp.net,5554991861560@s.whatsapp.net	2026-01-20 13:50:14.164	2026-01-20 13:50:14.164	\N
cmkmnio3o18p6qo4kp1ez7lam	555584670568@s.whatsapp.net	555584670568@s.whatsapp.net,5555984670568@s.whatsapp.net	2026-01-20 13:50:14.219	2026-01-20 13:50:14.219	\N
cmkmnio3s18paqo4kxesnftft	555491874241@s.whatsapp.net	555491874241@s.whatsapp.net,5554991874241@s.whatsapp.net	2026-01-20 13:50:14.26	2026-01-20 13:50:14.26	\N
cmkmnio3u18pgqo4ki5wdx7wu	554799820643@s.whatsapp.net	554799820643@s.whatsapp.net,5547999820643@s.whatsapp.net	2026-01-20 13:50:14.343	2026-01-20 13:50:14.343	\N
cmkmnio3y18plqo4kq7zvq83r	555491363888@s.whatsapp.net	555491363888@s.whatsapp.net,5554991363888@s.whatsapp.net	2026-01-20 13:50:14.389	2026-01-20 13:50:14.389	\N
cmkmnio4018pqqo4ku1hh7ohk	555499583177@s.whatsapp.net	555499583177@s.whatsapp.net,5554999583177@s.whatsapp.net	2026-01-20 13:50:14.398	2026-01-20 13:50:14.398	\N
cmkmnio4418pvqo4kfub423dr	555591967107@s.whatsapp.net	555591967107@s.whatsapp.net,5555991967107@s.whatsapp.net	2026-01-20 13:50:14.475	2026-01-20 13:50:14.475	\N
cmkmnio4a18q6qo4klz3u7r5b	555599482208@s.whatsapp.net	555599482208@s.whatsapp.net,5555999482208@s.whatsapp.net	2026-01-20 13:50:14.525	2026-01-20 13:50:14.525	\N
cmkmnio4m18qbqo4k1d31owxj	555491122698@s.whatsapp.net	555491122698@s.whatsapp.net,5554991122698@s.whatsapp.net	2026-01-20 13:50:14.562	2026-01-20 13:50:14.562	\N
cmkmnio4s18qiqo4k6nvjtk3s	554791808959@s.whatsapp.net	554791808959@s.whatsapp.net,5547991808959@s.whatsapp.net	2026-01-20 13:50:14.634	2026-01-20 13:50:14.634	\N
cmkmnio5218qmqo4kqadg7j55	555496538242@s.whatsapp.net	555496538242@s.whatsapp.net,5554996538242@s.whatsapp.net	2026-01-20 13:50:14.66	2026-01-20 13:50:14.66	\N
cmkmnio5918qsqo4k0xf2z931	555491676947@s.whatsapp.net	555491676947@s.whatsapp.net,5554991676947@s.whatsapp.net	2026-01-20 13:50:14.697	2026-01-20 13:50:14.697	\N
cmkmnioet18quqo4kxof79cmm	555193521742@s.whatsapp.net	555193521742@s.whatsapp.net,5551993521742@s.whatsapp.net	2026-01-20 13:50:15.316	2026-01-20 13:50:15.316	\N
cmkmniofa18qxqo4k1wvw8a94	5511941335654@s.whatsapp.net	551141335654@s.whatsapp.net,5511941335654@s.whatsapp.net	2026-01-20 13:50:15.334	2026-01-20 13:50:15.334	\N
cmkmniogf18r2qo4k99zm7rd5	555491067093@s.whatsapp.net	555491067093@s.whatsapp.net,5554991067093@s.whatsapp.net	2026-01-20 13:50:15.375	2026-01-20 13:50:15.375	\N
cmkmniogz18r3qo4kfz5del1j	555491360285@s.whatsapp.net	555491360285@s.whatsapp.net,5554991360285@s.whatsapp.net	2026-01-20 13:50:15.395	2026-01-20 13:50:15.395	\N
cmkmniohv18r4qo4ksmqkcemv	556196103234@s.whatsapp.net	556196103234@s.whatsapp.net,5561996103234@s.whatsapp.net	2026-01-20 13:50:15.397	2026-01-20 13:50:15.397	\N
cmkmnioia18r5qo4ku9u8q5rx	555596236653@s.whatsapp.net	555596236653@s.whatsapp.net,5555996236653@s.whatsapp.net	2026-01-20 13:50:15.442	2026-01-20 13:50:15.442	\N
cmkmnioj118r6qo4kq8qxpryr	554799458658@s.whatsapp.net	554799458658@s.whatsapp.net,5547999458658@s.whatsapp.net	2026-01-20 13:50:15.47	2026-01-20 13:50:15.47	\N
cmkmniojm18rbqo4kth2hl04o	555599145258@s.whatsapp.net	555599145258@s.whatsapp.net,5555999145258@s.whatsapp.net	2026-01-20 13:50:15.487	2026-01-20 13:50:15.487	\N
cmkmniok818rdqo4k4fniwjdt	555484227179@s.whatsapp.net	555484227179@s.whatsapp.net,5554984227179@s.whatsapp.net	2026-01-20 13:50:15.513	2026-01-20 13:50:15.513	\N
cmkmniokg18rgqo4kgh10530j	555584111195@s.whatsapp.net	555584111195@s.whatsapp.net,5555984111195@s.whatsapp.net	2026-01-20 13:50:15.521	2026-01-20 13:50:15.521	\N
cmkmniokr18riqo4krbxdmdkb	555491015612@s.whatsapp.net	555491015612@s.whatsapp.net,5554991015612@s.whatsapp.net	2026-01-20 13:50:15.531	2026-01-20 13:50:15.531	\N
cmkmniokv18rkqo4keuhx42o7	555591524020@s.whatsapp.net	555591524020@s.whatsapp.net,5555991524020@s.whatsapp.net	2026-01-20 13:50:15.535	2026-01-20 13:50:15.535	\N
cmkmniokx18rlqo4kvq0uhjxd	555499916059@s.whatsapp.net	555499916059@s.whatsapp.net,5554999916059@s.whatsapp.net	2026-01-20 13:50:15.537	2026-01-20 13:50:15.537	\N
cmkmniokz18rmqo4k8n8oemyk	555484380335@s.whatsapp.net	555484380335@s.whatsapp.net,5554984380335@s.whatsapp.net	2026-01-20 13:50:15.539	2026-01-20 13:50:15.539	\N
cmkmniol018rnqo4kswkk44ar	555530256100@s.whatsapp.net	555530256100@s.whatsapp.net,5555930256100@s.whatsapp.net	2026-01-20 13:50:15.541	2026-01-20 13:50:15.541	\N
cmkmniol418roqo4krmq223oz	555491692484@s.whatsapp.net	555491692484@s.whatsapp.net,5554991692484@s.whatsapp.net	2026-01-20 13:50:15.544	2026-01-20 13:50:15.544	\N
cmkmniol618rpqo4k6xoc0alf	555591310116@s.whatsapp.net	555591310116@s.whatsapp.net,5555991310116@s.whatsapp.net	2026-01-20 13:50:15.547	2026-01-20 13:50:15.547	\N
cmkmniolb18rqqo4k40alsz5w	555599570401@s.whatsapp.net	555599570401@s.whatsapp.net,5555999570401@s.whatsapp.net	2026-01-20 13:50:15.551	2026-01-20 13:50:15.551	\N
cmkmniole18rrqo4k0iyhjhwm	555433244486@s.whatsapp.net	555433244486@s.whatsapp.net,5554933244486@s.whatsapp.net	2026-01-20 13:50:15.554	2026-01-20 13:50:15.554	\N
cmkmnioli18ruqo4kn4fpwror	555491391669@s.whatsapp.net	555491391669@s.whatsapp.net,5554991391669@s.whatsapp.net	2026-01-20 13:50:15.558	2026-01-20 13:50:15.558	\N
cmkmnioln18ryqo4kkwu8dg3p	555491359046@s.whatsapp.net	555491359046@s.whatsapp.net,5554991359046@s.whatsapp.net	2026-01-20 13:50:15.563	2026-01-20 13:50:15.563	\N
cmkmniolr18s4qo4knsnbkiuq	554196122702@s.whatsapp.net	554196122702@s.whatsapp.net,5541996122702@s.whatsapp.net	2026-01-20 13:50:15.567	2026-01-20 13:50:15.567	\N
cmkmniolv18s7qo4kegpg8wqx	555491291840@s.whatsapp.net	555491291840@s.whatsapp.net,5554991291840@s.whatsapp.net	2026-01-20 13:50:15.57	2026-01-20 13:50:15.57	\N
cmkmniom218sgqo4kdv0v8zjz	555581128657@s.whatsapp.net	555581128657@s.whatsapp.net,5555981128657@s.whatsapp.net	2026-01-20 13:50:15.577	2026-01-20 13:50:15.577	\N
cmkmniomp18syqo4kou3zz9ir	555491378169@s.whatsapp.net	555491378169@s.whatsapp.net,5554991378169@s.whatsapp.net	2026-01-20 13:50:15.588	2026-01-20 13:50:15.588	\N
cmkmnioms18t0qo4ks765npj3	555591281232@s.whatsapp.net	555591281232@s.whatsapp.net,5555991281232@s.whatsapp.net	2026-01-20 13:50:15.593	2026-01-20 13:50:15.593	\N
cmkmniomw18t5qo4ko37ncffj	555181645444@s.whatsapp.net	555181645444@s.whatsapp.net,5551981645444@s.whatsapp.net	2026-01-20 13:50:15.596	2026-01-20 13:50:15.596	\N
cmkmniomy18t9qo4kbjmsb9av	555591520457@s.whatsapp.net	555591520457@s.whatsapp.net,5555991520457@s.whatsapp.net	2026-01-20 13:50:15.599	2026-01-20 13:50:15.599	\N
cmkmnion018tdqo4kt06osxfk	555491713274@s.whatsapp.net	555491713274@s.whatsapp.net,5554991713274@s.whatsapp.net	2026-01-20 13:50:15.603	2026-01-20 13:50:15.603	\N
cmkmnion318thqo4k2df8liwi	5511920177811@s.whatsapp.net	551120177811@s.whatsapp.net,5511920177811@s.whatsapp.net	2026-01-20 13:50:15.606	2026-01-20 13:50:15.606	\N
cmkmnion718tlqo4ky04fcp5p	551147342888@s.whatsapp.net	551147342888@s.whatsapp.net,5511947342888@s.whatsapp.net	2026-01-20 13:50:15.611	2026-01-20 13:50:15.611	\N
cmkmnionl18tuqo4k9jvlq11a	555433221052@s.whatsapp.net	555433221052@s.whatsapp.net,5554933221052@s.whatsapp.net	2026-01-20 13:50:15.625	2026-01-20 13:50:15.625	\N
cmkmniokt18rjqo4kj85fld2r	555493577138@s.whatsapp.net	555493577138@s.whatsapp.net,5554993577138@s.whatsapp.net	2026-01-20 13:50:15.533	2026-02-21 00:21:29.041	\N
cmkmniokk18rhqo4kzt9rnotf	555596375708@s.whatsapp.net	555596375708@s.whatsapp.net,5555996375708@s.whatsapp.net	2026-01-20 13:50:15.524	2026-02-21 00:21:28.966	\N
cmkmnio2y18olqo4k7gdf0q4y	555496602929@s.whatsapp.net	555496602929@s.whatsapp.net,5554996602929@s.whatsapp.net	2026-01-20 13:50:14.042	2026-01-20 13:50:14.042	\N
cmkmnio3818oqqo4khy2bx3m0	555591342166@s.whatsapp.net	555591342166@s.whatsapp.net,5555991342166@s.whatsapp.net	2026-01-20 13:50:14.077	2026-01-20 13:50:14.077	\N
cmkmnio3d18ovqo4kfewg2wq7	555591112709@s.whatsapp.net	555591112709@s.whatsapp.net,5555991112709@s.whatsapp.net	2026-01-20 13:50:14.134	2026-01-20 13:50:14.134	\N
cmkmnio3j18p2qo4kgkxc2zag	555491210594@s.whatsapp.net	555491210594@s.whatsapp.net,5554991210594@s.whatsapp.net	2026-01-20 13:50:14.206	2026-01-20 13:50:14.206	\N
cmkmnio3o18p5qo4kmiq5497a	555491368813@s.whatsapp.net	555491368813@s.whatsapp.net,5554991368813@s.whatsapp.net	2026-01-20 13:50:14.215	2026-01-20 13:50:14.215	\N
cmkmnio3s18pbqo4k2s2wcfev	555491731477@s.whatsapp.net	555491731477@s.whatsapp.net,5554991731477@s.whatsapp.net	2026-01-20 13:50:14.267	2026-01-20 13:50:14.267	\N
cmkmnio3t18peqo4k6p8ezbvu	555596252516@s.whatsapp.net	555596252516@s.whatsapp.net,5555996252516@s.whatsapp.net	2026-01-20 13:50:14.326	2026-01-20 13:50:14.326	\N
cmkmnio3x18pjqo4kwbkg4104	555491322844@s.whatsapp.net	555491322844@s.whatsapp.net,5554991322844@s.whatsapp.net	2026-01-20 13:50:14.358	2026-01-20 13:50:14.358	\N
cmkmnio4018poqo4k337c1pnp	555591524150@s.whatsapp.net	555591524150@s.whatsapp.net,5555991524150@s.whatsapp.net	2026-01-20 13:50:14.412	2026-01-20 13:50:14.412	\N
cmkmnio4218psqo4ktmt4bb8j	558006472200@s.whatsapp.net	558006472200@s.whatsapp.net,5580906472200@s.whatsapp.net	2026-01-20 13:50:14.452	2026-01-20 13:50:14.452	\N
cmkmnio4418pwqo4klxpmpt85	554136669000@s.whatsapp.net	554136669000@s.whatsapp.net,5541936669000@s.whatsapp.net	2026-01-20 13:50:14.476	2026-01-20 13:50:14.476	\N
cmkmnio4618q0qo4klxzv1aph	555591591232@s.whatsapp.net	555591591232@s.whatsapp.net,5555991591232@s.whatsapp.net	2026-01-20 13:50:14.498	2026-01-20 13:50:14.498	\N
cmkmnio4d18q8qo4k1ac0zc99	555599341267@s.whatsapp.net	555599341267@s.whatsapp.net,5555999341267@s.whatsapp.net	2026-01-20 13:50:14.542	2026-01-20 13:50:14.542	\N
cmkmnio4n18qdqo4kb5n33hyx	555491551093@s.whatsapp.net	555491551093@s.whatsapp.net,5554991551093@s.whatsapp.net	2026-01-20 13:50:14.569	2026-01-20 13:50:14.569	\N
cmkmnio4p18qgqo4kdhqk083n	555492276969@s.whatsapp.net	555492276969@s.whatsapp.net,5554992276969@s.whatsapp.net	2026-01-20 13:50:14.63	2026-01-20 13:50:14.63	\N
cmkmnio4v18qkqo4ke6vh8nle	555499782828@s.whatsapp.net	555499782828@s.whatsapp.net,5554999782828@s.whatsapp.net	2026-01-20 13:50:14.635	2026-01-20 13:50:14.635	\N
cmkmnio5418qoqo4k36gh6gno	555533226756@s.whatsapp.net	555533226756@s.whatsapp.net,5555933226756@s.whatsapp.net	2026-01-20 13:50:14.659	2026-01-20 13:50:14.659	\N
cmkmniojh18raqo4k32sk9p9g	555381044540@s.whatsapp.net	555381044540@s.whatsapp.net,5553981044540@s.whatsapp.net	2026-01-20 13:50:15.486	2026-01-20 13:50:15.486	\N
cmkmnioka18rfqo4ka53xca7w	555591207113@s.whatsapp.net	555591207113@s.whatsapp.net,5555991207113@s.whatsapp.net	2026-01-20 13:50:15.515	2026-01-20 13:50:15.515	\N
cmkmnioln18rzqo4kb15v3knl	555191857507@s.whatsapp.net	555191857507@s.whatsapp.net,5551991857507@s.whatsapp.net	2026-01-20 13:50:15.563	2026-01-20 13:50:15.563	\N
cmkmniolv18s8qo4k7f6l2jhi	555499251913@s.whatsapp.net	555499251913@s.whatsapp.net,5554999251913@s.whatsapp.net	2026-01-20 13:50:15.57	2026-01-20 13:50:15.57	\N
cmkmnioly18scqo4karofekzn	555591896102@s.whatsapp.net	555591896102@s.whatsapp.net,5555991896102@s.whatsapp.net	2026-01-20 13:50:15.574	2026-01-20 13:50:15.574	\N
cmkmniom418siqo4kx92ngay3	5519981522357@s.whatsapp.net	551981522357@s.whatsapp.net,5519981522357@s.whatsapp.net	2026-01-20 13:50:15.58	2026-01-20 13:50:15.58	\N
cmkmniom918slqo4kigb0ss37	555592290330@s.whatsapp.net	555592290330@s.whatsapp.net,5555992290330@s.whatsapp.net	2026-01-20 13:50:15.582	2026-01-20 13:50:15.582	\N
cmkmniomf18soqo4kndjmcnby	554135139116@s.whatsapp.net	554135139116@s.whatsapp.net,5541935139116@s.whatsapp.net	2026-01-20 13:50:15.584	2026-01-20 13:50:15.584	\N
cmkmniomo18suqo4koa124gcw	555596823136@s.whatsapp.net	555596823136@s.whatsapp.net,5555996823136@s.whatsapp.net	2026-01-20 13:50:15.588	2026-01-20 13:50:15.588	\N
cmkmnioms18szqo4k4v1tpbl5	555491896372@s.whatsapp.net	555491896372@s.whatsapp.net,5554991896372@s.whatsapp.net	2026-01-20 13:50:15.591	2026-01-20 13:50:15.591	\N
cmkmniomv18t4qo4kifiiazlf	554896600741@s.whatsapp.net	554896600741@s.whatsapp.net,5548996600741@s.whatsapp.net	2026-01-20 13:50:15.595	2026-01-20 13:50:15.595	\N
cmkmnion118teqo4krr65m8z2	555596851999@s.whatsapp.net	555596851999@s.whatsapp.net,5555996851999@s.whatsapp.net	2026-01-20 13:50:15.603	2026-01-20 13:50:15.603	\N
cmkmnion618tkqo4khb6405em	555599716340@s.whatsapp.net	555599716340@s.whatsapp.net,5555999716340@s.whatsapp.net	2026-01-20 13:50:15.61	2026-01-20 13:50:15.61	\N
cmkmniona18tpqo4kktpnxj83	555491229258@s.whatsapp.net	555491229258@s.whatsapp.net,5554991229258@s.whatsapp.net	2026-01-20 13:50:15.619	2026-01-20 13:50:15.619	\N
cmkmnionh18trqo4kn75opg15	555499003767@s.whatsapp.net	555499003767@s.whatsapp.net,5554999003767@s.whatsapp.net	2026-01-20 13:50:15.62	2026-01-20 13:50:15.62	\N
cmkmnions18tyqo4kr72zvto7	555197761782@s.whatsapp.net	555197761782@s.whatsapp.net,5551997761782@s.whatsapp.net	2026-01-20 13:50:15.626	2026-01-20 13:50:15.626	\N
cmkmniony18u1qo4k1wfodvk8	555591185511@s.whatsapp.net	555591185511@s.whatsapp.net,5555991185511@s.whatsapp.net	2026-01-20 13:50:15.626	2026-01-20 13:50:15.626	\N
cmkmnioo818u8qo4kvqe7kjop	555599197011@s.whatsapp.net	555599197011@s.whatsapp.net,5555999197011@s.whatsapp.net	2026-01-20 13:50:15.63	2026-01-20 13:50:15.63	\N
cmkmniooi18ueqo4k82o84ax8	555431720980@s.whatsapp.net	555431720980@s.whatsapp.net,5554931720980@s.whatsapp.net	2026-01-20 13:50:15.635	2026-01-20 13:50:15.635	\N
cmkmniool18ugqo4kmevz3ix7	555433168100@s.whatsapp.net	555433168100@s.whatsapp.net,5554933168100@s.whatsapp.net	2026-01-20 13:50:15.635	2026-01-20 13:50:15.635	\N
cmkmniooo18ulqo4kirugo35q	555591989898@s.whatsapp.net	555591989898@s.whatsapp.net,5555991989898@s.whatsapp.net	2026-01-20 13:50:15.637	2026-01-20 13:50:15.637	\N
cmkmnioox18uqqo4krcwggat7	555591836710@s.whatsapp.net	555591836710@s.whatsapp.net,5555991836710@s.whatsapp.net	2026-01-20 13:50:15.642	2026-01-20 13:50:15.642	\N
cmkmniop118uuqo4kj1e81bix	5522988285973@s.whatsapp.net	552288285973@s.whatsapp.net,5522988285973@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniop618v2qo4kikg37086	555597114720@s.whatsapp.net	555597114720@s.whatsapp.net,5555997114720@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniopb18v6qo4kfjy7gz2q	555591729734@s.whatsapp.net	555591729734@s.whatsapp.net,5555991729734@s.whatsapp.net	2026-01-20 13:50:15.648	2026-01-20 13:50:15.648	\N
cmkmniopp18vfqo4kfiz8et6f	555584460856@s.whatsapp.net	555584460856@s.whatsapp.net,5555984460856@s.whatsapp.net	2026-01-20 13:50:15.654	2026-01-20 13:50:15.654	\N
cmkmniopt18vhqo4k94fj2roa	555491846844@s.whatsapp.net	555491846844@s.whatsapp.net,5554991846844@s.whatsapp.net	2026-01-20 13:50:15.654	2026-01-20 13:50:15.654	\N
cmkmnioq318vnqo4kp0rhdq78	555491124163@s.whatsapp.net	555491124163@s.whatsapp.net,5554991124163@s.whatsapp.net	2026-01-20 13:50:15.659	2026-01-20 13:50:15.659	\N
cmkmnioq518vrqo4kf0zvj1ps	555597099033@s.whatsapp.net	555597099033@s.whatsapp.net,5555997099033@s.whatsapp.net	2026-01-20 13:50:15.659	2026-01-20 13:50:15.659	\N
cmkmnioq918vxqo4kvcmdr2qp	555599030888@s.whatsapp.net	555599030888@s.whatsapp.net,5555999030888@s.whatsapp.net	2026-01-20 13:50:15.663	2026-01-20 13:50:15.663	\N
cmkmnio4918q4qo4kvymtp64w	555433243879@s.whatsapp.net	262534254825621@lid,555433243879@s.whatsapp.net,5554933243879@s.whatsapp.net	2026-01-20 13:50:14.519	2026-01-25 20:43:08.247	\N
cmkmnio3h18oyqo4kpivd4swt	555181283581@s.whatsapp.net	145036784210100@lid,555181283581@s.whatsapp.net,5551981283581@s.whatsapp.net	2026-01-20 13:50:14.162	2026-02-06 19:15:16.959	\N
cmkmniolq18s3qo4kkpduujtz	558000390039@s.whatsapp.net	112974853353637@lid,558000390039@s.whatsapp.net,5580900390039@s.whatsapp.net	2026-01-20 13:50:15.567	2026-02-21 00:21:28.985	\N
cmkmnionp18twqo4kymew1qlf	555591958377@s.whatsapp.net	555591958377@s.whatsapp.net,5555991958377@s.whatsapp.net	2026-01-20 13:50:15.625	2026-01-20 13:50:15.625	\N
cmkmnioo018u3qo4k2h42c9g2	555491039199@s.whatsapp.net	555491039199@s.whatsapp.net,5554991039199@s.whatsapp.net	2026-01-20 13:50:15.628	2026-01-20 13:50:15.628	\N
cmkmnioo818u7qo4kdc8flvpf	555491580504@s.whatsapp.net	555491580504@s.whatsapp.net,5554991580504@s.whatsapp.net	2026-01-20 13:50:15.629	2026-01-20 13:50:15.629	\N
cmkmniooi18udqo4k543zbujz	555194691399@s.whatsapp.net	555194691399@s.whatsapp.net,5551994691399@s.whatsapp.net	2026-01-20 13:50:15.634	2026-01-20 13:50:15.634	\N
cmkmnioon18ukqo4kppnkt98e	555591771914@s.whatsapp.net	555591771914@s.whatsapp.net,5555991771914@s.whatsapp.net	2026-01-20 13:50:15.636	2026-01-20 13:50:15.636	\N
cmkmnioor18uoqo4k4y6vijgt	555491094584@s.whatsapp.net	555491094584@s.whatsapp.net,5554991094584@s.whatsapp.net	2026-01-20 13:50:15.64	2026-01-20 13:50:15.64	\N
cmkmniop018usqo4kbjpw4z0t	555591570126@s.whatsapp.net	555591570126@s.whatsapp.net,5555991570126@s.whatsapp.net	2026-01-20 13:50:15.642	2026-01-20 13:50:15.642	\N
cmkmniop418uxqo4k5qam4fgi	555183197778@s.whatsapp.net	555183197778@s.whatsapp.net,5551983197778@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniop618v1qo4kg65sibol	555591903969@s.whatsapp.net	555591903969@s.whatsapp.net,5555991903969@s.whatsapp.net	2026-01-20 13:50:15.644	2026-01-20 13:50:15.644	\N
cmkmniopc18v7qo4kgapcsjht	555597259510@s.whatsapp.net	555597259510@s.whatsapp.net,5555997259510@s.whatsapp.net	2026-01-20 13:50:15.648	2026-01-20 13:50:15.648	\N
cmkmniopj18vbqo4kuhj6vupq	555199195074@s.whatsapp.net	555199195074@s.whatsapp.net,5551999195074@s.whatsapp.net	2026-01-20 13:50:15.653	2026-01-20 13:50:15.653	\N
cmkmniopq18vgqo4ka51ysufl	554799231751@s.whatsapp.net	554799231751@s.whatsapp.net,5547999231751@s.whatsapp.net	2026-01-20 13:50:15.654	2026-01-20 13:50:15.654	\N
cmkmnioq118vlqo4kyqfqo650	555491677720@s.whatsapp.net	555491677720@s.whatsapp.net,5554991677720@s.whatsapp.net	2026-01-20 13:50:15.655	2026-01-20 13:50:15.655	\N
cmkmnioq318vqqo4k31kysli5	555491750360@s.whatsapp.net	555491750360@s.whatsapp.net,5554991750360@s.whatsapp.net	2026-01-20 13:50:15.659	2026-01-20 13:50:15.659	\N
cmkmnioqg18vzqo4kad95fmwf	555491381200@s.whatsapp.net	555491381200@s.whatsapp.net,5554991381200@s.whatsapp.net	2026-01-20 13:50:15.663	2026-01-20 13:50:15.663	\N
cmkmnior618wbqo4kg7a7j3rx	555491162457@s.whatsapp.net	555491162457@s.whatsapp.net,5554991162457@s.whatsapp.net	2026-01-20 13:50:15.671	2026-01-20 13:50:15.671	\N
cmkmnior918wfqo4kseo5mf1i	555584397301@s.whatsapp.net	555584397301@s.whatsapp.net,5555984397301@s.whatsapp.net	2026-01-20 13:50:15.674	2026-01-20 13:50:15.674	\N
cmkmniore18wlqo4kgkvoi0zp	555599322298@s.whatsapp.net	555599322298@s.whatsapp.net,5555999322298@s.whatsapp.net	2026-01-20 13:50:15.683	2026-01-20 13:50:15.683	\N
cmkmniork18wpqo4k48dbnog6	555199550002@s.whatsapp.net	555199550002@s.whatsapp.net,5551999550002@s.whatsapp.net	2026-01-20 13:50:15.688	2026-01-20 13:50:15.688	\N
cmkmniorw18wtqo4ke213rdr3	555591727177@s.whatsapp.net	555591727177@s.whatsapp.net,5555991727177@s.whatsapp.net	2026-01-20 13:50:15.694	2026-01-20 13:50:15.694	\N
cmkmnios018wxqo4krw571bzx	555433243693@s.whatsapp.net	555433243693@s.whatsapp.net,5554933243693@s.whatsapp.net	2026-01-20 13:50:15.697	2026-01-20 13:50:15.697	\N
cmkmnios818x0qo4kwe0t683o	5519981612182@s.whatsapp.net	551981612182@s.whatsapp.net,5519981612182@s.whatsapp.net	2026-01-20 13:50:15.698	2026-01-20 13:50:15.698	\N
cmkmniosh18x5qo4k5cvn429v	559984445197@s.whatsapp.net	559984445197@s.whatsapp.net,5599984445197@s.whatsapp.net	2026-01-20 13:50:15.701	2026-01-20 13:50:15.701	\N
cmkmniosl18xbqo4kvbdpi853	555491215214@s.whatsapp.net	555491215214@s.whatsapp.net,5554991215214@s.whatsapp.net	2026-01-20 13:50:15.705	2026-01-20 13:50:15.705	\N
cmkmnioss18xfqo4kgruzvtpn	555491950129@s.whatsapp.net	555491950129@s.whatsapp.net,5554991950129@s.whatsapp.net	2026-01-20 13:50:15.708	2026-01-20 13:50:15.708	\N
cmkmniosy18xlqo4kyot5p3gn	555591225102@s.whatsapp.net	555591225102@s.whatsapp.net,5555991225102@s.whatsapp.net	2026-01-20 13:50:15.711	2026-01-20 13:50:15.711	\N
cmkmniot818xtqo4kj58dwcly	558599020592@s.whatsapp.net	558599020592@s.whatsapp.net,5585999020592@s.whatsapp.net	2026-01-20 13:50:15.717	2026-01-20 13:50:15.717	\N
cmkmniotm18y3qo4kotc85920	555492135812@s.whatsapp.net	555492135812@s.whatsapp.net,5554992135812@s.whatsapp.net	2026-01-20 13:50:15.72	2026-01-20 13:50:15.72	\N
cmkmniotp18y5qo4kg0e59l7q	555581713562@s.whatsapp.net	555581713562@s.whatsapp.net,5555981713562@s.whatsapp.net	2026-01-20 13:50:15.721	2026-01-20 13:50:15.721	\N
cmkmniotr18y9qo4kccx1icc9	555491587551@s.whatsapp.net	555491587551@s.whatsapp.net,5554991587551@s.whatsapp.net	2026-01-20 13:50:15.726	2026-01-20 13:50:15.726	\N
cmkmniotw18yfqo4kp9hjbghg	555596075977@s.whatsapp.net	555596075977@s.whatsapp.net,5555996075977@s.whatsapp.net	2026-01-20 13:50:15.733	2026-01-20 13:50:15.733	\N
cmkmniou018ykqo4kdn9p1gzp	555596090157@s.whatsapp.net	555596090157@s.whatsapp.net,5555996090157@s.whatsapp.net	2026-01-20 13:50:15.735	2026-01-20 13:50:15.735	\N
cmkmniou418ypqo4k78spx4si	555491339506@s.whatsapp.net	555491339506@s.whatsapp.net,5554991339506@s.whatsapp.net	2026-01-20 13:50:15.74	2026-01-20 13:50:15.74	\N
cmkmniou718ytqo4k4oi4qk4h	555584098243@s.whatsapp.net	555584098243@s.whatsapp.net,5555984098243@s.whatsapp.net	2026-01-20 13:50:15.741	2026-01-20 13:50:15.741	\N
cmkmnioud18z0qo4kjejqvn0d	555596451211@s.whatsapp.net	555596451211@s.whatsapp.net,5555996451211@s.whatsapp.net	2026-01-20 13:50:15.754	2026-01-20 13:50:15.754	\N
cmkmnioui18z7qo4kiqd31of1	555491920475@s.whatsapp.net	555491920475@s.whatsapp.net,5554991920475@s.whatsapp.net	2026-01-20 13:50:15.761	2026-01-20 13:50:15.761	\N
cmkmnioul18zcqo4k6b7ldk8w	555491545141@s.whatsapp.net	555491545141@s.whatsapp.net,5554991545141@s.whatsapp.net	2026-01-20 13:50:15.765	2026-01-20 13:50:15.765	\N
cmkmnious18zkqo4ksynz3sbk	555584110019@s.whatsapp.net	555584110019@s.whatsapp.net,5555984110019@s.whatsapp.net	2026-01-20 13:50:15.77	2026-01-20 13:50:15.77	\N
cmkmniov81901qo4klzft9qna	555591752200@s.whatsapp.net	555591752200@s.whatsapp.net,5555991752200@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniovb1905qo4kydcy0zpi	555491486976@s.whatsapp.net	555491486976@s.whatsapp.net,5554991486976@s.whatsapp.net	2026-01-20 13:50:15.785	2026-01-20 13:50:15.785	\N
cmkmniovd190aqo4ktuz0vbw9	555491637519@s.whatsapp.net	555491637519@s.whatsapp.net,5554991637519@s.whatsapp.net	2026-01-20 13:50:15.789	2026-01-20 13:50:15.789	\N
cmkmniovm190bqo4kaqhwf7o5	555499391852@s.whatsapp.net	555499391852@s.whatsapp.net,5554999391852@s.whatsapp.net	2026-01-20 13:50:15.789	2026-01-20 13:50:15.789	\N
cmkmniovp190gqo4knb2iwc11	555499155339@s.whatsapp.net	555499155339@s.whatsapp.net,5554999155339@s.whatsapp.net	2026-01-20 13:50:15.792	2026-01-20 13:50:15.792	\N
cmkmniovz190pqo4k1goptlex	555491007955@s.whatsapp.net	555491007955@s.whatsapp.net,5554991007955@s.whatsapp.net	2026-01-20 13:50:15.808	2026-01-20 13:50:15.808	\N
cmkmniow4190vqo4k8it0eagl	555491740891@s.whatsapp.net	555491740891@s.whatsapp.net,5554991740891@s.whatsapp.net	2026-01-20 13:50:15.811	2026-01-20 13:50:15.811	\N
cmkmniow81910qo4kkdxnw0g1	555591379505@s.whatsapp.net	555591379505@s.whatsapp.net,5555991379505@s.whatsapp.net	2026-01-20 13:50:15.816	2026-01-20 13:50:15.816	\N
cmkmniowc1917qo4kptc7y326	555591725513@s.whatsapp.net	555591725513@s.whatsapp.net,5555991725513@s.whatsapp.net	2026-01-20 13:50:15.823	2026-01-20 13:50:15.823	\N
cmkmnioqo18w5qo4kt0793i9v	555491651308@s.whatsapp.net	129312959254557@lid,555491651308@s.whatsapp.net,5554991651308@s.whatsapp.net	2026-01-20 13:50:15.666	2026-02-01 23:31:02.71	\N
cmkmnioq818vwqo4kl9upt0ii	555591787695@s.whatsapp.net	236116045246713@lid,555591787695@s.whatsapp.net,5555991787695@s.whatsapp.net	2026-01-20 13:50:15.663	2026-02-09 15:00:05.194	\N
cmkmniovs190jqo4kluh4qp6x	555499408826@s.whatsapp.net	45892077920491@lid,555499408826@s.whatsapp.net,5554999408826@s.whatsapp.net	2026-01-20 13:50:15.797	2026-02-11 21:04:12.294	\N
cmkmniopu18vkqo4khhr12sdp	555591667083@s.whatsapp.net	555591667083@s.whatsapp.net,5555991667083@s.whatsapp.net	2026-01-20 13:50:15.655	2026-01-20 13:50:15.655	\N
cmkmnioq318voqo4kyld8moll	555491579891@s.whatsapp.net	555491579891@s.whatsapp.net,5554991579891@s.whatsapp.net	2026-01-20 13:50:15.659	2026-01-20 13:50:15.659	\N
cmkmnioq818vvqo4k8mk33ppn	555497084758@s.whatsapp.net	555497084758@s.whatsapp.net,5554997084758@s.whatsapp.net	2026-01-20 13:50:15.663	2026-01-20 13:50:15.663	\N
cmkmnioqh18w1qo4kulffe98g	555496332985@s.whatsapp.net	555496332985@s.whatsapp.net,5554996332985@s.whatsapp.net	2026-01-20 13:50:15.665	2026-01-20 13:50:15.665	\N
cmkmniora18wgqo4k8u0hade8	555591652300@s.whatsapp.net	555591652300@s.whatsapp.net,5555991652300@s.whatsapp.net	2026-01-20 13:50:15.675	2026-01-20 13:50:15.675	\N
cmkmniorg18wnqo4k1ptz2j4e	555481224983@s.whatsapp.net	555481224983@s.whatsapp.net,5554981224983@s.whatsapp.net	2026-01-20 13:50:15.685	2026-01-20 13:50:15.685	\N
cmkmnioru18wsqo4kt8hyh3vg	555484063188@s.whatsapp.net	555484063188@s.whatsapp.net,5554984063188@s.whatsapp.net	2026-01-20 13:50:15.693	2026-01-20 13:50:15.693	\N
cmkmniorz18wvqo4k4ifc8hyn	555181148181@s.whatsapp.net	555181148181@s.whatsapp.net,5551981148181@s.whatsapp.net	2026-01-20 13:50:15.695	2026-01-20 13:50:15.695	\N
cmkmniosh18x4qo4kfmys5yd5	555497154646@s.whatsapp.net	555497154646@s.whatsapp.net,5554997154646@s.whatsapp.net	2026-01-20 13:50:15.7	2026-01-20 13:50:15.7	\N
cmkmniosk18xaqo4ksbrm7ivd	555499350324@s.whatsapp.net	555499350324@s.whatsapp.net,5554999350324@s.whatsapp.net	2026-01-20 13:50:15.705	2026-01-20 13:50:15.705	\N
cmkmnioss18xdqo4kwhe36hox	555596161936@s.whatsapp.net	555596161936@s.whatsapp.net,5555996161936@s.whatsapp.net	2026-01-20 13:50:15.706	2026-01-20 13:50:15.706	\N
cmkmniosy18xiqo4k1k39lo0h	555491699705@s.whatsapp.net	555491699705@s.whatsapp.net,5554991699705@s.whatsapp.net	2026-01-20 13:50:15.709	2026-01-20 13:50:15.709	\N
cmkmniot018xnqo4khc6o5dev	555599224095@s.whatsapp.net	555599224095@s.whatsapp.net,5555999224095@s.whatsapp.net	2026-01-20 13:50:15.712	2026-01-20 13:50:15.712	\N
cmkmniot218xpqo4k8czo0072	555584467547@s.whatsapp.net	555584467547@s.whatsapp.net,5555984467547@s.whatsapp.net	2026-01-20 13:50:15.713	2026-01-20 13:50:15.713	\N
cmkmniot818xuqo4k0lm5s36p	555491285392@s.whatsapp.net	555491285392@s.whatsapp.net,5554991285392@s.whatsapp.net	2026-01-20 13:50:15.716	2026-01-20 13:50:15.716	\N
cmkmnioti18xyqo4krsla96o3	555591797694@s.whatsapp.net	555591797694@s.whatsapp.net,5555991797694@s.whatsapp.net	2026-01-20 13:50:15.719	2026-01-20 13:50:15.719	\N
cmkmniotp18y6qo4k9d9yvoqw	555433241494@s.whatsapp.net	555433241494@s.whatsapp.net,5554933241494@s.whatsapp.net	2026-01-20 13:50:15.722	2026-01-20 13:50:15.722	\N
cmkmniotv18ybqo4kp07x2ss2	555491899387@s.whatsapp.net	555491899387@s.whatsapp.net,5554991899387@s.whatsapp.net	2026-01-20 13:50:15.728	2026-01-20 13:50:15.728	\N
cmkmniotw18ygqo4k6wi08vpc	555599690066@s.whatsapp.net	555599690066@s.whatsapp.net,5555999690066@s.whatsapp.net	2026-01-20 13:50:15.733	2026-01-20 13:50:15.733	\N
cmkmniou018yjqo4kimf6hy9b	555481322412@s.whatsapp.net	555481322412@s.whatsapp.net,5554981322412@s.whatsapp.net	2026-01-20 13:50:15.734	2026-01-20 13:50:15.734	\N
cmkmniou218ynqo4k8g6nguj5	555599424932@s.whatsapp.net	555599424932@s.whatsapp.net,5555999424932@s.whatsapp.net	2026-01-20 13:50:15.739	2026-01-20 13:50:15.739	\N
cmkmniou618yrqo4k2yc6hkmt	555596353658@s.whatsapp.net	555596353658@s.whatsapp.net,5555996353658@s.whatsapp.net	2026-01-20 13:50:15.74	2026-01-20 13:50:15.74	\N
cmkmniou818ywqo4kvgbq840p	555496361595@s.whatsapp.net	555496361595@s.whatsapp.net,5554996361595@s.whatsapp.net	2026-01-20 13:50:15.743	2026-01-20 13:50:15.743	\N
cmkmniouc18yxqo4kda9e1o6u	555491223214@s.whatsapp.net	555491223214@s.whatsapp.net,5554991223214@s.whatsapp.net	2026-01-20 13:50:15.744	2026-01-20 13:50:15.744	\N
cmkmnioue18z2qo4kkw0loz3m	555491516846@s.whatsapp.net	555491516846@s.whatsapp.net,5554991516846@s.whatsapp.net	2026-01-20 13:50:15.755	2026-01-20 13:50:15.755	\N
cmkmnioui18z5qo4k08huqa2q	555599641898@s.whatsapp.net	555599641898@s.whatsapp.net,5555999641898@s.whatsapp.net	2026-01-20 13:50:15.757	2026-01-20 13:50:15.757	\N
cmkmniouk18zbqo4kc0lnxgml	555491732819@s.whatsapp.net	555491732819@s.whatsapp.net,5554991732819@s.whatsapp.net	2026-01-20 13:50:15.765	2026-01-20 13:50:15.765	\N
cmkmniout18zmqo4k26rzhnx7	555599566278@s.whatsapp.net	555599566278@s.whatsapp.net,5555999566278@s.whatsapp.net	2026-01-20 13:50:15.771	2026-01-20 13:50:15.771	\N
cmkmniov418zsqo4k41ugwvnb	555491135607@s.whatsapp.net	555491135607@s.whatsapp.net,5554991135607@s.whatsapp.net	2026-01-20 13:50:15.774	2026-01-20 13:50:15.774	\N
cmkmniov518zxqo4k851rb0s0	555584266894@s.whatsapp.net	555584266894@s.whatsapp.net,5555984266894@s.whatsapp.net	2026-01-20 13:50:15.777	2026-01-20 13:50:15.777	\N
cmkmniov81902qo4kwvlshywu	555596441839@s.whatsapp.net	555596441839@s.whatsapp.net,5555996441839@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniovm190cqo4kg8irer3p	555584165418@s.whatsapp.net	555584165418@s.whatsapp.net,5555984165418@s.whatsapp.net	2026-01-20 13:50:15.79	2026-01-20 13:50:15.79	\N
cmkmniovu190lqo4km3f6zpcn	555596264838@s.whatsapp.net	555596264838@s.whatsapp.net,5555996264838@s.whatsapp.net	2026-01-20 13:50:15.797	2026-01-20 13:50:15.797	\N
cmkmniow1190sqo4ke9abbf9s	555599892046@s.whatsapp.net	555599892046@s.whatsapp.net,5555999892046@s.whatsapp.net	2026-01-20 13:50:15.808	2026-01-20 13:50:15.808	\N
cmkmniow5190wqo4kcw8i5da5	555491788137@s.whatsapp.net	555491788137@s.whatsapp.net,5554991788137@s.whatsapp.net	2026-01-20 13:50:15.81	2026-01-20 13:50:15.81	\N
cmkmniowg191aqo4kuvrc6l5t	555481005582@s.whatsapp.net	555481005582@s.whatsapp.net,5554981005582@s.whatsapp.net	2026-01-20 13:50:15.826	2026-01-20 13:50:15.826	\N
cmkmniowk191hqo4k0w3uhw21	555581004459@s.whatsapp.net	555581004459@s.whatsapp.net,5555981004459@s.whatsapp.net	2026-01-20 13:50:15.836	2026-01-20 13:50:15.836	\N
cmkmniowo191mqo4ktihjnght	555491682208@s.whatsapp.net	555491682208@s.whatsapp.net,5554991682208@s.whatsapp.net	2026-01-20 13:50:15.84	2026-01-20 13:50:15.84	\N
cmkmniowx191qqo4kw0xm3cr7	555599659496@s.whatsapp.net	555599659496@s.whatsapp.net,5555999659496@s.whatsapp.net	2026-01-20 13:50:15.844	2026-01-20 13:50:15.844	\N
cmkmniox1191wqo4k7nik635f	555581161300@s.whatsapp.net	555581161300@s.whatsapp.net,5555981161300@s.whatsapp.net	2026-01-20 13:50:15.846	2026-01-20 13:50:15.846	\N
cmkmniox41922qo4kqx7aztnt	351939606431@s.whatsapp.net	351939606431@s.whatsapp.net@s.whatsapp.net	2026-01-20 13:50:15.85	2026-01-20 13:50:15.85	\N
cmkmniox51926qo4kjgykbxg5	555491644510@s.whatsapp.net	555491644510@s.whatsapp.net,5554991644510@s.whatsapp.net	2026-01-20 13:50:15.854	2026-01-20 13:50:15.854	\N
cmkmniox9192aqo4kz7vr4hye	555599622930@s.whatsapp.net	555599622930@s.whatsapp.net,5555999622930@s.whatsapp.net	2026-01-20 13:50:15.858	2026-01-20 13:50:15.858	\N
cmkmnioxd192iqo4kadlisg9j	555491051530@s.whatsapp.net	555491051530@s.whatsapp.net,5554991051530@s.whatsapp.net	2026-01-20 13:50:15.868	2026-01-20 13:50:15.868	\N
cmkmnioxf192lqo4k2aduw134	555591518621@s.whatsapp.net	555591518621@s.whatsapp.net,5555991518621@s.whatsapp.net	2026-01-20 13:50:15.876	2026-01-20 13:50:15.876	\N
cmkmnioqp18w6qo4k24usrl9h	555491983253@s.whatsapp.net	155958953144506@lid,555491983253@s.whatsapp.net,5554991983253@s.whatsapp.net	2026-01-20 13:50:15.668	2026-01-24 01:03:22.992	\N
cmkmniovc1907qo4keg987j2r	555492136353@s.whatsapp.net	141115562922108@lid,555492136353@s.whatsapp.net,5554992136353@s.whatsapp.net	2026-01-20 13:50:15.785	2026-01-27 19:21:51.017	\N
cmkmnios818x1qo4kq3nhnguj	555499561815@s.whatsapp.net	555499561815@s.whatsapp.net,5554999561815@s.whatsapp.net,60632170807415@lid	2026-01-20 13:50:15.698	2026-02-21 00:21:28.996	\N
cmkmnior218waqo4kspxtw4sx	555491347762@s.whatsapp.net	127401648517136@lid,555491347762@s.whatsapp.net,5554991347762@s.whatsapp.net	2026-01-20 13:50:15.669	2026-02-21 00:21:29.178	\N
cmkmnioqm18w3qo4kh3hadxg9	555491346064@s.whatsapp.net	555491346064@s.whatsapp.net,5554991346064@s.whatsapp.net	2026-01-20 13:50:15.665	2026-01-20 13:50:15.665	\N
cmkmnioqs18w8qo4ku2xn2byq	555491439840@s.whatsapp.net	555491439840@s.whatsapp.net,5554991439840@s.whatsapp.net	2026-01-20 13:50:15.668	2026-01-20 13:50:15.668	\N
cmkmnior818wdqo4khpuqt4se	555491951777@s.whatsapp.net	555491951777@s.whatsapp.net,5554991951777@s.whatsapp.net	2026-01-20 13:50:15.674	2026-01-20 13:50:15.674	\N
cmkmniorc18wjqo4kqs1x2vu6	555496281988@s.whatsapp.net	555496281988@s.whatsapp.net,5554996281988@s.whatsapp.net	2026-01-20 13:50:15.683	2026-01-20 13:50:15.683	\N
cmkmniory18wuqo4k2p3r8tfh	555596532560@s.whatsapp.net	555596532560@s.whatsapp.net,5555996532560@s.whatsapp.net	2026-01-20 13:50:15.695	2026-01-20 13:50:15.695	\N
cmkmnios918x3qo4kd3dly0so	555491746334@s.whatsapp.net	555491746334@s.whatsapp.net,5554991746334@s.whatsapp.net	2026-01-20 13:50:15.699	2026-01-20 13:50:15.699	\N
cmkmniosk18x8qo4kmkgw7wnl	555491960043@s.whatsapp.net	555491960043@s.whatsapp.net,5554991960043@s.whatsapp.net	2026-01-20 13:50:15.703	2026-01-20 13:50:15.703	\N
cmkmniost18xgqo4kjdsqkuc2	555492678094@s.whatsapp.net	555492678094@s.whatsapp.net,5554992678094@s.whatsapp.net	2026-01-20 13:50:15.708	2026-01-20 13:50:15.708	\N
cmkmniot218xqqo4kt0yt5yfp	555533226060@s.whatsapp.net	555533226060@s.whatsapp.net,5555933226060@s.whatsapp.net	2026-01-20 13:50:15.715	2026-01-20 13:50:15.715	\N
cmkmniotd18xwqo4kalpdyz6i	555591510881@s.whatsapp.net	555591510881@s.whatsapp.net,5555991510881@s.whatsapp.net	2026-01-20 13:50:15.718	2026-01-20 13:50:15.718	\N
cmkmniotj18xzqo4kj0kw2qx9	555584675844@s.whatsapp.net	555584675844@s.whatsapp.net,5555984675844@s.whatsapp.net	2026-01-20 13:50:15.718	2026-01-20 13:50:15.718	\N
cmkmniotk18y1qo4ktkma4pn6	555182434970@s.whatsapp.net	555182434970@s.whatsapp.net,5551982434970@s.whatsapp.net	2026-01-20 13:50:15.72	2026-01-20 13:50:15.72	\N
cmkmniott18yaqo4kacsb48sv	555491749945@s.whatsapp.net	555491749945@s.whatsapp.net,5554991749945@s.whatsapp.net	2026-01-20 13:50:15.727	2026-01-20 13:50:15.727	\N
cmkmniou218yoqo4ku3vqlirk	555499001165@s.whatsapp.net	555499001165@s.whatsapp.net,5554999001165@s.whatsapp.net	2026-01-20 13:50:15.739	2026-01-20 13:50:15.739	\N
cmkmniou718yuqo4klcut526k	555599522464@s.whatsapp.net	555599522464@s.whatsapp.net,5555999522464@s.whatsapp.net	2026-01-20 13:50:15.742	2026-01-20 13:50:15.742	\N
cmkmnioui18z6qo4k3a4sjdef	555591396119@s.whatsapp.net	555591396119@s.whatsapp.net,5555991396119@s.whatsapp.net	2026-01-20 13:50:15.759	2026-01-20 13:50:15.759	\N
cmkmniouk18z9qo4k7q947oe3	555496055851@s.whatsapp.net	555496055851@s.whatsapp.net,5554996055851@s.whatsapp.net	2026-01-20 13:50:15.763	2026-01-20 13:50:15.763	\N
cmkmnioun18zeqo4kx23rpxxx	555591083810@s.whatsapp.net	555591083810@s.whatsapp.net,5555991083810@s.whatsapp.net	2026-01-20 13:50:15.767	2026-01-20 13:50:15.767	\N
cmkmniout18zlqo4kpm20h7gn	555433317588@s.whatsapp.net	555433317588@s.whatsapp.net,5554933317588@s.whatsapp.net	2026-01-20 13:50:15.771	2026-01-20 13:50:15.771	\N
cmkmniov218zrqo4k0yjkj0fy	555499173343@s.whatsapp.net	555499173343@s.whatsapp.net,5554999173343@s.whatsapp.net	2026-01-20 13:50:15.774	2026-01-20 13:50:15.774	\N
cmkmniov418ztqo4kwwrelttn	555491915273@s.whatsapp.net	555491915273@s.whatsapp.net,5554991915273@s.whatsapp.net	2026-01-20 13:50:15.776	2026-01-20 13:50:15.776	\N
cmkmniov71900qo4k0hqx4y1d	555591553371@s.whatsapp.net	555591553371@s.whatsapp.net,5555991553371@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniova1904qo4kbr6xih02	555499319724@s.whatsapp.net	555499319724@s.whatsapp.net,5554999319724@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniovc1908qo4kf15c1khy	555584287799@s.whatsapp.net	555584287799@s.whatsapp.net,5555984287799@s.whatsapp.net	2026-01-20 13:50:15.786	2026-01-20 13:50:15.786	\N
cmkmniovn190fqo4k5urb00p3	555491415632@s.whatsapp.net	555491415632@s.whatsapp.net,5554991415632@s.whatsapp.net	2026-01-20 13:50:15.792	2026-01-20 13:50:15.792	\N
cmkmniovq190hqo4kt4l0ljvt	555584171462@s.whatsapp.net	555584171462@s.whatsapp.net,5555984171462@s.whatsapp.net	2026-01-20 13:50:15.792	2026-01-20 13:50:15.792	\N
cmkmniow3190uqo4k8l1r422e	555491680071@s.whatsapp.net	555491680071@s.whatsapp.net,5554991680071@s.whatsapp.net	2026-01-20 13:50:15.81	2026-01-20 13:50:15.81	\N
cmkmniow81911qo4kxuzpxa7t	5537936186277@s.whatsapp.net	553736186277@s.whatsapp.net,5537936186277@s.whatsapp.net	2026-01-20 13:50:15.817	2026-01-20 13:50:15.817	\N
cmkmniowb1915qo4kw2pjdrv8	555599409066@s.whatsapp.net	555599409066@s.whatsapp.net,5555999409066@s.whatsapp.net	2026-01-20 13:50:15.823	2026-01-20 13:50:15.823	\N
cmkmniowg191bqo4k61oojxgv	555481166168@s.whatsapp.net	555481166168@s.whatsapp.net,5554981166168@s.whatsapp.net	2026-01-20 13:50:15.827	2026-01-20 13:50:15.827	\N
cmkmniowi191fqo4k0ysfafkk	555499231996@s.whatsapp.net	555499231996@s.whatsapp.net,5554999231996@s.whatsapp.net	2026-01-20 13:50:15.832	2026-01-20 13:50:15.832	\N
cmkmniown191lqo4k5geie6c6	555499060589@s.whatsapp.net	555499060589@s.whatsapp.net,5554999060589@s.whatsapp.net	2026-01-20 13:50:15.839	2026-01-20 13:50:15.839	\N
cmkmniowx191rqo4khibxc0ga	555499816654@s.whatsapp.net	555499816654@s.whatsapp.net,5554999816654@s.whatsapp.net	2026-01-20 13:50:15.844	2026-01-20 13:50:15.844	\N
cmkmniox1191xqo4ko6yilfgc	555591329838@s.whatsapp.net	555591329838@s.whatsapp.net,5555991329838@s.whatsapp.net	2026-01-20 13:50:15.846	2026-01-20 13:50:15.846	\N
cmkmniox31921qo4kp5ysooi9	555491004160@s.whatsapp.net	555491004160@s.whatsapp.net,5554991004160@s.whatsapp.net	2026-01-20 13:50:15.847	2026-01-20 13:50:15.847	\N
cmkmniox51925qo4k2t8i1a6i	554799239553@s.whatsapp.net	554799239553@s.whatsapp.net,5547999239553@s.whatsapp.net	2026-01-20 13:50:15.853	2026-01-20 13:50:15.853	\N
cmkmniox9192bqo4k63jdccc2	555581019494@s.whatsapp.net	555581019494@s.whatsapp.net,5555981019494@s.whatsapp.net	2026-01-20 13:50:15.859	2026-01-20 13:50:15.859	\N
cmkmnioxd192gqo4k0iye8zws	555496878297@s.whatsapp.net	555496878297@s.whatsapp.net,5554996878297@s.whatsapp.net	2026-01-20 13:50:15.865	2026-01-20 13:50:15.865	\N
cmkmnioxf192mqo4kb79ycnyz	555492224338@s.whatsapp.net	555492224338@s.whatsapp.net,5554992224338@s.whatsapp.net	2026-01-20 13:50:15.876	2026-01-20 13:50:15.876	\N
cmkmnioxi192qqo4kv8qthcar	555499770012@s.whatsapp.net	555499770012@s.whatsapp.net,5554999770012@s.whatsapp.net	2026-01-20 13:50:15.883	2026-01-20 13:50:15.883	\N
cmkmnioxl192xqo4kprv0phiw	555484271514@s.whatsapp.net	555484271514@s.whatsapp.net,5554984271514@s.whatsapp.net	2026-01-20 13:50:15.891	2026-01-20 13:50:15.891	\N
cmkmnioxr1932qo4kgys5iiya	555596376077@s.whatsapp.net	555596376077@s.whatsapp.net,5555996376077@s.whatsapp.net	2026-01-20 13:50:15.895	2026-01-20 13:50:15.895	\N
cmkmnioy0193aqo4kt0petet8	555492511300@s.whatsapp.net	555492511300@s.whatsapp.net,5554992511300@s.whatsapp.net	2026-01-20 13:50:15.899	2026-01-20 13:50:15.899	\N
cmkmniovz190qqo4kc6z1bgbs	555591774126@s.whatsapp.net	212227386794166@lid,555591774126@s.whatsapp.net,5555991774126@s.whatsapp.net	2026-01-20 13:50:15.808	2026-02-13 17:21:20.833	\N
cmkmniotw18yeqo4kucft1qmx	555497039466@s.whatsapp.net	209590763401320@lid,555497039466@s.whatsapp.net,5554997039466@s.whatsapp.net	2026-01-20 13:50:15.73	2026-02-02 14:05:32.765	\N
cmkmniosy18xjqo4ku232phqp	557399846928@s.whatsapp.net	129802635837477@lid,557399846928@s.whatsapp.net,5573999846928@s.whatsapp.net	2026-01-20 13:50:15.709	2026-01-29 19:29:58.148	\N
cmkmniovx190oqo4kn17mqzf0	558481216016@s.whatsapp.net	188751196254406@lid,558481216016@s.whatsapp.net,5584981216016@s.whatsapp.net	2026-01-20 13:50:15.807	2026-02-24 00:29:43.648	lid
cmkmnioud18z1qo4k1j9u17h1	555491939471@s.whatsapp.net	555491939471@s.whatsapp.net,5554991939471@s.whatsapp.net,67963596091533@lid	2026-01-20 13:50:15.755	2026-02-06 13:14:59.274	\N
cmkmnios418wzqo4k4ri3ok6n	555491646561@s.whatsapp.net	555491646561@s.whatsapp.net,5554991646561@s.whatsapp.net	2026-01-20 13:50:15.698	2026-02-07 00:38:09.644	\N
cmkmnioqq18w7qo4k0nif2swd	555591257217@s.whatsapp.net	555591257217@s.whatsapp.net,5555991257217@s.whatsapp.net	2026-01-20 13:50:15.668	2026-01-20 13:50:15.668	\N
cmkmnior818weqo4kltw6ksmy	554799317297@s.whatsapp.net	554799317297@s.whatsapp.net,5547999317297@s.whatsapp.net	2026-01-20 13:50:15.674	2026-01-20 13:50:15.674	\N
cmkmniorc18wiqo4ka50r8rhw	551130031616@s.whatsapp.net	551130031616@s.whatsapp.net,5511930031616@s.whatsapp.net	2026-01-20 13:50:15.676	2026-01-20 13:50:15.676	\N
cmkmniord18wkqo4kix9td9z6	555484090408@s.whatsapp.net	555484090408@s.whatsapp.net,5554984090408@s.whatsapp.net	2026-01-20 13:50:15.683	2026-01-20 13:50:15.683	\N
cmkmniorl18wqqo4kdpvfz8tl	555491703883@s.whatsapp.net	555491703883@s.whatsapp.net,5554991703883@s.whatsapp.net	2026-01-20 13:50:15.689	2026-01-20 13:50:15.689	\N
cmkmnios118wyqo4kjuly0tby	555491827672@s.whatsapp.net	555491827672@s.whatsapp.net,5554991827672@s.whatsapp.net	2026-01-20 13:50:15.697	2026-01-20 13:50:15.697	\N
cmkmniosm18xcqo4kyz376yhe	555193624684@s.whatsapp.net	555193624684@s.whatsapp.net,5551993624684@s.whatsapp.net	2026-01-20 13:50:15.705	2026-01-20 13:50:15.705	\N
cmkmniosw18xhqo4k7nd7h4we	555491443508@s.whatsapp.net	555491443508@s.whatsapp.net,5554991443508@s.whatsapp.net	2026-01-20 13:50:15.708	2026-01-20 13:50:15.708	\N
cmkmniosz18xmqo4keyxo0mox	555499870182@s.whatsapp.net	555499870182@s.whatsapp.net,5554999870182@s.whatsapp.net	2026-01-20 13:50:15.711	2026-01-20 13:50:15.711	\N
cmkmniot618xsqo4k7jc2go1t	555491910248@s.whatsapp.net	555491910248@s.whatsapp.net,5554991910248@s.whatsapp.net	2026-01-20 13:50:15.716	2026-01-20 13:50:15.716	\N
cmkmniote18xxqo4kq5etnfw4	555197582833@s.whatsapp.net	555197582833@s.whatsapp.net,5551997582833@s.whatsapp.net	2026-01-20 13:50:15.718	2026-01-20 13:50:15.718	\N
cmkmniotm18y2qo4kia7flvm9	555499893249@s.whatsapp.net	555499893249@s.whatsapp.net,5554999893249@s.whatsapp.net	2026-01-20 13:50:15.72	2026-01-20 13:50:15.72	\N
cmkmniotw18ydqo4kthmc6pa1	555499291616@s.whatsapp.net	555499291616@s.whatsapp.net,5554999291616@s.whatsapp.net	2026-01-20 13:50:15.73	2026-01-20 13:50:15.73	\N
cmkmnioty18yiqo4kul9mfnbd	555591806761@s.whatsapp.net	555591806761@s.whatsapp.net,5555991806761@s.whatsapp.net	2026-01-20 13:50:15.734	2026-01-20 13:50:15.734	\N
cmkmniou418yqqo4ka4udmsid	555491784324@s.whatsapp.net	555491784324@s.whatsapp.net,5554991784324@s.whatsapp.net	2026-01-20 13:50:15.74	2026-01-20 13:50:15.74	\N
cmkmniou718yvqo4kfgklwmt8	555597210919@s.whatsapp.net	555597210919@s.whatsapp.net,5555997210919@s.whatsapp.net	2026-01-20 13:50:15.742	2026-01-20 13:50:15.742	\N
cmkmnioud18yzqo4kwjnl62bx	5521972957272@s.whatsapp.net	552172957272@s.whatsapp.net,5521972957272@s.whatsapp.net	2026-01-20 13:50:15.75	2026-01-20 13:50:15.75	\N
cmkmniouh18z3qo4k067gkbuo	5511993002981@s.whatsapp.net	551193002981@s.whatsapp.net,5511993002981@s.whatsapp.net	2026-01-20 13:50:15.755	2026-01-20 13:50:15.755	\N
cmkmniouj18z8qo4khkjsixjh	555491131825@s.whatsapp.net	555491131825@s.whatsapp.net,5554991131825@s.whatsapp.net	2026-01-20 13:50:15.762	2026-01-20 13:50:15.762	\N
cmkmnioun18zhqo4kaee0wprs	555496053453@s.whatsapp.net	555496053453@s.whatsapp.net,5554996053453@s.whatsapp.net	2026-01-20 13:50:15.769	2026-01-20 13:50:15.769	\N
cmkmniour18ziqo4k2qd0cwzp	555491332835@s.whatsapp.net	555491332835@s.whatsapp.net,5554991332835@s.whatsapp.net	2026-01-20 13:50:15.77	2026-01-20 13:50:15.77	\N
cmkmniouu18znqo4kk1gkimkr	555499853373@s.whatsapp.net	555499853373@s.whatsapp.net,5554999853373@s.whatsapp.net	2026-01-20 13:50:15.773	2026-01-20 13:50:15.773	\N
cmkmniov018zpqo4kw7j7wjrj	555584028733@s.whatsapp.net	555584028733@s.whatsapp.net,5555984028733@s.whatsapp.net	2026-01-20 13:50:15.773	2026-01-20 13:50:15.773	\N
cmkmniov518zwqo4k1frs4huu	555591851624@s.whatsapp.net	555591851624@s.whatsapp.net,5555991851624@s.whatsapp.net	2026-01-20 13:50:15.777	2026-01-20 13:50:15.777	\N
cmkmniov618zzqo4kw4yrcwgn	555492666685@s.whatsapp.net	555492666685@s.whatsapp.net,5554992666685@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniovc1909qo4k3649uult	351931199351@s.whatsapp.net	351931199351@s.whatsapp.net@s.whatsapp.net	2026-01-20 13:50:15.788	2026-01-20 13:50:15.788	\N
cmkmniovn190eqo4kri3opnei	555484122144@s.whatsapp.net	555484122144@s.whatsapp.net,5554984122144@s.whatsapp.net	2026-01-20 13:50:15.791	2026-01-20 13:50:15.791	\N
cmkmniovt190kqo4kywjp7pzn	555597137614@s.whatsapp.net	555597137614@s.whatsapp.net,5555997137614@s.whatsapp.net	2026-01-20 13:50:15.797	2026-01-20 13:50:15.797	\N
cmkmniovw190mqo4kcnjpgk0p	555496476030@s.whatsapp.net	555496476030@s.whatsapp.net,5554996476030@s.whatsapp.net	2026-01-20 13:50:15.808	2026-01-20 13:50:15.808	\N
cmkmniow1190rqo4k4hi9zeqh	555599661417@s.whatsapp.net	555599661417@s.whatsapp.net,5555999661417@s.whatsapp.net	2026-01-20 13:50:15.808	2026-01-20 13:50:15.808	\N
cmkmniow5190xqo4k1gbl7flj	554791016754@s.whatsapp.net	554791016754@s.whatsapp.net,5547991016754@s.whatsapp.net	2026-01-20 13:50:15.814	2026-01-20 13:50:15.814	\N
cmkmniow91912qo4k89n6t1ws	555584141003@s.whatsapp.net	555584141003@s.whatsapp.net,5555984141003@s.whatsapp.net	2026-01-20 13:50:15.817	2026-01-20 13:50:15.817	\N
cmkmniowg191cqo4kudccaurw	555599972002@s.whatsapp.net	555599972002@s.whatsapp.net,5555999972002@s.whatsapp.net	2026-01-20 13:50:15.828	2026-01-20 13:50:15.828	\N
cmkmniowj191gqo4kk1qqovk8	555491724854@s.whatsapp.net	555491724854@s.whatsapp.net,5554991724854@s.whatsapp.net	2026-01-20 13:50:15.836	2026-01-20 13:50:15.836	\N
cmkmniowm191kqo4ku0zafkf7	555596836079@s.whatsapp.net	555596836079@s.whatsapp.net,5555996836079@s.whatsapp.net	2026-01-20 13:50:15.839	2026-01-20 13:50:15.839	\N
cmkmnioww191pqo4k5rmhbt8g	5511978336864@s.whatsapp.net	551178336864@s.whatsapp.net,5511978336864@s.whatsapp.net	2026-01-20 13:50:15.844	2026-01-20 13:50:15.844	\N
cmkmniox1191yqo4kaiilnkx1	555491024934@s.whatsapp.net	555491024934@s.whatsapp.net,5554991024934@s.whatsapp.net	2026-01-20 13:50:15.846	2026-01-20 13:50:15.846	\N
cmkmniox41923qo4kjn1zsxk6	555496177807@s.whatsapp.net	555496177807@s.whatsapp.net,5554996177807@s.whatsapp.net	2026-01-20 13:50:15.853	2026-01-20 13:50:15.853	\N
cmkmniox61928qo4kxd1t0l5j	555491291841@s.whatsapp.net	555491291841@s.whatsapp.net,5554991291841@s.whatsapp.net	2026-01-20 13:50:15.856	2026-01-20 13:50:15.856	\N
cmkmnioxa192cqo4kupmczcvu	555491357932@s.whatsapp.net	555491357932@s.whatsapp.net,5554991357932@s.whatsapp.net	2026-01-20 13:50:15.859	2026-01-20 13:50:15.859	\N
cmkmnioxc192fqo4kg9e0b8q9	555492824496@s.whatsapp.net	555492824496@s.whatsapp.net,5554992824496@s.whatsapp.net	2026-01-20 13:50:15.864	2026-01-20 13:50:15.864	\N
cmkmnioxe192kqo4khgty2i36	555599949198@s.whatsapp.net	555599949198@s.whatsapp.net,5555999949198@s.whatsapp.net	2026-01-20 13:50:15.874	2026-01-20 13:50:15.874	\N
cmkmnioxi192pqo4keefpkdrw	555497107852@s.whatsapp.net	555497107852@s.whatsapp.net,5554997107852@s.whatsapp.net	2026-01-20 13:50:15.882	2026-01-20 13:50:15.882	\N
cmkmnioxk192vqo4k0xnxbt8p	555599692296@s.whatsapp.net	555599692296@s.whatsapp.net,5555999692296@s.whatsapp.net	2026-01-20 13:50:15.891	2026-01-20 13:50:15.891	\N
cmkmnioxw1934qo4kkyr6ed8q	555599562606@s.whatsapp.net	555599562606@s.whatsapp.net,5555999562606@s.whatsapp.net	2026-01-20 13:50:15.896	2026-01-20 13:50:15.896	\N
cmkmniosi18x7qo4kn25qxi1j	555191524244@s.whatsapp.net	555191524244@s.whatsapp.net,5551991524244@s.whatsapp.net,7310168580344@lid	2026-01-20 13:50:15.702	2026-02-24 10:34:39.925	lid
cmkmniotq18y8qo4kjnd5867k	555491867126@s.whatsapp.net	260846433357913@lid,555491867126@s.whatsapp.net,5554991867126@s.whatsapp.net	2026-01-20 13:50:15.726	2026-01-29 16:23:35.98	\N
cmkmnioul18zdqo4ksng2kcld	555591045412@s.whatsapp.net	555591045412@s.whatsapp.net,5555991045412@s.whatsapp.net	2026-01-20 13:50:15.766	2026-02-23 14:16:14.873	\N
cmkmniou118ylqo4ky2k7wupq	555599816417@s.whatsapp.net	555599816417@s.whatsapp.net,5555999816417@s.whatsapp.net	2026-01-20 13:50:15.735	2026-02-07 00:38:09.725	\N
cmkmnior618wcqo4kxs0tfr5a	555181055570@s.whatsapp.net	555181055570@s.whatsapp.net,5551981055570@s.whatsapp.net	2026-01-20 13:50:15.672	2026-01-20 13:50:15.672	\N
cmkmniore18wmqo4kxowe0j80	554984176785@s.whatsapp.net	554984176785@s.whatsapp.net,5549984176785@s.whatsapp.net	2026-01-20 13:50:15.684	2026-01-20 13:50:15.684	\N
cmkmniorn18wrqo4knt2op1qz	555191238182@s.whatsapp.net	555191238182@s.whatsapp.net,5551991238182@s.whatsapp.net	2026-01-20 13:50:15.69	2026-01-20 13:50:15.69	\N
cmkmnios018wwqo4kch89av2o	555491781007@s.whatsapp.net	555491781007@s.whatsapp.net,5554991781007@s.whatsapp.net	2026-01-20 13:50:15.696	2026-01-20 13:50:15.696	\N
cmkmnios918x2qo4k6hjevwbz	555491552720@s.whatsapp.net	555491552720@s.whatsapp.net,5554991552720@s.whatsapp.net	2026-01-20 13:50:15.699	2026-01-20 13:50:15.699	\N
cmkmniosi18x6qo4k17bp1pis	5521964426515@s.whatsapp.net	552164426515@s.whatsapp.net,5521964426515@s.whatsapp.net	2026-01-20 13:50:15.702	2026-01-20 13:50:15.702	\N
cmkmniosk18x9qo4k7wojboc0	555533244646@s.whatsapp.net	555533244646@s.whatsapp.net,5555933244646@s.whatsapp.net	2026-01-20 13:50:15.704	2026-01-20 13:50:15.704	\N
cmkmnioss18xeqo4kl0vhij0c	555491321137@s.whatsapp.net	555491321137@s.whatsapp.net,5554991321137@s.whatsapp.net	2026-01-20 13:50:15.707	2026-01-20 13:50:15.707	\N
cmkmniosy18xkqo4kw5xz25j5	555499749930@s.whatsapp.net	555499749930@s.whatsapp.net,5554999749930@s.whatsapp.net	2026-01-20 13:50:15.71	2026-01-20 13:50:15.71	\N
cmkmniot018xoqo4kytuyqhvm	554391356837@s.whatsapp.net	554391356837@s.whatsapp.net,5543991356837@s.whatsapp.net	2026-01-20 13:50:15.712	2026-01-20 13:50:15.712	\N
cmkmniot318xrqo4kqrtdyj2j	555499896822@s.whatsapp.net	555499896822@s.whatsapp.net,5554999896822@s.whatsapp.net	2026-01-20 13:50:15.716	2026-01-20 13:50:15.716	\N
cmkmniotc18xvqo4kpwemnta3	5516981426912@s.whatsapp.net	551681426912@s.whatsapp.net,5516981426912@s.whatsapp.net	2026-01-20 13:50:15.717	2026-01-20 13:50:15.717	\N
cmkmniotj18y0qo4kzmij07gb	5516982176015@s.whatsapp.net	551682176015@s.whatsapp.net,5516982176015@s.whatsapp.net	2026-01-20 13:50:15.719	2026-01-20 13:50:15.719	\N
cmkmniotm18y4qo4kurb9z3za	554191669955@s.whatsapp.net	554191669955@s.whatsapp.net,5541991669955@s.whatsapp.net	2026-01-20 13:50:15.721	2026-01-20 13:50:15.721	\N
cmkmniotq18y7qo4kfxtd36qg	555599578207@s.whatsapp.net	555599578207@s.whatsapp.net,5555999578207@s.whatsapp.net	2026-01-20 13:50:15.724	2026-01-20 13:50:15.724	\N
cmkmniotv18ycqo4kadc5ko9w	555493098107@s.whatsapp.net	555493098107@s.whatsapp.net,5554993098107@s.whatsapp.net	2026-01-20 13:50:15.728	2026-01-20 13:50:15.728	\N
cmkmnioty18yhqo4kml99fzkg	555484090566@s.whatsapp.net	555484090566@s.whatsapp.net,5554984090566@s.whatsapp.net	2026-01-20 13:50:15.734	2026-01-20 13:50:15.734	\N
cmkmniou218ymqo4kz1a2szow	555591020517@s.whatsapp.net	555591020517@s.whatsapp.net,5555991020517@s.whatsapp.net	2026-01-20 13:50:15.738	2026-01-20 13:50:15.738	\N
cmkmniou618ysqo4kawhztdam	555491774330@s.whatsapp.net	555491774330@s.whatsapp.net,5554991774330@s.whatsapp.net	2026-01-20 13:50:15.741	2026-01-20 13:50:15.741	\N
cmkmniouc18yyqo4kree3xk4z	555599963408@s.whatsapp.net	555599963408@s.whatsapp.net,5555999963408@s.whatsapp.net	2026-01-20 13:50:15.75	2026-01-20 13:50:15.75	\N
cmkmniouh18z4qo4kfu4aiamj	555599614388@s.whatsapp.net	555599614388@s.whatsapp.net,5555999614388@s.whatsapp.net	2026-01-20 13:50:15.756	2026-01-20 13:50:15.756	\N
cmkmniouk18zaqo4ksguvaeh7	555491121571@s.whatsapp.net	555491121571@s.whatsapp.net,5554991121571@s.whatsapp.net	2026-01-20 13:50:15.764	2026-01-20 13:50:15.764	\N
cmkmnioun18zfqo4kxhy7o0c8	5521965313203@s.whatsapp.net	552165313203@s.whatsapp.net,5521965313203@s.whatsapp.net	2026-01-20 13:50:15.768	2026-01-20 13:50:15.768	\N
cmkmnious18zjqo4k7vcszcgu	555192140533@s.whatsapp.net	555192140533@s.whatsapp.net,5551992140533@s.whatsapp.net	2026-01-20 13:50:15.77	2026-01-20 13:50:15.77	\N
cmkmnioux18zoqo4k74gyvwx0	5511934862735@s.whatsapp.net	551134862735@s.whatsapp.net,5511934862735@s.whatsapp.net	2026-01-20 13:50:15.773	2026-01-20 13:50:15.773	\N
cmkmniov118zqqo4kwjtyrjfi	5511933875590@s.whatsapp.net	551133875590@s.whatsapp.net,5511933875590@s.whatsapp.net	2026-01-20 13:50:15.773	2026-01-20 13:50:15.773	\N
cmkmniov518zuqo4kfas4c38g	555491310809@s.whatsapp.net	555491310809@s.whatsapp.net,5554991310809@s.whatsapp.net	2026-01-20 13:50:15.776	2026-01-20 13:50:15.776	\N
cmkmniov618zyqo4kr95fq77j	555491784428@s.whatsapp.net	555491784428@s.whatsapp.net,5554991784428@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniov81903qo4kg7gpf3ym	555584122195@s.whatsapp.net	555584122195@s.whatsapp.net,5555984122195@s.whatsapp.net	2026-01-20 13:50:15.784	2026-01-20 13:50:15.784	\N
cmkmniovc1906qo4kggzpu9y1	555491127044@s.whatsapp.net	555491127044@s.whatsapp.net,5554991127044@s.whatsapp.net	2026-01-20 13:50:15.785	2026-01-20 13:50:15.785	\N
cmkmniovn190dqo4kpnmmsi54	555599692548@s.whatsapp.net	555599692548@s.whatsapp.net,5555999692548@s.whatsapp.net	2026-01-20 13:50:15.791	2026-01-20 13:50:15.791	\N
cmkmniovq190iqo4kffp6yoj2	555591154738@s.whatsapp.net	555591154738@s.whatsapp.net,5555991154738@s.whatsapp.net	2026-01-20 13:50:15.793	2026-01-20 13:50:15.793	\N
cmkmniovw190nqo4k5e79qoyi	555491828786@s.whatsapp.net	555491828786@s.whatsapp.net,5554991828786@s.whatsapp.net	2026-01-20 13:50:15.808	2026-01-20 13:50:15.808	\N
cmkmniow3190tqo4kol5okw3e	555499980210@s.whatsapp.net	555499980210@s.whatsapp.net,5554999980210@s.whatsapp.net	2026-01-20 13:50:15.808	2026-01-20 13:50:15.808	\N
cmkmniow6190yqo4kponz6t5m	555591548572@s.whatsapp.net	555591548572@s.whatsapp.net,5555991548572@s.whatsapp.net	2026-01-20 13:50:15.814	2026-01-20 13:50:15.814	\N
cmkmniowa1913qo4kucwgkg2m	555491277924@s.whatsapp.net	555491277924@s.whatsapp.net,5554991277924@s.whatsapp.net	2026-01-20 13:50:15.818	2026-01-20 13:50:15.818	\N
cmkmniowe1919qo4kzdhy5lnl	555491562025@s.whatsapp.net	555491562025@s.whatsapp.net,5554991562025@s.whatsapp.net	2026-01-20 13:50:15.825	2026-01-20 13:50:15.825	\N
cmkmniowh191eqo4koyvco8nn	555491459728@s.whatsapp.net	555491459728@s.whatsapp.net,5554991459728@s.whatsapp.net	2026-01-20 13:50:15.83	2026-01-20 13:50:15.83	\N
cmkmniowl191iqo4k0daexy99	555491994593@s.whatsapp.net	555491994593@s.whatsapp.net,5554991994593@s.whatsapp.net	2026-01-20 13:50:15.839	2026-01-20 13:50:15.839	\N
cmkmniowp191oqo4kwmesymvw	555491547700@s.whatsapp.net	555491547700@s.whatsapp.net,5554991547700@s.whatsapp.net	2026-01-20 13:50:15.843	2026-01-20 13:50:15.843	\N
cmkmniox0191vqo4ke2scybke	555491540380@s.whatsapp.net	555491540380@s.whatsapp.net,5554991540380@s.whatsapp.net	2026-01-20 13:50:15.845	2026-01-20 13:50:15.845	\N
cmkmniox21920qo4k9ezblaet	555499278758@s.whatsapp.net	555499278758@s.whatsapp.net,5554999278758@s.whatsapp.net	2026-01-20 13:50:15.846	2026-01-20 13:50:15.846	\N
cmkmniox41924qo4kleba3vz1	555592083508@s.whatsapp.net	555592083508@s.whatsapp.net,5555992083508@s.whatsapp.net	2026-01-20 13:50:15.853	2026-01-20 13:50:15.853	\N
cmkmniox81929qo4k0gyj0fe5	555492654938@s.whatsapp.net	555492654938@s.whatsapp.net,5554992654938@s.whatsapp.net	2026-01-20 13:50:15.857	2026-01-20 13:50:15.857	\N
cmkmnioxd192jqo4kvoycqfx0	555591416858@s.whatsapp.net	555591416858@s.whatsapp.net,5555991416858@s.whatsapp.net	2026-01-20 13:50:15.869	2026-01-20 13:50:15.869	\N
cmkmnioxi192oqo4k7nz8vzbn	555491660864@s.whatsapp.net	555491660864@s.whatsapp.net,5554991660864@s.whatsapp.net	2026-01-20 13:50:15.881	2026-01-20 13:50:15.881	\N
cmkmnioxl192yqo4keeevfln3	555491679618@s.whatsapp.net	555491679618@s.whatsapp.net,5554991679618@s.whatsapp.net	2026-01-20 13:50:15.894	2026-01-20 13:50:15.894	\N
cmkmnioxr1933qo4kegol86jp	555491785303@s.whatsapp.net	555491785303@s.whatsapp.net,5554991785303@s.whatsapp.net	2026-01-20 13:50:15.896	2026-01-20 13:50:15.896	\N
cmkmnioxz1936qo4k1pqmjou7	555499648368@s.whatsapp.net	555499648368@s.whatsapp.net,5554999648368@s.whatsapp.net	2026-01-20 13:50:15.897	2026-01-20 13:50:15.897	\N
cmkmnioxj192tqo4kbsfzlh44	555496127243@s.whatsapp.net	159133051416687@lid,555496127243@s.whatsapp.net,5554996127243@s.whatsapp.net	2026-01-20 13:50:15.887	2026-02-20 11:10:47.026	\N
cmkmnioxb192eqo4km11mnm2u	555592356434@s.whatsapp.net	555592356434@s.whatsapp.net,5555992356434@s.whatsapp.net	2026-01-20 13:50:15.863	2026-02-23 14:16:14.887	\N
cmkmniowh191dqo4kkx3pq1dc	555591764452@s.whatsapp.net	555591764452@s.whatsapp.net,5555991764452@s.whatsapp.net	2026-01-20 13:50:15.829	2026-01-20 13:50:15.829	\N
cmkmniowl191jqo4kqioz5771	555591137821@s.whatsapp.net	555591137821@s.whatsapp.net,5555991137821@s.whatsapp.net	2026-01-20 13:50:15.839	2026-01-20 13:50:15.839	\N
cmkmniowp191nqo4k2n34dkz9	554899613768@s.whatsapp.net	554899613768@s.whatsapp.net,5548999613768@s.whatsapp.net	2026-01-20 13:50:15.84	2026-01-20 13:50:15.84	\N
cmkmniowy191tqo4k4kjx1qvd	555491136559@s.whatsapp.net	555491136559@s.whatsapp.net,5554991136559@s.whatsapp.net	2026-01-20 13:50:15.845	2026-01-20 13:50:15.845	\N
cmkmniox2191zqo4kaywg2j6i	15617881579@s.whatsapp.net	15617881579@s.whatsapp.net@s.whatsapp.net	2026-01-20 13:50:15.846	2026-01-20 13:50:15.846	\N
cmkmniox51927qo4kaewj22gs	555499178785@s.whatsapp.net	555499178785@s.whatsapp.net,5554999178785@s.whatsapp.net	2026-01-20 13:50:15.854	2026-01-20 13:50:15.854	\N
cmkmnioxa192dqo4ku592xarw	555592062596@s.whatsapp.net	555592062596@s.whatsapp.net,5555992062596@s.whatsapp.net	2026-01-20 13:50:15.862	2026-01-20 13:50:15.862	\N
cmkmnioxd192hqo4k5la4m3q0	555599953306@s.whatsapp.net	555599953306@s.whatsapp.net,5555999953306@s.whatsapp.net	2026-01-20 13:50:15.867	2026-01-20 13:50:15.867	\N
cmkmnioxg192nqo4k21xx2yef	555591537114@s.whatsapp.net	555591537114@s.whatsapp.net,5555991537114@s.whatsapp.net	2026-01-20 13:50:15.876	2026-01-20 13:50:15.876	\N
cmkmnioxi192sqo4kbu5lnpqn	555533226238@s.whatsapp.net	555533226238@s.whatsapp.net,5555933226238@s.whatsapp.net	2026-01-20 13:50:15.885	2026-01-20 13:50:15.885	\N
cmkmnioxl192wqo4kz5kfj619	555491137804@s.whatsapp.net	555491137804@s.whatsapp.net,5554991137804@s.whatsapp.net	2026-01-20 13:50:15.893	2026-01-20 13:50:15.893	\N
cmkmnioxr1931qo4kbn6ancz1	555491689846@s.whatsapp.net	555491689846@s.whatsapp.net,5554991689846@s.whatsapp.net	2026-01-20 13:50:15.894	2026-01-20 13:50:15.894	\N
cmkmnioxz1937qo4kh7ioswla	555491237271@s.whatsapp.net	555491237271@s.whatsapp.net,5554991237271@s.whatsapp.net	2026-01-20 13:50:15.897	2026-01-20 13:50:15.897	\N
cmkmnioy1193bqo4kfmrr3kgi	555491220516@s.whatsapp.net	555491220516@s.whatsapp.net,5554991220516@s.whatsapp.net	2026-01-20 13:50:15.899	2026-01-20 13:50:15.899	\N
cmkmnioy9193fqo4krol79wuv	555596875990@s.whatsapp.net	555596875990@s.whatsapp.net,5555996875990@s.whatsapp.net	2026-01-20 13:50:15.903	2026-01-20 13:50:15.903	\N
cmkmnioyd193lqo4ksht1nqbz	555591746158@s.whatsapp.net	555591746158@s.whatsapp.net,5555991746158@s.whatsapp.net	2026-01-20 13:50:15.921	2026-01-20 13:50:15.921	\N
cmkmnioyh193oqo4k7f33g5a0	555591424402@s.whatsapp.net	555591424402@s.whatsapp.net,5555991424402@s.whatsapp.net	2026-01-20 13:50:15.923	2026-01-20 13:50:15.923	\N
cmkmnioyq193vqo4k33u1ogk3	555492225768@s.whatsapp.net	555492225768@s.whatsapp.net,5554992225768@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyt193zqo4kqjitoyw4	555491904340@s.whatsapp.net	555491904340@s.whatsapp.net,5554991904340@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioz31945qo4kzyz54gnn	555491136690@s.whatsapp.net	555491136690@s.whatsapp.net,5554991136690@s.whatsapp.net	2026-01-20 13:50:15.928	2026-01-20 13:50:15.928	\N
cmkmnioz91949qo4ksfcq8pzf	555591567294@s.whatsapp.net	555591567294@s.whatsapp.net,5555991567294@s.whatsapp.net	2026-01-20 13:50:15.932	2026-01-20 13:50:15.932	\N
cmkmniozf194dqo4kmq9jf9a3	555491731368@s.whatsapp.net	555491731368@s.whatsapp.net,5554991731368@s.whatsapp.net	2026-01-20 13:50:15.932	2026-01-20 13:50:15.932	\N
cmkmniozj194fqo4krc4i5ugf	555492255341@s.whatsapp.net	555492255341@s.whatsapp.net,5554992255341@s.whatsapp.net	2026-01-20 13:50:15.935	2026-01-20 13:50:15.935	\N
cmkmniozz196mqo4kq2totji4	555491737363@s.whatsapp.net	555491737363@s.whatsapp.net,5554991737363@s.whatsapp.net	2026-01-20 13:50:15.941	2026-01-20 13:50:15.941	\N
cmkmnip0i19iqqo4kh8atff7c	555499009808@s.whatsapp.net	555499009808@s.whatsapp.net,5554999009808@s.whatsapp.net	2026-01-20 13:50:15.947	2026-01-20 13:50:15.947	\N
cmkmnip0s19ivqo4kd1tcytqa	555499759995@s.whatsapp.net	555499759995@s.whatsapp.net,5554999759995@s.whatsapp.net	2026-01-20 13:50:15.95	2026-01-20 13:50:15.95	\N
cmkmnip1219j1qo4k0nxfrn33	555491471644@s.whatsapp.net	555491471644@s.whatsapp.net,5554991471644@s.whatsapp.net	2026-01-20 13:50:15.952	2026-01-20 13:50:15.952	\N
cmkmnip1619j5qo4ko86d00ng	555181901838@s.whatsapp.net	555181901838@s.whatsapp.net,5551981901838@s.whatsapp.net	2026-01-20 13:50:15.955	2026-01-20 13:50:15.955	\N
cmkmnip1f19jcqo4khk9ok0iq	555496795327@s.whatsapp.net	555496795327@s.whatsapp.net,5554996795327@s.whatsapp.net	2026-01-20 13:50:15.958	2026-01-20 13:50:15.958	\N
cmkmnip1m19jgqo4kjgg5b4uj	5511977083035@s.whatsapp.net	551177083035@s.whatsapp.net,5511977083035@s.whatsapp.net	2026-01-20 13:50:15.96	2026-01-20 13:50:15.96	\N
cmkmnip1r19jkqo4k4izcv9rj	555491540227@s.whatsapp.net	555491540227@s.whatsapp.net,5554991540227@s.whatsapp.net	2026-01-20 13:50:15.968	2026-01-20 13:50:15.968	\N
cmkmnip1w19joqo4k90lmjt23	555591631004@s.whatsapp.net	555591631004@s.whatsapp.net,5555991631004@s.whatsapp.net	2026-01-20 13:50:15.969	2026-01-20 13:50:15.969	\N
cmkmnip1z19jsqo4k7oezsviy	555599494145@s.whatsapp.net	555599494145@s.whatsapp.net,5555999494145@s.whatsapp.net	2026-01-20 13:50:15.972	2026-01-20 13:50:15.972	\N
cmkmnip1c19j8qo4ke2pyjafq	555491117614@s.whatsapp.net	33917407084679@lid,555491117614@s.whatsapp.net,5554991117614@s.whatsapp.net	2026-01-20 13:50:15.957	2026-02-21 00:21:29.041	\N
cmkmnip0919ctqo4ki28caxbl	555491438493@s.whatsapp.net	555491438493@s.whatsapp.net,5554991438493@s.whatsapp.net,56053634957439@lid	2026-01-20 13:50:15.944	2026-02-07 00:38:09.643	\N
cmkmniozr194kqo4k4zbvsbr0	555581267986@s.whatsapp.net	201734664241232@lid,555581267986@s.whatsapp.net,5555981267986@s.whatsapp.net	2026-01-20 13:50:15.94	2026-02-21 00:21:28.953	\N
cmkmnioxi192rqo4kbt0cqocx	555181618339@s.whatsapp.net	555181618339@s.whatsapp.net,5551981618339@s.whatsapp.net	2026-01-20 13:50:15.884	2026-01-20 13:50:15.884	\N
cmkmnioxk192uqo4k8ys9uuja	555592178698@s.whatsapp.net	555592178698@s.whatsapp.net,5555992178698@s.whatsapp.net	2026-01-20 13:50:15.888	2026-01-20 13:50:15.888	\N
cmkmnioxo192zqo4kur8oi30w	555491080604@s.whatsapp.net	555491080604@s.whatsapp.net,5554991080604@s.whatsapp.net	2026-01-20 13:50:15.894	2026-01-20 13:50:15.894	\N
cmkmnioxw1935qo4k35zq2nax	555496360108@s.whatsapp.net	555496360108@s.whatsapp.net,5554996360108@s.whatsapp.net	2026-01-20 13:50:15.897	2026-01-20 13:50:15.897	\N
cmkmnioy01939qo4kv6mbc9hz	555591521253@s.whatsapp.net	555591521253@s.whatsapp.net,5555991521253@s.whatsapp.net	2026-01-20 13:50:15.899	2026-01-20 13:50:15.899	\N
cmkmnioy8193dqo4k2ycp5y63	555599203329@s.whatsapp.net	555599203329@s.whatsapp.net,5555999203329@s.whatsapp.net	2026-01-20 13:50:15.9	2026-01-20 13:50:15.9	\N
cmkmnioyf193nqo4kccp4dxu9	555491908980@s.whatsapp.net	555491908980@s.whatsapp.net,5554991908980@s.whatsapp.net	2026-01-20 13:50:15.905	2026-01-20 13:50:15.905	\N
cmkmnioyq193uqo4ktzcbidux	555491950240@s.whatsapp.net	555491950240@s.whatsapp.net,5554991950240@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioys193yqo4kdzilag00	555431991290@s.whatsapp.net	555431991290@s.whatsapp.net,5554931991290@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyw1942qo4k73bl3uyq	555491357550@s.whatsapp.net	555491357550@s.whatsapp.net,5554991357550@s.whatsapp.net	2026-01-20 13:50:15.926	2026-01-20 13:50:15.926	\N
cmkmnioz61948qo4k4tdwjhet	555599136540@s.whatsapp.net	555599136540@s.whatsapp.net,5555999136540@s.whatsapp.net	2026-01-20 13:50:15.932	2026-01-20 13:50:15.932	\N
cmkmniozm194hqo4k18xy9vv3	554799766476@s.whatsapp.net	554799766476@s.whatsapp.net,5547999766476@s.whatsapp.net	2026-01-20 13:50:15.938	2026-01-20 13:50:15.938	\N
cmkmniozw196hqo4k2p0ko2tz	558007248730@s.whatsapp.net	558007248730@s.whatsapp.net,5580907248730@s.whatsapp.net	2026-01-20 13:50:15.94	2026-01-20 13:50:15.94	\N
cmkmnip0p19itqo4kny5l95re	555491821688@s.whatsapp.net	555491821688@s.whatsapp.net,5554991821688@s.whatsapp.net	2026-01-20 13:50:15.949	2026-01-20 13:50:15.949	\N
cmkmnip0u19ixqo4kq6pdgu5u	555596524822@s.whatsapp.net	555596524822@s.whatsapp.net,5555996524822@s.whatsapp.net	2026-01-20 13:50:15.95	2026-01-20 13:50:15.95	\N
cmkmnip1219izqo4kwner6xcm	555591387614@s.whatsapp.net	555591387614@s.whatsapp.net,5555991387614@s.whatsapp.net	2026-01-20 13:50:15.952	2026-01-20 13:50:15.952	\N
cmkmnip1519j3qo4kjxb2wos0	555591150861@s.whatsapp.net	555591150861@s.whatsapp.net,5555991150861@s.whatsapp.net	2026-01-20 13:50:15.954	2026-01-20 13:50:15.954	\N
cmkmnip1819j7qo4kge2ov6dp	555591841008@s.whatsapp.net	555591841008@s.whatsapp.net,5555991841008@s.whatsapp.net	2026-01-20 13:50:15.956	2026-01-20 13:50:15.956	\N
cmkmnip1f19jbqo4kcx79jjoa	5511981222637@s.whatsapp.net	551181222637@s.whatsapp.net,5511981222637@s.whatsapp.net	2026-01-20 13:50:15.958	2026-01-20 13:50:15.958	\N
cmkmnip1k19jfqo4kqnr9il0x	555592223596@s.whatsapp.net	555592223596@s.whatsapp.net,5555992223596@s.whatsapp.net	2026-01-20 13:50:15.96	2026-01-20 13:50:15.96	\N
cmkmnip1m19jhqo4k3qnrrks2	555592283636@s.whatsapp.net	555592283636@s.whatsapp.net,5555992283636@s.whatsapp.net	2026-01-20 13:50:15.96	2026-01-20 13:50:15.96	\N
cmkmnip1y19jrqo4kmj68frlj	555492044552@s.whatsapp.net	555492044552@s.whatsapp.net,5554992044552@s.whatsapp.net	2026-01-20 13:50:15.972	2026-01-20 13:50:15.972	\N
cmkmniozd194bqo4kppx5jz9u	555599224306@s.whatsapp.net	231631898067119@lid,555599224306@s.whatsapp.net,5555999224306@s.whatsapp.net	2026-01-20 13:50:15.932	2026-02-21 00:21:29.147	\N
cmkmnioya193iqo4k24kgl1ac	555533219000@s.whatsapp.net	555533219000@s.whatsapp.net,5555933219000@s.whatsapp.net	2026-01-20 13:50:15.904	2026-02-21 00:21:29.218	\N
cmkmnip1t19jmqo4kdv47fmo7	555199687494@s.whatsapp.net	28845117829336@lid,555199687494@s.whatsapp.net,5551999687494@s.whatsapp.net	2026-01-20 13:50:15.968	2026-02-06 22:53:01.742	\N
cmkmnip0a19cvqo4ktb7tez19	555431992238@s.whatsapp.net	17970327724215@lid,555431992238@s.whatsapp.net,5554931992238@s.whatsapp.net	2026-01-20 13:50:15.946	2026-02-25 00:42:35.404	\N
cmkmnioyh193qqo4ki9dfli13	555591557279@s.whatsapp.net	23914528960593@lid,555591557279@s.whatsapp.net,5555991557279@s.whatsapp.net	2026-01-20 13:50:15.924	2026-02-09 15:58:23.215	\N
cmkmnioxz1938qo4ke2jgomqe	556799958959@s.whatsapp.net	556799958959@s.whatsapp.net,5567999958959@s.whatsapp.net	2026-01-20 13:50:15.897	2026-01-20 13:50:15.897	\N
cmkmnioy8193eqo4kjirno2ny	555491656378@s.whatsapp.net	555491656378@s.whatsapp.net,5554991656378@s.whatsapp.net	2026-01-20 13:50:15.901	2026-01-20 13:50:15.901	\N
cmkmnioya193jqo4k7r2vmx3u	555599567502@s.whatsapp.net	555599567502@s.whatsapp.net,5555999567502@s.whatsapp.net	2026-01-20 13:50:15.904	2026-01-20 13:50:15.904	\N
cmkmnioyh193pqo4k7wss5154	555491480559@s.whatsapp.net	555491480559@s.whatsapp.net,5554991480559@s.whatsapp.net	2026-01-20 13:50:15.923	2026-01-20 13:50:15.923	\N
cmkmnioyr193wqo4kdjfbknyj	555433249166@s.whatsapp.net	555433249166@s.whatsapp.net,5554933249166@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyw1941qo4kukqf1nrp	555596296297@s.whatsapp.net	555596296297@s.whatsapp.net,5555996296297@s.whatsapp.net	2026-01-20 13:50:15.925	2026-01-20 13:50:15.925	\N
cmkmnioz51947qo4kaw03fnty	555596474358@s.whatsapp.net	555596474358@s.whatsapp.net,5555996474358@s.whatsapp.net	2026-01-20 13:50:15.931	2026-01-20 13:50:15.931	\N
cmkmnioze194cqo4k9ji8yg9h	555484222740@s.whatsapp.net	555484222740@s.whatsapp.net,5554984222740@s.whatsapp.net	2026-01-20 13:50:15.932	2026-01-20 13:50:15.932	\N
cmkmniozm194gqo4kydqfwar9	555599492559@s.whatsapp.net	555599492559@s.whatsapp.net,5555999492559@s.whatsapp.net	2026-01-20 13:50:15.937	2026-01-20 13:50:15.937	\N
cmkmniozw196gqo4k9hsrtn6f	5511942363530@s.whatsapp.net	551142363530@s.whatsapp.net,5511942363530@s.whatsapp.net	2026-01-20 13:50:15.94	2026-01-20 13:50:15.94	\N
cmkmnip021979qo4ke9hh6s5w	555599848933@s.whatsapp.net	555599848933@s.whatsapp.net,5555999848933@s.whatsapp.net	2026-01-20 13:50:15.943	2026-01-20 13:50:15.943	\N
cmkmnip0a19cwqo4k59wvis1y	555491215472@s.whatsapp.net	555491215472@s.whatsapp.net,5554991215472@s.whatsapp.net	2026-01-20 13:50:15.946	2026-01-20 13:50:15.946	\N
cmkmnip0t19iwqo4kh3wyguop	555492093770@s.whatsapp.net	555492093770@s.whatsapp.net,5554992093770@s.whatsapp.net	2026-01-20 13:50:15.95	2026-01-20 13:50:15.95	\N
cmkmnip1219j0qo4kpsarkmzz	555491693515@s.whatsapp.net	555491693515@s.whatsapp.net,5554991693515@s.whatsapp.net	2026-01-20 13:50:15.952	2026-01-20 13:50:15.952	\N
cmkmnip1619j4qo4koptvmfcf	555491436242@s.whatsapp.net	555491436242@s.whatsapp.net,5554991436242@s.whatsapp.net	2026-01-20 13:50:15.954	2026-01-20 13:50:15.954	\N
cmkmnip1d19j9qo4kcgzpj9lh	555599777554@s.whatsapp.net	555599777554@s.whatsapp.net,5555999777554@s.whatsapp.net	2026-01-20 13:50:15.957	2026-01-20 13:50:15.957	\N
cmkmnip1h19jeqo4kdz2hh8mt	555499309874@s.whatsapp.net	555499309874@s.whatsapp.net,5554999309874@s.whatsapp.net	2026-01-20 13:50:15.959	2026-01-20 13:50:15.959	\N
cmkmnip1n19jiqo4k76g8csst	555492614092@s.whatsapp.net	555492614092@s.whatsapp.net,5554992614092@s.whatsapp.net	2026-01-20 13:50:15.961	2026-01-20 13:50:15.961	\N
cmkmnip1u19jnqo4ko0r42a3e	555198260353@s.whatsapp.net	555198260353@s.whatsapp.net,5551998260353@s.whatsapp.net	2026-01-20 13:50:15.968	2026-01-20 13:50:15.968	\N
cmkmnip1x19jpqo4k1q7us53i	555599133559@s.whatsapp.net	555599133559@s.whatsapp.net,5555999133559@s.whatsapp.net	2026-01-20 13:50:15.969	2026-01-20 13:50:15.969	\N
cmkmnip2119jtqo4ku5kkrp2l	555492201133@s.whatsapp.net	161787156656170@lid,555492201133@s.whatsapp.net,5554992201133@s.whatsapp.net	2026-01-20 13:50:15.972	2026-01-29 21:29:00.982	\N
cmkmnip0o19isqo4kr020uq5r	555584073891@s.whatsapp.net	17716958232581@lid,555584073891@s.whatsapp.net,5555984073891@s.whatsapp.net	2026-01-20 13:50:15.949	2026-02-09 17:04:04.833	\N
cmkmniozo194iqo4kxjvsyv4z	555491082757@s.whatsapp.net	100927621038277@lid,555491082757@s.whatsapp.net,5554991082757@s.whatsapp.net	2026-01-20 13:50:15.938	2026-02-23 17:10:34.888	lid
cmkmnioy1193cqo4kbt69bktx	555596746681@s.whatsapp.net	555596746681@s.whatsapp.net,5555996746681@s.whatsapp.net	2026-01-20 13:50:15.9	2026-01-20 13:50:15.9	\N
cmkmnioya193gqo4koigpezdk	555591464707@s.whatsapp.net	555591464707@s.whatsapp.net,5555991464707@s.whatsapp.net	2026-01-20 13:50:15.903	2026-01-20 13:50:15.903	\N
cmkmnioyj193sqo4ktatsnsxl	555499176580@s.whatsapp.net	555499176580@s.whatsapp.net,5554999176580@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyr193xqo4kztf79c8r	555591256940@s.whatsapp.net	555591256940@s.whatsapp.net,5555991256940@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyy1943qo4k531r7zrl	5511982043401@s.whatsapp.net	551182043401@s.whatsapp.net,5511982043401@s.whatsapp.net	2026-01-20 13:50:15.926	2026-01-20 13:50:15.926	\N
cmkmnioz21944qo4kinldxnfs	555591673179@s.whatsapp.net	555591673179@s.whatsapp.net,5555991673179@s.whatsapp.net	2026-01-20 13:50:15.927	2026-01-20 13:50:15.927	\N
cmkmnioyf193mqo4ksmg9xliw	555581374847@s.whatsapp.net	178486039818288@lid,555581374847@s.whatsapp.net,5555981374847@s.whatsapp.net	2026-01-20 13:50:15.922	2026-02-21 00:21:29.042	\N
cmkmnioyc193kqo4knyai88oj	5511912106158@s.whatsapp.net	551112106158@s.whatsapp.net,5511912106158@s.whatsapp.net	2026-01-20 13:50:15.905	2026-01-20 13:50:15.905	\N
cmkmnioyi193rqo4kxdau3bot	555491449844@s.whatsapp.net	555491449844@s.whatsapp.net,5554991449844@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyq193tqo4k2n3nerv3	555491839994@s.whatsapp.net	555491839994@s.whatsapp.net,5554991839994@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmnioyt1940qo4kjc9t0d3i	555599320923@s.whatsapp.net	555599320923@s.whatsapp.net,5555999320923@s.whatsapp.net	2026-01-20 13:50:15.924	2026-01-20 13:50:15.924	\N
cmkmniozc194aqo4kedcf7fh8	555499068712@s.whatsapp.net	555499068712@s.whatsapp.net,5554999068712@s.whatsapp.net	2026-01-20 13:50:15.932	2026-01-20 13:50:15.932	\N
cmkmniozh194eqo4kiah4bgat	554791345289@s.whatsapp.net	554791345289@s.whatsapp.net,5547991345289@s.whatsapp.net	2026-01-20 13:50:15.935	2026-01-20 13:50:15.935	\N
cmkmniozo194jqo4k9ldih25g	555591471028@s.whatsapp.net	555591471028@s.whatsapp.net,5555991471028@s.whatsapp.net	2026-01-20 13:50:15.938	2026-01-20 13:50:15.938	\N
cmkmnip0919cuqo4k4e6v686c	555437710080@s.whatsapp.net	555437710080@s.whatsapp.net,5554937710080@s.whatsapp.net	2026-01-20 13:50:15.946	2026-01-20 13:50:15.946	\N
cmkmnip0r19iuqo4k2oszo8z3	555599778803@s.whatsapp.net	555599778803@s.whatsapp.net,5555999778803@s.whatsapp.net	2026-01-20 13:50:15.949	2026-01-20 13:50:15.949	\N
cmkmnip0w19iyqo4kqsj4mxoc	555596504939@s.whatsapp.net	555596504939@s.whatsapp.net,5555996504939@s.whatsapp.net	2026-01-20 13:50:15.952	2026-01-20 13:50:15.952	\N
cmkmnip1719j6qo4kmcfbsh1z	555491611877@s.whatsapp.net	555491611877@s.whatsapp.net,5554991611877@s.whatsapp.net	2026-01-20 13:50:15.955	2026-01-20 13:50:15.955	\N
cmkmnip1d19jaqo4kwuaoz7go	555491271398@s.whatsapp.net	555491271398@s.whatsapp.net,5554991271398@s.whatsapp.net	2026-01-20 13:50:15.958	2026-01-20 13:50:15.958	\N
cmkmnip1h19jdqo4k9oeopwz0	555599270066@s.whatsapp.net	555599270066@s.whatsapp.net,5555999270066@s.whatsapp.net	2026-01-20 13:50:15.958	2026-01-20 13:50:15.958	\N
cmkmnip1n19jjqo4kk8xzwlmt	555591536092@s.whatsapp.net	555591536092@s.whatsapp.net,5555991536092@s.whatsapp.net	2026-01-20 13:50:15.961	2026-01-20 13:50:15.961	\N
cmkmnip1t19jlqo4kkh79o249	555491962755@s.whatsapp.net	555491962755@s.whatsapp.net,5554991962755@s.whatsapp.net	2026-01-20 13:50:15.968	2026-01-20 13:50:15.968	\N
cmkmnip1x19jqqo4k2dpchyod	554796103815@s.whatsapp.net	554796103815@s.whatsapp.net,5547996103815@s.whatsapp.net	2026-01-20 13:50:15.969	2026-01-20 13:50:15.969	\N
cmkpqjau03xk8qo4kkg2jgufr	555596766372:0@s.whatsapp.net	55556766372:0@s.whatsapp.net,5555996766372:0@s.whatsapp.net	2026-01-22 17:38:01.752	2026-01-22 17:38:01.752	\N
cmkmnioqh18w2qo4k553h9eh4	555433241283@s.whatsapp.net	189773213859970@lid,555433241283@s.whatsapp.net,5554933241283@s.whatsapp.net	2026-01-20 13:50:15.665	2026-01-20 14:55:59.255	\N
cmkmx36hv1y4wqo4kmnk0wrfa	556196235881@s.whatsapp.net	556196235881@s.whatsapp.net,5561996235881@s.whatsapp.net	2026-01-20 18:18:08.419	2026-01-20 18:18:08.419	lid
cmkmu858p1voxqo4kw3pmh2on	555597056646@s.whatsapp.net	175407101919423@lid,555597056646@s.whatsapp.net,5555997056646@s.whatsapp.net	2026-01-20 16:58:01.225	2026-02-21 00:21:28.963	\N
cmkmnioz41946qo4kemldri2m	555492040936@s.whatsapp.net	205638806306863@lid,555492040936@s.whatsapp.net,5554992040936@s.whatsapp.net	2026-01-20 13:50:15.928	2026-02-21 00:21:28.973	\N
cmkmnio3h18oxqo4k1wsskjz0	555491770155@s.whatsapp.net	206553651122351@lid,555491770155@s.whatsapp.net,5554991770155@s.whatsapp.net	2026-01-20 13:50:14.149	2026-01-22 15:32:43.244	\N
cmkpoeahk3w4rqo4km60fleuh	555596766372:66@s.whatsapp.net	55556766372:66@s.whatsapp.net,5555996766372:66@s.whatsapp.net	2026-01-22 16:38:08.792	2026-01-22 16:38:08.792	\N
cmkqw364b00tln94pq60wabip	555499842204@s.whatsapp.net	555499842204@s.whatsapp.net,5554999842204@s.whatsapp.net,89099163701263@lid	2026-01-23 13:01:13.019	2026-01-26 16:48:21.751	\N
cmko3azl12xchqo4k2hyfes82	555433241068@s.whatsapp.net	555433241068@s.whatsapp.net,5554933241068@s.whatsapp.net	2026-01-21 13:59:56.581	2026-01-21 13:59:56.581	lid
cmkmnioxo1930qo4k8ntpjwbn	555491952748@s.whatsapp.net	182909906493488@lid,555491952748@s.whatsapp.net,5554991952748@s.whatsapp.net	2026-01-20 13:50:15.894	2026-02-23 15:16:21.172	lid
cmkmnio4118prqo4knria0wdt	555491753394@s.whatsapp.net	126882024526030@lid,555491753394@s.whatsapp.net,5554991753394@s.whatsapp.net	2026-01-20 13:50:14.452	2026-02-21 00:21:29.215	\N
cmkokfnjs3t2jqo4ku2kfnvi8	555591045412:0@s.whatsapp.net	55551045412:0@s.whatsapp.net,5555991045412:0@s.whatsapp.net	2026-01-21 21:59:27.736	2026-01-21 21:59:27.736	\N
cmkmnip1319j2qo4k06b6fiaa	555491369656@s.whatsapp.net	115865500540996@lid,555491369656@s.whatsapp.net,5554991369656@s.whatsapp.net	2026-01-20 13:50:15.953	2026-02-24 13:56:05.845	lid
cmkqv821x00q2n94pfxxzc183	555183292354@s.whatsapp.net	555183292354@s.whatsapp.net,5551983292354@s.whatsapp.net	2026-01-23 12:37:01.413	2026-01-23 12:37:01.413	lid
cmkmnip0n19irqo4kib2fo3rx	554792725886@s.whatsapp.net	170239769735238@lid,554792725886@s.whatsapp.net,5547992725886@s.whatsapp.net	2026-01-20 13:50:15.947	2026-02-21 00:21:28.937	\N
cmkmniowa1914qo4kphaxu3jy	5527988479985@s.whatsapp.net	121848440299529@lid,552788479985@s.whatsapp.net,5527988479985@s.whatsapp.net	2026-01-20 13:50:15.82	2026-02-12 00:18:50.665	\N
cmkpfjqbv3up6qo4kfk9xzp5s	555433245883@s.whatsapp.net	177339484889146@lid,555433245883@s.whatsapp.net,5554933245883@s.whatsapp.net	2026-01-22 12:30:26.059	2026-02-06 20:10:28.46	lid
cmkmniopu18vjqo4k8nn9fwuw	555596766372@s.whatsapp.net	125589272969419@lid,555596766372@s.whatsapp.net,5555996766372@s.whatsapp.net	2026-01-20 13:50:15.655	2026-02-23 14:16:14.753	\N
cmkmniozw196fqo4kd40an01r	555491782132@s.whatsapp.net	555491782132@s.whatsapp.net,5554991782132@s.whatsapp.net,91659081638029@lid	2026-01-20 13:50:15.94	2026-02-24 16:55:50.095	lid
cmkmnio4518pyqo4k7gwrcxv9	555492066475@s.whatsapp.net	127504744480999@lid,555492066475@s.whatsapp.net,5554992066475@s.whatsapp.net	2026-01-20 13:50:14.486	2026-01-23 16:34:06.064	\N
cmkrc20fc03kgn94p75cfukba	555491369656:0@s.whatsapp.net	55541369656:0@s.whatsapp.net,5554991369656:0@s.whatsapp.net	2026-01-23 20:28:12.84	2026-01-23 20:28:12.84	\N
cmkv4ix9n09v9n94pyu4ppfe3	555484090375@s.whatsapp.net	109895428878472@lid,555484090375@s.whatsapp.net,5554984090375@s.whatsapp.net	2026-01-26 12:08:29.675	2026-02-02 16:31:03.569	\N
cmkv7jjvt0a54n94pj397460o	5511943570047@s.whatsapp.net	551143570047@s.whatsapp.net,5511943570047@s.whatsapp.net	2026-01-26 13:32:57.834	2026-01-26 13:32:57.834	lid
cmkv7q1020a59n94prscjt4j7	555491189969:0@s.whatsapp.net	55541189969:0@s.whatsapp.net,5554991189969:0@s.whatsapp.net	2026-01-26 13:37:59.954	2026-01-26 13:37:59.954	\N
cmkmniop518uzqo4ks4x25d8o	555491189969@s.whatsapp.net	168019221295316@lid,555491189969@s.whatsapp.net,5554991189969@s.whatsapp.net	2026-01-20 13:50:15.644	2026-02-12 11:48:15.142	\N
cmkmniorb18whqo4kw8rmazzb	555491485671@s.whatsapp.net	246054498861139@lid,555491485671@s.whatsapp.net,5554991485671@s.whatsapp.net	2026-01-20 13:50:15.676	2026-02-21 00:21:29.04	\N
cmlbhnayw1qr7n94pbbg4yfgi	555499789579@s.whatsapp.net	52828718526542@lid,555499789579@s.whatsapp.net,5554999789579@s.whatsapp.net	2026-02-06 23:00:07.881	2026-02-06 23:10:42.801	\N
cmkmniolk18rwqo4k0b83nzjj	555491655039@s.whatsapp.net	175737311129613@lid,555491655039@s.whatsapp.net,5554991655039@s.whatsapp.net	2026-01-20 13:50:15.56	2026-02-07 00:38:09.64	\N
cmkwn16sc0gjon94pitsc4xd5	555599999931@s.whatsapp.net	212132763328610@lid,555599999931@s.whatsapp.net,5555999999931@s.whatsapp.net	2026-01-27 13:34:21.084	2026-01-27 13:34:21.084	\N
cmkx686gy0kc5n94pj8m25ow5	555491930807:0@s.whatsapp.net	55541930807:0@s.whatsapp.net,5554991930807:0@s.whatsapp.net	2026-01-27 22:31:39.97	2026-01-27 22:31:39.97	\N
cml529fsd148dn94p08hxdf4z	555596296896@s.whatsapp.net	123484638322769@lid,555596296896@s.whatsapp.net,5555996296896@s.whatsapp.net	2026-02-02 11:02:49.646	2026-02-19 12:03:28.286	lid
cml0pszp70th2n94p0rxigop2	555431993565@s.whatsapp.net	19095911170218@lid,555431993565@s.whatsapp.net,5554931993565@s.whatsapp.net	2026-01-30 10:03:02.196	2026-01-30 10:03:02.196	\N
cmkmniow7190zqo4kfp13c6q9	555599670465@s.whatsapp.net	189012987932746@lid,555599670465@s.whatsapp.net,5555999670465@s.whatsapp.net	2026-01-20 13:50:15.815	2026-02-21 00:21:29.216	\N
cmkyko9jd0o0en94p3zqu8gzx	555491529977@s.whatsapp.net	246883343663172@lid,555491529977@s.whatsapp.net,5554991529977@s.whatsapp.net	2026-01-28 22:03:51.241	2026-01-28 22:15:06.754	lid
cml147ibz0ydzn94pml39u4ez	555491094135@s.whatsapp.net	181247670263892@lid,555491094135@s.whatsapp.net,5554991094135@s.whatsapp.net	2026-01-30 16:46:14.159	2026-01-30 17:12:51.803	lid
cml15i0y90ymkn94p9nghc1yy	558193170673@s.whatsapp.net	558193170673@s.whatsapp.net,5581993170673@s.whatsapp.net	2026-01-30 17:22:24.466	2026-01-30 17:22:24.466	lid
cml2dzx9b10ern94pn11kcji6	555494630073@s.whatsapp.net	555494630073@s.whatsapp.net,5554994630073@s.whatsapp.net	2026-01-31 14:08:02.591	2026-01-31 14:08:02.591	lid
cml2e3nqg10fan94pd7wh2qd3	555494630073:0@s.whatsapp.net	55544630073:0@s.whatsapp.net,5554994630073:0@s.whatsapp.net	2026-01-31 14:10:56.872	2026-01-31 14:10:56.872	\N
cml3uneiv12d7n94p6fb7a8rn	555199687494:0@s.whatsapp.net	55519687494:0@s.whatsapp.net,5551999687494:0@s.whatsapp.net	2026-02-01 14:41:58.088	2026-02-01 14:41:58.088	\N
cml45409a12vwn94pbh8o73km	555491815820@s.whatsapp.net	555491815820@s.whatsapp.net,5554991815820@s.whatsapp.net	2026-02-01 19:34:48.91	2026-02-01 19:34:48.91	lid
cmkzx0xnp0sf1n94ptgnsgqsk	555591632199@s.whatsapp.net	555591632199@s.whatsapp.net,5555991632199@s.whatsapp.net	2026-01-29 20:37:23.942	2026-01-29 20:37:23.942	lid
cmkmniowx191sqo4kpf9ghqkc	555499324379@s.whatsapp.net	167263273541879@lid,555499324379@s.whatsapp.net,5554999324379@s.whatsapp.net	2026-01-20 13:50:15.844	2026-02-21 00:21:28.961	\N
cml5nv8ak16zzn94p6du68n4d	555399110090@s.whatsapp.net	555399110090@s.whatsapp.net,5553999110090@s.whatsapp.net	2026-02-02 21:07:38.3	2026-02-02 21:07:38.3	lid
cml6sk75e19wwn94p9v1dfdql	555499321837:0@s.whatsapp.net	55549321837:0@s.whatsapp.net,5554999321837:0@s.whatsapp.net	2026-02-03 16:06:47.858	2026-02-03 16:06:47.858	\N
cmkmniowe1918qo4kbsuj3qwv	555491025706@s.whatsapp.net	555491025706@s.whatsapp.net,5554991025706@s.whatsapp.net	2026-01-20 13:50:15.824	2026-02-07 00:38:09.682	\N
cml6u3vqy1a8bn94prnq21im6	555499608125@s.whatsapp.net	555499608125@s.whatsapp.net,5554999608125@s.whatsapp.net	2026-02-03 16:50:05.818	2026-02-03 16:50:05.818	lid
cmkmniomp18swqo4kdf679k4n	555499309331@s.whatsapp.net	154356846469192@lid,555499309331@s.whatsapp.net,5554999309331@s.whatsapp.net	2026-01-20 13:50:15.59	2026-02-11 18:42:50.268	\N
cml53819e14dan94p91iu3p9b	555491439027@s.whatsapp.net	172945632682044@lid,555491439027@s.whatsapp.net,5554991439027@s.whatsapp.net	2026-02-02 11:29:43.778	2026-02-05 11:54:43.554	lid
cmlf8un383hzzn94p7xeyz0y3	555597079965@s.whatsapp.net	555597079965@s.whatsapp.net,5555997079965@s.whatsapp.net	2026-02-09 14:04:58.341	2026-02-09 14:04:58.341	lid
cmlfh57fg3j6tn94pfa7yk5qp	5521966341806@s.whatsapp.net	552166341806@s.whatsapp.net,5521966341806@s.whatsapp.net	2026-02-09 17:57:08.188	2026-02-21 00:21:32.072	\N
cmlbl5ffg1so1n94pxbhh7rep	553599313679@s.whatsapp.net	553599313679@s.whatsapp.net,5535999313679@s.whatsapp.net	2026-02-07 00:38:12.269	2026-02-07 00:38:12.269	\N
cmkmnio2v18ogqo4kj2xr3579	555599634080@s.whatsapp.net	555599634080@s.whatsapp.net,5555999634080@s.whatsapp.net,84237344600309@lid	2026-01-20 13:50:14.009	2026-02-21 00:21:29.172	\N
cmlf72oud3hn5n94ptmyqtcqu	555491080441@s.whatsapp.net	555491080441@s.whatsapp.net,5554991080441@s.whatsapp.net	2026-02-09 13:15:14.63	2026-02-09 13:15:14.63	lid
cmlf87bco3hqqn94plrihhgof	555496457598@s.whatsapp.net	555496457598@s.whatsapp.net,5554996457598@s.whatsapp.net	2026-02-09 13:46:50.041	2026-02-09 13:46:50.041	lid
cmlfat5ea3if8n94p2xhxvqfv	555491076875@s.whatsapp.net	555491076875@s.whatsapp.net,5554991076875@s.whatsapp.net	2026-02-09 14:59:47.986	2026-02-09 14:59:47.986	lid
cmkmniood18uaqo4k5rxtenlj	555491627756@s.whatsapp.net	555491627756@s.whatsapp.net,5554991627756@s.whatsapp.net,58153974628501@lid	2026-01-20 13:50:15.632	2026-02-21 00:21:28.971	\N
cmkmniov518zvqo4kg80e9t5a	555491109772@s.whatsapp.net	172443037638660@lid,555491109772@s.whatsapp.net,5554991109772@s.whatsapp.net	2026-01-20 13:50:15.776	2026-02-24 13:59:05.214	lid
cmkmnio2s18obqo4kn4528k02	555599631365@s.whatsapp.net	277313220538515@lid,555599631365@s.whatsapp.net,5555999631365@s.whatsapp.net	2026-01-20 13:50:13.975	2026-02-18 12:31:08.442	\N
cmljpnbvr4141n94pnrzrlcmk	555491223206@s.whatsapp.net	136000256925927@lid,555491223206@s.whatsapp.net,5554991223206@s.whatsapp.net	2026-02-12 17:06:15.399	2026-02-12 17:06:15.399	\N
cmlhzbqb73rl2n94preaewf6x	555491383313@s.whatsapp.net	555491383313@s.whatsapp.net,5554991383313@s.whatsapp.net,80182845133014@lid	2026-02-11 12:01:38.035	2026-02-11 12:45:08.036	lid
cmkmnio0q18nbqo4k7oqpeege	555591380464@s.whatsapp.net	119541858332898@lid,555591380464@s.whatsapp.net,5555991380464@s.whatsapp.net	2026-01-20 13:50:13.623	2026-02-21 00:21:29.081	\N
cmkmnioya193hqo4ksgxd1n68	555492810374@s.whatsapp.net	224888832929896@lid,555492810374@s.whatsapp.net,5554992810374@s.whatsapp.net	2026-01-20 13:50:15.903	2026-02-21 00:21:28.951	\N
cmkmniox0191uqo4km071q7ew	555491223205@s.whatsapp.net	255559362187410@lid,555491223205@s.whatsapp.net,5554991223205@s.whatsapp.net	2026-01-20 13:50:15.845	2026-02-13 12:56:55.819	\N
cmkmnio2d18nqqo4kvmy1vxxu	555491930807@s.whatsapp.net	223858074357786@lid,555491930807@s.whatsapp.net,5554991930807@s.whatsapp.net	2026-01-20 13:50:13.773	2026-02-18 11:25:52.032	\N
cmkmniork18woqo4k90fkr5hj	555599044200@s.whatsapp.net	122861951922253@lid,555599044200@s.whatsapp.net,5555999044200@s.whatsapp.net	2026-01-20 13:50:15.687	2026-02-21 00:21:28.989	\N
cmlkyznkj453gn94pzsp4jv7n	555493260345@s.whatsapp.net	555493260345@s.whatsapp.net,5554993260345@s.whatsapp.net	2026-02-13 14:15:33.139	2026-02-13 14:15:33.139	lid
cmkmniowc1916qo4k9u9u6t8d	555491523091@s.whatsapp.net	276449915318274@lid,555491523091@s.whatsapp.net,5554991523091@s.whatsapp.net	2026-01-20 13:50:15.822	2026-02-13 14:31:23.866	\N
cmll05he745bhn94pj1dvs15v	555491871926@s.whatsapp.net	555491871926@s.whatsapp.net,5554991871926@s.whatsapp.net	2026-02-13 14:48:04.688	2026-02-13 14:48:04.688	lid
cmlpqmhvh00ieli4p7urzds26	555494379090@s.whatsapp.net	555494379090@s.whatsapp.net,5554994379090@s.whatsapp.net	2026-02-16 22:20:13.18	2026-02-16 22:20:13.18	lid
cmkmniomg18sqqo4kioh2lyz1	555591445655@s.whatsapp.net	555591445655@s.whatsapp.net,5555991445655@s.whatsapp.net,63106139062418@lid	2026-01-20 13:50:15.585	2026-02-18 13:25:45.852	\N
cmls9q2sc07qcli4pe3e0al1v	555192128723@s.whatsapp.net	555192128723@s.whatsapp.net,5551992128723@s.whatsapp.net	2026-02-18 16:50:25.308	2026-02-18 16:50:25.308	lid
cmlsacayo07rvli4pjkjd84am	554196497914@s.whatsapp.net	554196497914@s.whatsapp.net,5541996497914@s.whatsapp.net	2026-02-18 17:07:42.336	2026-02-18 17:07:42.336	lid
cmluu4uuu0eg1li4pubhe3afi	5515997090711@s.whatsapp.net	551597090711@s.whatsapp.net,5515997090711@s.whatsapp.net	2026-02-20 11:57:19.541	2026-02-20 11:57:19.541	lid
cmlsacmsl07s8li4p0vc86q3g	555491516821@s.whatsapp.net	129132570615993@lid,555491516821@s.whatsapp.net,5554991516821@s.whatsapp.net	2026-02-18 17:07:57.669	2026-02-19 11:53:26.628	\N
cmltkiezk0bagli4p7evgyg7b	555597031231@s.whatsapp.net	555597031231@s.whatsapp.net,5555997031231@s.whatsapp.net	2026-02-19 14:40:09.823	2026-02-19 14:40:09.823	lid
cmluuowll0eoeli4pyx8efes3	5515996492228@s.whatsapp.net	264986765070567@lid,551596492228@s.whatsapp.net,5515996492228@s.whatsapp.net	2026-02-20 12:12:54.922	2026-02-20 12:17:08.032	\N
cml85ejn01ermn94pm55tgrpf	555591853574@s.whatsapp.net	555591853574@s.whatsapp.net,5555991853574@s.whatsapp.net,74500536307877@lid	2026-02-04 14:54:05.292	2026-02-20 13:36:06.113	\N
cmkmnion818tnqo4k8i46taul	555491877630@s.whatsapp.net	555491877630@s.whatsapp.net,5554991877630@s.whatsapp.net,70051470291092@lid	2026-01-20 13:50:15.617	2026-02-21 00:21:28.947	\N
cmlsjrrda094lli4p56mvmfns	555591079462@s.whatsapp.net	555591079462@s.whatsapp.net,5555991079462@s.whatsapp.net	2026-02-18 21:31:39.982	2026-02-21 00:21:28.992	\N
cmkmnioun18zgqo4k5j4suo5z	555491089206@s.whatsapp.net	555491089206@s.whatsapp.net,5554991089206@s.whatsapp.net,98762890440953@lid	2026-01-20 13:50:15.769	2026-02-21 00:21:28.992	\N
cmlvkpx6d0icbli4ppdzj9pw2	555591726354@s.whatsapp.net	555591726354@s.whatsapp.net,5555991726354@s.whatsapp.net	2026-02-21 00:21:31.947	2026-02-21 00:21:31.947	\N
cmlvkpx6b0icali4p2ert7vch	553599470827@s.whatsapp.net	553599470827@s.whatsapp.net,5535999470827@s.whatsapp.net	2026-02-21 00:21:31.666	2026-02-21 00:21:31.666	\N
cmlw83g4b1lh9li4pqyew5f85	555499761800@s.whatsapp.net	555499761800@s.whatsapp.net,5554999761800@s.whatsapp.net	2026-02-21 11:15:54.587	2026-02-21 11:17:31.432	lid
cmlwe3vtk1nwlli4p6mtpchux	554888496967@s.whatsapp.net	280474568130793@lid,554888496967@s.whatsapp.net,5548988496967@s.whatsapp.net	2026-02-21 14:04:12.632	2026-02-21 14:04:12.632	\N
cmlzs6okb3os6li4p5kn4b7md	120363403312128273@g.us	120363403312128273@g.us	2026-02-23 23:01:36.347	2026-02-23 23:01:36.347	\N
cmm14yrba3sudli4ptw5b7lkt	555496255389@s.whatsapp.net	555496255389@s.whatsapp.net,5554996255389@s.whatsapp.net	2026-02-24 21:47:07.845	2026-02-24 21:47:07.845	lid
cmm1885kk3syuli4pfztnbl5p	5511945895095@s.whatsapp.net	551145895095@s.whatsapp.net,5511945895095@s.whatsapp.net	2026-02-24 23:18:25.076	2026-02-24 23:18:25.076	lid
\.


--
-- Data for Name: Kafka; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Kafka" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Label" (id, "labelId", name, color, "predefinedId", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Media" (id, "fileName", type, mimetype, "createdAt", "messageId", "instanceId") FROM stdin;
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Message" (id, key, "pushName", participant, "messageType", message, "contextInfo", source, "messageTimestamp", "chatwootMessageId", "chatwootInboxId", "chatwootConversationId", "chatwootContactInboxSourceId", "chatwootIsRead", "instanceId", "webhookUrl", "sessionId", status) FROM stdin;
\.


--
-- Data for Name: MessageUpdate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MessageUpdate" (id, "keyId", "remoteJid", "fromMe", participant, "pollUpdates", status, "messageId", "instanceId") FROM stdin;
\.


--
-- Data for Name: N8n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."N8n" (id, enabled, description, "webhookUrl", "basicAuthUser", "basicAuthPass", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: N8nSetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."N8nSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "createdAt", "updatedAt", "n8nIdFallback", "instanceId") FROM stdin;
\.


--
-- Data for Name: Nats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Nats" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: OpenaiBot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenaiBot" (id, "assistantId", model, "systemMessages", "assistantMessages", "userMessages", "maxTokens", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "openaiCredsId", "instanceId", enabled, "botType", description, "functionUrl", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: OpenaiCreds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenaiCreds" (id, "apiKey", "createdAt", "updatedAt", "instanceId", name) FROM stdin;
\.


--
-- Data for Name: OpenaiSetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenaiSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "openaiCredsId", "openaiIdFallback", "instanceId", "speechToText", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Proxy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Proxy" (id, enabled, host, port, protocol, username, password, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Pusher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Pusher" (id, enabled, "appId", key, secret, cluster, "useTLS", events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Rabbitmq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Rabbitmq" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Session" (id, "sessionId", creds, "createdAt") FROM stdin;
cmm2mp22b000zld4wsi4i5s8b	7988b509-225a-4a67-8501-a64d641f662d	"{\\"noiseKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"cHACyJdWJSsl/aQmULdpViQjT6XOueyF+kLXwnd7H3I=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"xQ6Y6G38EZgmF6YCjD6Y/fqZjZrHioup0cM+tyL7SCw=\\"}},\\"pairingEphemeralKeyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"mHQOYmhtAdNxlneWd5l7O75qkfrkuZaQXQVaECJOwHE=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"FfymOnwHMFaeJN8/6pHYl3zTo5DqJbRB2sn0zXfY0CA=\\"}},\\"signedIdentityKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"4DX+bEWVg8L+RmkjukBejTdlpCUuuyB95Gxy8j+vX3g=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"hiogyOVFrkS8Z1+yB8xZYFgE4SVOc8PlGK/DMqxMS24=\\"}},\\"signedPreKey\\":{\\"keyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"6AEYrsCdWk25YMO/TcvW+e8ORUVSzYWaqWZ+QYQf3FU=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"NoHiPWBvWs/qo03nKKfK/F9J11OnZ8g65DRKIzeeRSc=\\"}},\\"signature\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"dfQ0J3D3CdmqU3ULGde6D3Rgfp61YGBcvXbRE27BaDR+6c+qPVCW02T+40Kghf4M8NFcxOzhhdZ4CAq9WbXeig==\\"},\\"keyId\\":1},\\"registrationId\\":96,\\"advSecretKey\\":\\"tJoaB9lt8cscOSLx5jJYqHuG0FD6tdD7oHie4O5PsPM=\\",\\"processedHistoryMessages\\":[],\\"nextPreKeyId\\":1,\\"firstUnuploadedPreKeyId\\":1,\\"accountSyncCounter\\":0,\\"accountSettings\\":{\\"unarchiveChats\\":false},\\"registered\\":false}"	2026-02-25 22:51:14.483
\.


--
-- Data for Name: Setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Setting" (id, "rejectCall", "msgCall", "groupsIgnore", "alwaysOnline", "readMessages", "readStatus", "syncFullHistory", "createdAt", "updatedAt", "instanceId", "wavoipToken") FROM stdin;
cmm2mp21l000xld4wss3jton0	t	Chamadas de voz não são aceitas neste número.	f	t	t	f	f	2026-02-25 22:51:14.458	2026-02-25 22:51:56.409	7988b509-225a-4a67-8501-a64d641f662d	
\.


--
-- Data for Name: Sqs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sqs" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Template" (id, "templateId", name, template, "createdAt", "updatedAt", "instanceId", "webhookUrl") FROM stdin;
\.


--
-- Data for Name: Typebot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Typebot" (id, enabled, url, typebot, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "createdAt", "updatedAt", "triggerType", "triggerOperator", "triggerValue", "instanceId", "debounceTime", "ignoreJids", description, "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: TypebotSetting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TypebotSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "createdAt", "updatedAt", "instanceId", "debounceTime", "typebotIdFallback", "ignoreJids", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Webhook; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Webhook" (id, url, enabled, events, "webhookByEvents", "webhookBase64", "createdAt", "updatedAt", "instanceId", headers) FROM stdin;
cmm2mpyhq0019ld4wiobl9xuj	https://app.agrowsynccrm.com.br/AgrowCrm/api/webhook	t	["APPLICATION_STARTUP", "QRCODE_UPDATED", "MESSAGES_SET", "MESSAGES_UPSERT", "MESSAGES_UPDATE", "MESSAGES_DELETE", "SEND_MESSAGE", "CONTACTS_SET", "CONTACTS_UPSERT", "CONTACTS_UPDATE", "PRESENCE_UPDATE", "CHATS_SET", "CHATS_UPSERT", "CHATS_UPDATE", "CHATS_DELETE", "GROUPS_UPSERT", "GROUP_UPDATE", "GROUP_PARTICIPANTS_UPDATE", "CONNECTION_UPDATE", "LABELS_EDIT", "LABELS_ASSOCIATION", "CALL", "TYPEBOT_START", "TYPEBOT_CHANGE_STATUS"]	f	f	2026-02-25 22:51:56.51	2026-02-25 22:51:56.51	7988b509-225a-4a67-8501-a64d641f662d	{"Content-Type": "application/json"}
\.


--
-- Data for Name: Websocket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Websocket" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
769ba1ac-2c1e-4ee8-875a-a6ddf43c667c	1af30cbbccd90152fbb1b99a458978e42428a792b822b4b5f9c9c7fffbf7264f	2026-01-17 14:05:22.164164-03	20240819154941_add_context_to_integration_session	\N	\N	2026-01-17 14:05:22.16073-03	1
bf5268f2-22e4-48d3-bb25-d7e4876f3124	7507eff6b49fad53cdd0b3ace500f529597dfa1a8987afbb9807968a8ee8ef49	2026-01-17 14:05:21.859215-03	20240609181238_init	\N	\N	2026-01-17 14:05:21.745543-03	1
39d848de-92c9-47c8-9efc-ec9868a64ed3	8c2a595975dc2f6dee831983304996e25c37014c48291576e7c8044078bfde32	2026-01-17 14:05:21.976865-03	20240722173259_add_name_column_to_openai_creds	\N	\N	2026-01-17 14:05:21.969717-03	1
8be8a144-89fb-428b-91cc-5b8f1a57f597	914eeefb9eba0dacdbcb7cdbe47567abd957543d6f27c39db4eec6a40c864008	2026-01-17 14:05:21.86313-03	20240610144159_create_column_profile_name_instance	\N	\N	2026-01-17 14:05:21.860679-03	1
32bf3e3b-882f-466f-b631-e741455d82bc	50d6920345af06dbd5086959784b7e2b4d163a5b555ff1029e5f81678a454444	2026-01-17 14:05:21.867142-03	20240611125754_create_columns_whitelabel_chatwoot	\N	\N	2026-01-17 14:05:21.864402-03	1
cdf3a96e-eef3-4bb0-9252-12e57351fb66	c29ccc88930138c50091712466f3f97bff48f6a0f486dcec5b19dc08c3612973	2026-01-17 14:05:22.052156-03	20240729180347_modify_typebot_session_status_openai_typebot_table	\N	\N	2026-01-17 14:05:22.033003-03	1
25b5c023-ffb7-48c8-a255-cc701b2cf249	b90c49299ed812fb46b71a4f0b9f818b7fc7109c52b1aff227a107236839d93c	2026-01-17 14:05:21.87123-03	20240611202817_create_columns_debounce_time_typebot	\N	\N	2026-01-17 14:05:21.868099-03	1
5d253919-4e11-44fd-abf6-befac41cb772	20b3c04d93799c25fa8b2d0a85d10f9280e915a5d7519542492ed85ff082a3c0	2026-01-17 14:05:21.982045-03	20240722173518_add_name_column_to_openai_creds	\N	\N	2026-01-17 14:05:21.978233-03	1
cb3286f0-a21a-464d-82f9-2ea58acb0d89	01303057a037f5dc28272ac513b60d5a75be71d1bf727e671ca538db3268fa2e	2026-01-17 14:05:21.875917-03	20240712144948_add_business_id_column_to_instances	\N	\N	2026-01-17 14:05:21.872256-03	1
9aab0a5c-2b66-46e1-88fe-4ab4b3d618c9	34235c250eb1f088c285489ad690b4c045680f1638076436cdc66de0ea382cc2	2026-01-17 14:05:21.886655-03	20240712150256_create_templates_table	\N	\N	2026-01-17 14:05:21.876766-03	1
f2e5b074-ee42-4961-9dfa-a7d6cbed4535	0ba192ba428c9ab5a9b31d1f7d73603ee47b6192e2f8c590f6d93ade0dbdbccf	2026-01-17 14:05:21.895058-03	20240712155950_adjusts_in_templates_table	\N	\N	2026-01-17 14:05:21.887769-03	1
c0ea5722-66ba-46a4-8d44-6ce43d9f223a	7ffb91b84cb7aa17b1f488d580626144cd557ccdfaec6654515545401d1938af	2026-01-17 14:05:21.989779-03	20240723152648_adjusts_in_column_openai_creds	\N	\N	2026-01-17 14:05:21.983217-03	1
49d32d10-cb01-4493-8780-2a40843dd051	426256b73f7ea52538dc91a890179c841325a9c387cf02885b81971d582af830	2026-01-17 14:05:21.901601-03	20240712162206_remove_templates_table	\N	\N	2026-01-17 14:05:21.89652-03	1
8cef22d6-b8a0-4615-a7f7-a650d5ddda6f	3496739609829e80daf733baecd3d3e4e279bf318a99adc1ca3aa1c76f893b2f	2026-01-17 14:05:21.907036-03	20240712223655_column_fallback_typebot	\N	\N	2026-01-17 14:05:21.902824-03	1
e06a518b-2b68-4fca-b3a6-0ce8993950f8	c8627bad5d72ee4ef774ed32c95a2524517b0c60c49fa67cd4ba9dff7cbdde3b	2026-01-17 14:05:22.107494-03	20240811021156_add_chat_name_column	\N	\N	2026-01-17 14:05:22.103865-03	1
87e9e96c-0e5e-473f-b152-4dcdf0f71ccc	bea48f697c0c5db52ade4a3f26c1321e3f5611c80ea50384baa54e58c6b3a79e	2026-01-17 14:05:21.911266-03	20240712230631_column_ignore_jids_typebot	\N	\N	2026-01-17 14:05:21.908278-03	1
4801e1a8-3ffa-489f-9a75-e50016464e3a	3056f8f1335e8933e4098f005e33cd4821190be2eb76520c0d01e2e13cf6e073	2026-01-17 14:05:21.995824-03	20240723200254_add_webhookurl_on_message	\N	\N	2026-01-17 14:05:21.991475-03	1
2409894a-bf37-4f95-9b43-6b697edae5ee	1bac56740af5d2d6512b29e7a6e0721d69b2a290400f6660b92b6f2d8b30cd6e	2026-01-17 14:05:21.923841-03	20240713184337_add_media_table	\N	\N	2026-01-17 14:05:21.912092-03	1
2082b99b-1715-4e57-b8fa-abb2689f7879	bdd992b253321ca9a9556e30fea5e7760556cb8e80140aec34066301b55dc675	2026-01-17 14:05:21.960044-03	20240718121437_add_openai_tables	\N	\N	2026-01-17 14:05:21.924836-03	1
5e70d8da-9a31-41c8-a370-d6fc08674332	961a8627684fe1e4c7123565db3d16db30768df41881342032f9a2df16145eaf	2026-01-17 14:05:22.082656-03	20240730152156_create_dify_tables	\N	\N	2026-01-17 14:05:22.053941-03	1
9d18abda-4c5e-4b23-ae95-32753f99741b	8147ec0cc86ac30ea1be05d461559ba5064273a3fcb3227af71ddcd895f5aebe	2026-01-17 14:05:21.967763-03	20240718123923_adjusts_openai_tables	\N	\N	2026-01-17 14:05:21.962118-03	1
0f495264-a924-403c-9116-79436536d878	9d6c9b4ffe51483a851f6507f7aefd2fb34f54a7c28961856e3230fda4f87022	2026-01-17 14:05:22.011797-03	20240725184147_create_template_table	\N	\N	2026-01-17 14:05:21.997556-03	1
02964f39-1916-4512-a394-340638b19394	94e2edb21107895c77b24402f41cd020c7f74dbb39b9a95664a45e62e2582be9	2026-01-17 14:05:22.017934-03	20240725202651_add_webhook_url_template_table	\N	\N	2026-01-17 14:05:22.014307-03	1
aa820a07-688d-4b3a-8382-0f2b4dce7c14	d0da588e4204c50bde2e41a615b9301afca072991033545b6f4e3e34e088db87	2026-01-17 14:05:22.024761-03	20240725221646_modify_token_instance_table	\N	\N	2026-01-17 14:05:22.019083-03	1
c9005d0f-f0f0-419d-bf13-85990b476a37	b56b053451d564ff6282078fad4fc7bff4aa71e3b0b8d00bf219da4ed1bc4c86	2026-01-17 14:05:22.089328-03	20240801193907_add_column_speech_to_text_openai_setting_table	\N	\N	2026-01-17 14:05:22.084139-03	1
ef02c0ed-a92b-42e8-bd72-a8233b5d2e90	a80f5c27cd80d088ea69153f8d6f4879406770ffa5a7fd50b28da82bd020322e	2026-01-17 14:05:22.03163-03	20240729115127_modify_trigger_type_openai_typebot_table	\N	\N	2026-01-17 14:05:22.026106-03	1
3f77f1fa-9f24-4f81-91cf-ace825140da9	428a9148f2a29f773e0c9813149e6d07bf51765e018652aeac0be2141a722b67	2026-01-17 14:05:22.133579-03	20240814173033_add_ignore_jids_chatwoot	\N	\N	2026-01-17 14:05:22.127141-03	1
c40df6ef-1b57-4141-b791-298db405c69e	2b963cbc826ea024f9a643af2d5d9fcea06717c90ec9bacb255d3836efa06aea	2026-01-17 14:05:22.096261-03	20240803163908_add_column_description_on_integrations_table	\N	\N	2026-01-17 14:05:22.09088-03	1
fbf5c180-bf69-4b94-8bfa-1a7f31467ac8	ee44f0420384d55de6d252fffb8f2cfa88479e5811e14cfe975d8edfcc6957e0	2026-01-17 14:05:22.116859-03	20240811183328_add_unique_index_for_remoted_jid_and_instance_in_contacts	\N	\N	2026-01-17 14:05:22.108676-03	1
768b7fb0-e728-46d7-b9e7-463d2ddd96f5	4d2dd947ebb7515c7c278472a10ebab6d5f41a5ef60e15df717a05d457d5d2aa	2026-01-17 14:05:22.102492-03	20240808210239_add_column_function_url_openaibot_table	\N	\N	2026-01-17 14:05:22.097507-03	1
6baa995d-7438-4bed-a69d-6503e0025dd8	29c330029a48aaee63567e63c4f4e57b7c1f5344162b11fbf61a4dc194547861	2026-01-17 14:05:22.125775-03	20240813003116_make_label_unique_for_instance	\N	\N	2026-01-17 14:05:22.118592-03	1
df4afc71-1098-497c-9ecc-2bdf7917f430	bc5cd1c7fb4df72e88cb4856c9c49ea340284c9d8f389fe558008a921494ed82	2026-01-17 14:05:22.15953-03	20240817110155_add_trigger_type_advanced	\N	\N	2026-01-17 14:05:22.15382-03	1
f00c7272-6866-4560-82c8-0e65eb2eded6	e1eb8997ac99fd555b8a9241c817b97fa5614124922b4e6b3cb1751e9e2199c7	2026-01-17 14:05:22.152392-03	20240814202359_integrations_unification	\N	\N	2026-01-17 14:05:22.135246-03	1
9be56946-3965-4706-917f-26075ad09f1e	a363a9ebc5bb526e504c4e6f71ed7702a5b6d317db6a9981f36c4560f9147fba	2026-01-17 14:05:22.170443-03	20240821120816_bot_id_integration_session	\N	\N	2026-01-17 14:05:22.165693-03	1
3d65d126-9ad5-4cc0-b05f-1bfb0cc8b903	e31947e6c709ee3a62504980ae9ab1ffbfd9faf0cf9ac389cfd6435734c49902	2026-01-17 14:05:22.188611-03	20240821171327_add_generic_bot_table	\N	\N	2026-01-17 14:05:22.171481-03	1
3347f6e6-f0e4-4505-87d3-8481ab6248c1	18dde8e48c49a97f33f5b789ccd919326253c26d43af72c77f6b13d4285ffba8	2026-01-17 14:05:22.206932-03	20240821194524_add_flowise_table	\N	\N	2026-01-17 14:05:22.18983-03	1
c46c8de6-33f8-4d45-a5a0-42dbc4eb12e6	0148a09e0e5eedafe5c5169c6351201a5c70ebaa853456693d75a7b82a851dbe	2026-01-17 14:05:22.212419-03	20240824161333_add_type_on_integration_sessions	\N	\N	2026-01-17 14:05:22.208398-03	1
e1e97881-2a4c-45a7-af1a-2c693d1180a8	710e7ee3aabf07aa6ee9bf2865c09f75d461efa5724dd83f5a6f324ea1e5e47c	2026-01-17 14:05:22.231666-03	20240825130616_change_to_evolution_bot	\N	\N	2026-01-17 14:05:22.213501-03	1
206df076-f99a-4cd0-a233-b0b803a6e7aa	0a6034359b1cf68820e829d31402032eed0f77586fb1ee590a98f5a6c3e15847	2026-01-17 14:05:22.373251-03	20250514232744_add_n8n_table	\N	\N	2026-01-17 14:05:22.355081-03	1
47cb9218-1cf4-4cb4-a761-393df9e1b101	d03a8a31df36eb0a07e80cd2a149b6d826e69bb2cb21fbe69943ae5ffba672ad	2026-01-17 14:05:22.242994-03	20240828140837_add_is_on_whatsapp_table	\N	\N	2026-01-17 14:05:22.232813-03	1
7bdcba90-4f71-4b74-8cdf-0388b6960afa	e927e00343b622bee7dab1b9b5c9fdd95007bfaf9d705ec52db9ecb05fb3d078	2026-01-17 14:05:22.248806-03	20240828141556_remove_name_column_from_on_whatsapp_table	\N	\N	2026-01-17 14:05:22.244329-03	1
d4d94a68-5a97-4cf6-8288-53ac455a8ee5	cf00d8ef2c28cf94aea51e7e2a80ddd65474a4f6c1113abc65dea6cc194c1a57	2026-01-17 14:05:22.261049-03	20240830193533_changed_table_case	\N	\N	2026-01-17 14:05:22.250303-03	1
0f4b62b2-da31-4a08-9b6b-a2c6f47a17c8	f9ddf352b22e52a1f466d40df95da7bd6f4bf51310c07911d9c990f720e1fe81	2026-01-17 14:05:22.393569-03	20250515211815_add_evoai_table	\N	\N	2026-01-17 14:05:22.374725-03	1
66606c27-7c9a-4475-8e00-797e72a13e6a	1cc60b9c38db62b694f753e2ee4c155e95c66815b5800f6ddb6f7cddec23b1ad	2026-01-17 14:05:22.266405-03	20240906202019_add_headers_on_webhook_config	\N	\N	2026-01-17 14:05:22.263536-03	1
737d2a0a-f65d-4a72-9400-12f4f491917e	7dff7227c1e013127210ab4f77b91dc24eae14bcd07f21fb27aaa2fa82b23865	2026-01-17 14:05:22.270509-03	20241001180457_add_message_status	\N	\N	2026-01-17 14:05:22.267188-03	1
457ec2d4-2a1d-4220-bb04-b6a21cc38531	07449acbac59175f82670f34664c1dcea4d34f9a1710f19bd3396e26868db09e	2026-01-17 14:05:22.28168-03	20241006130306_alter_status_on_message_table	\N	\N	2026-01-17 14:05:22.271436-03	1
5510d53f-aad6-42df-a246-3ef8ca9206d7	7a03627d41844a016b28b4194e36eea0e52cd24be0061535fecba4ccbd0e72f4	2026-01-17 14:05:22.399773-03	20250516012152_remove_unique_atribute_for_file_name_in_media	\N	\N	2026-01-17 14:05:22.39453-03	1
dcd271b5-c69f-40d1-9417-af0a084b09d7	7e9a7c45f05285e9fea38ccfa4266790a099107605299d81c309e689c06494ef	2026-01-17 14:05:22.287268-03	20241007164026_add_unread_messages_on_chat_table	\N	\N	2026-01-17 14:05:22.282898-03	1
660ea891-20cc-4424-b591-7adfc96b91a7	7e3e4686eb8009cbf0f71e8606a442b1c2862673dbc654b3f36f39a36efcb586	2026-01-17 14:05:22.298636-03	20241011085129_create_pusher_table	\N	\N	2026-01-17 14:05:22.288538-03	1
afb3956f-1613-499c-8996-af614ef11a76	270e1e51c7b9d24c0e68708ad167cb5748d591fd194ad422486574a0e83c0b79	2026-01-17 14:05:22.306998-03	20241011100803_split_messages_and_time_per_char_integrations	\N	\N	2026-01-17 14:05:22.299504-03	1
ea8927a9-6362-40b7-ac8c-38c4a2f447db	3fca4961d4e7fa8e1a99e3ec6b072d235bec706b7463ab699887be1084e3b656	2026-01-17 14:05:22.404644-03	20250612155048_add_coluns_trypebot_tables	\N	\N	2026-01-17 14:05:22.400928-03	1
a8910af0-5928-43f0-bf09-87db4ffaa46d	e82282df963a32556a9c8cd5fd908dd5810d4c35f0d7765ab9e844ebad1106a2	2026-01-17 14:05:22.333141-03	20241017144950_create_index	\N	\N	2026-01-17 14:05:22.308238-03	1
4fb1b408-4a9a-471a-9cb8-06261eed1df3	668e44d3cd8caafa8f60f89805e9f80587c1c69b4d52a21dfc79f4b615125b1c	2026-01-17 14:05:22.340147-03	20250116001415_add_wavoip_token_to_settings_table	\N	\N	2026-01-17 14:05:22.334944-03	1
870904fb-c178-439e-99af-8243096af994	17983175f27c61a0ee6aaa42c94d665cabb7e904ee91c33f867c657512210e1a	2026-01-17 14:05:22.353478-03	20250225180031_add_nats_integration	\N	\N	2026-01-17 14:05:22.342043-03	1
aaff2fc4-5186-4e1e-b44e-70e25b480468	36a19fe7711b98d02b450aedb2de8802b5e2e635a1e530cbc42f1d184e89bec3	2026-01-17 14:05:22.409663-03	20250613143000_add_lid_column_to_is_onwhatsapp	\N	\N	2026-01-17 14:05:22.405883-03	1
e6ee8ad9-9959-4f9f-a66c-c91007e3aff2	2b9d50b837a154ee3a74284c130b21fbe10ecddc1159cb29dac74c4ba4cb6a5f	2026-01-17 14:05:22.427407-03	20250918182355_add_kafka_integration	\N	\N	2026-01-17 14:05:22.411262-03	1
1c95e554-b935-4c68-bbc7-a682cc498bc4	84053d218d69e85953f7533bbfced9171e762c02c88ab944aaaa75b17f18e161	2026-01-17 14:05:22.441261-03	20251122003044_add_chat_instance_remotejid_unique	\N	\N	2026-01-17 14:05:22.429336-03	1
\.


--
-- Data for Name: cahts_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cahts_settings (key, value) FROM stdin;
evolution_api_url	https://evoapi.synkicrm.com.br
evolution_api_key	44d8ca90603fbeaa903d9735df1331f6
mysql_host	localhost
mysql_port	3306
mysql_user	synki.sistemas@gmail.com
smtp_host	smtp.gmail.com
smtp_port	587
smtp_user	synki.sistemas@gmail.com
smtp_password	ezipnyqzeihirdad
smtp_secure	true
imap_host	imap.gmail.com
imap_port	993
imap_user	synki.sistemas@gmail.com
imap_password	ezipnyqzeihirdad
imap_secure	true
\.


--
-- Name: Chat Chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_pkey" PRIMARY KEY (id);


--
-- Name: Chatwoot Chatwoot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chatwoot"
    ADD CONSTRAINT "Chatwoot_pkey" PRIMARY KEY (id);


--
-- Name: Contact Contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contact"
    ADD CONSTRAINT "Contact_pkey" PRIMARY KEY (id);


--
-- Name: DifySetting DifySetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DifySetting"
    ADD CONSTRAINT "DifySetting_pkey" PRIMARY KEY (id);


--
-- Name: Dify Dify_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dify"
    ADD CONSTRAINT "Dify_pkey" PRIMARY KEY (id);


--
-- Name: EvoaiSetting EvoaiSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvoaiSetting"
    ADD CONSTRAINT "EvoaiSetting_pkey" PRIMARY KEY (id);


--
-- Name: Evoai Evoai_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Evoai"
    ADD CONSTRAINT "Evoai_pkey" PRIMARY KEY (id);


--
-- Name: EvolutionBotSetting EvolutionBotSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvolutionBotSetting"
    ADD CONSTRAINT "EvolutionBotSetting_pkey" PRIMARY KEY (id);


--
-- Name: EvolutionBot EvolutionBot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvolutionBot"
    ADD CONSTRAINT "EvolutionBot_pkey" PRIMARY KEY (id);


--
-- Name: FlowiseSetting FlowiseSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowiseSetting"
    ADD CONSTRAINT "FlowiseSetting_pkey" PRIMARY KEY (id);


--
-- Name: Flowise Flowise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Flowise"
    ADD CONSTRAINT "Flowise_pkey" PRIMARY KEY (id);


--
-- Name: Instance Instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Instance"
    ADD CONSTRAINT "Instance_pkey" PRIMARY KEY (id);


--
-- Name: IntegrationSession IntegrationSession_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationSession"
    ADD CONSTRAINT "IntegrationSession_pkey" PRIMARY KEY (id);


--
-- Name: IsOnWhatsapp IsOnWhatsapp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IsOnWhatsapp"
    ADD CONSTRAINT "IsOnWhatsapp_pkey" PRIMARY KEY (id);


--
-- Name: Kafka Kafka_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kafka"
    ADD CONSTRAINT "Kafka_pkey" PRIMARY KEY (id);


--
-- Name: Label Label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Label"
    ADD CONSTRAINT "Label_pkey" PRIMARY KEY (id);


--
-- Name: Media Media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Media"
    ADD CONSTRAINT "Media_pkey" PRIMARY KEY (id);


--
-- Name: MessageUpdate MessageUpdate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MessageUpdate"
    ADD CONSTRAINT "MessageUpdate_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: N8nSetting N8nSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."N8nSetting"
    ADD CONSTRAINT "N8nSetting_pkey" PRIMARY KEY (id);


--
-- Name: N8n N8n_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."N8n"
    ADD CONSTRAINT "N8n_pkey" PRIMARY KEY (id);


--
-- Name: Nats Nats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nats"
    ADD CONSTRAINT "Nats_pkey" PRIMARY KEY (id);


--
-- Name: OpenaiBot OpenaiBot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiBot"
    ADD CONSTRAINT "OpenaiBot_pkey" PRIMARY KEY (id);


--
-- Name: OpenaiCreds OpenaiCreds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiCreds"
    ADD CONSTRAINT "OpenaiCreds_pkey" PRIMARY KEY (id);


--
-- Name: OpenaiSetting OpenaiSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_pkey" PRIMARY KEY (id);


--
-- Name: Proxy Proxy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Proxy"
    ADD CONSTRAINT "Proxy_pkey" PRIMARY KEY (id);


--
-- Name: Pusher Pusher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pusher"
    ADD CONSTRAINT "Pusher_pkey" PRIMARY KEY (id);


--
-- Name: Rabbitmq Rabbitmq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rabbitmq"
    ADD CONSTRAINT "Rabbitmq_pkey" PRIMARY KEY (id);


--
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- Name: Setting Setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Setting"
    ADD CONSTRAINT "Setting_pkey" PRIMARY KEY (id);


--
-- Name: Sqs Sqs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sqs"
    ADD CONSTRAINT "Sqs_pkey" PRIMARY KEY (id);


--
-- Name: Template Template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Template"
    ADD CONSTRAINT "Template_pkey" PRIMARY KEY (id);


--
-- Name: TypebotSetting TypebotSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TypebotSetting"
    ADD CONSTRAINT "TypebotSetting_pkey" PRIMARY KEY (id);


--
-- Name: Typebot Typebot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Typebot"
    ADD CONSTRAINT "Typebot_pkey" PRIMARY KEY (id);


--
-- Name: Webhook Webhook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Webhook"
    ADD CONSTRAINT "Webhook_pkey" PRIMARY KEY (id);


--
-- Name: Websocket Websocket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Websocket"
    ADD CONSTRAINT "Websocket_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: cahts_settings cahts_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cahts_settings
    ADD CONSTRAINT cahts_settings_pkey PRIMARY KEY (key);


--
-- Name: Chat_instanceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Chat_instanceId_idx" ON public."Chat" USING btree ("instanceId");


--
-- Name: Chat_instanceId_remoteJid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Chat_instanceId_remoteJid_key" ON public."Chat" USING btree ("instanceId", "remoteJid");


--
-- Name: Chat_remoteJid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Chat_remoteJid_idx" ON public."Chat" USING btree ("remoteJid");


--
-- Name: Chatwoot_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Chatwoot_instanceId_key" ON public."Chatwoot" USING btree ("instanceId");


--
-- Name: Contact_instanceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Contact_instanceId_idx" ON public."Contact" USING btree ("instanceId");


--
-- Name: Contact_remoteJid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Contact_remoteJid_idx" ON public."Contact" USING btree ("remoteJid");


--
-- Name: Contact_remoteJid_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Contact_remoteJid_instanceId_key" ON public."Contact" USING btree ("remoteJid", "instanceId");


--
-- Name: DifySetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "DifySetting_instanceId_key" ON public."DifySetting" USING btree ("instanceId");


--
-- Name: EvoaiSetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "EvoaiSetting_instanceId_key" ON public."EvoaiSetting" USING btree ("instanceId");


--
-- Name: EvolutionBotSetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "EvolutionBotSetting_instanceId_key" ON public."EvolutionBotSetting" USING btree ("instanceId");


--
-- Name: FlowiseSetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "FlowiseSetting_instanceId_key" ON public."FlowiseSetting" USING btree ("instanceId");


--
-- Name: Instance_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Instance_name_key" ON public."Instance" USING btree (name);


--
-- Name: IsOnWhatsapp_remoteJid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IsOnWhatsapp_remoteJid_key" ON public."IsOnWhatsapp" USING btree ("remoteJid");


--
-- Name: Kafka_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Kafka_instanceId_key" ON public."Kafka" USING btree ("instanceId");


--
-- Name: Label_labelId_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Label_labelId_instanceId_key" ON public."Label" USING btree ("labelId", "instanceId");


--
-- Name: Media_messageId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Media_messageId_key" ON public."Media" USING btree ("messageId");


--
-- Name: MessageUpdate_instanceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "MessageUpdate_instanceId_idx" ON public."MessageUpdate" USING btree ("instanceId");


--
-- Name: MessageUpdate_messageId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "MessageUpdate_messageId_idx" ON public."MessageUpdate" USING btree ("messageId");


--
-- Name: Message_instanceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Message_instanceId_idx" ON public."Message" USING btree ("instanceId");


--
-- Name: N8nSetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "N8nSetting_instanceId_key" ON public."N8nSetting" USING btree ("instanceId");


--
-- Name: Nats_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Nats_instanceId_key" ON public."Nats" USING btree ("instanceId");


--
-- Name: OpenaiCreds_apiKey_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "OpenaiCreds_apiKey_key" ON public."OpenaiCreds" USING btree ("apiKey");


--
-- Name: OpenaiCreds_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "OpenaiCreds_name_key" ON public."OpenaiCreds" USING btree (name);


--
-- Name: OpenaiSetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "OpenaiSetting_instanceId_key" ON public."OpenaiSetting" USING btree ("instanceId");


--
-- Name: OpenaiSetting_openaiCredsId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "OpenaiSetting_openaiCredsId_key" ON public."OpenaiSetting" USING btree ("openaiCredsId");


--
-- Name: Proxy_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Proxy_instanceId_key" ON public."Proxy" USING btree ("instanceId");


--
-- Name: Pusher_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Pusher_instanceId_key" ON public."Pusher" USING btree ("instanceId");


--
-- Name: Rabbitmq_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Rabbitmq_instanceId_key" ON public."Rabbitmq" USING btree ("instanceId");


--
-- Name: Session_sessionId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Session_sessionId_key" ON public."Session" USING btree ("sessionId");


--
-- Name: Setting_instanceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Setting_instanceId_idx" ON public."Setting" USING btree ("instanceId");


--
-- Name: Setting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Setting_instanceId_key" ON public."Setting" USING btree ("instanceId");


--
-- Name: Sqs_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Sqs_instanceId_key" ON public."Sqs" USING btree ("instanceId");


--
-- Name: Template_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Template_name_key" ON public."Template" USING btree (name);


--
-- Name: Template_templateId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Template_templateId_key" ON public."Template" USING btree ("templateId");


--
-- Name: TypebotSetting_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "TypebotSetting_instanceId_key" ON public."TypebotSetting" USING btree ("instanceId");


--
-- Name: Webhook_instanceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Webhook_instanceId_idx" ON public."Webhook" USING btree ("instanceId");


--
-- Name: Webhook_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Webhook_instanceId_key" ON public."Webhook" USING btree ("instanceId");


--
-- Name: Websocket_instanceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Websocket_instanceId_key" ON public."Websocket" USING btree ("instanceId");


--
-- Name: idx_chat_remotejid_instanceid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chat_remotejid_instanceid ON public."Chat" USING btree ("remoteJid", "instanceId");


--
-- Name: idx_contact_instanceid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contact_instanceid ON public."Contact" USING btree ("instanceId");


--
-- Name: idx_contact_remotejid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contact_remotejid ON public."Contact" USING btree ("remoteJid");


--
-- Name: idx_contact_remotejid_instanceid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contact_remotejid_instanceid ON public."Contact" USING btree ("remoteJid", "instanceId");


--
-- Name: idx_instance_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_instance_name ON public."Instance" USING btree (name);


--
-- Name: idx_message_instanceid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_message_instanceid ON public."Message" USING btree ("instanceId");


--
-- Name: idx_message_remotejid_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_message_remotejid_status ON public."MessageUpdate" USING btree ("remoteJid", status) WHERE ((status IS NOT NULL) AND ((status)::text <> 'ERROR'::text));


--
-- Name: Chat Chat_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Chatwoot Chatwoot_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chatwoot"
    ADD CONSTRAINT "Chatwoot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Contact Contact_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contact"
    ADD CONSTRAINT "Contact_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DifySetting DifySetting_difyIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DifySetting"
    ADD CONSTRAINT "DifySetting_difyIdFallback_fkey" FOREIGN KEY ("difyIdFallback") REFERENCES public."Dify"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DifySetting DifySetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DifySetting"
    ADD CONSTRAINT "DifySetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Dify Dify_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dify"
    ADD CONSTRAINT "Dify_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EvoaiSetting EvoaiSetting_evoaiIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvoaiSetting"
    ADD CONSTRAINT "EvoaiSetting_evoaiIdFallback_fkey" FOREIGN KEY ("evoaiIdFallback") REFERENCES public."Evoai"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EvoaiSetting EvoaiSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvoaiSetting"
    ADD CONSTRAINT "EvoaiSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Evoai Evoai_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Evoai"
    ADD CONSTRAINT "Evoai_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EvolutionBotSetting EvolutionBotSetting_botIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvolutionBotSetting"
    ADD CONSTRAINT "EvolutionBotSetting_botIdFallback_fkey" FOREIGN KEY ("botIdFallback") REFERENCES public."EvolutionBot"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EvolutionBotSetting EvolutionBotSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvolutionBotSetting"
    ADD CONSTRAINT "EvolutionBotSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EvolutionBot EvolutionBot_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EvolutionBot"
    ADD CONSTRAINT "EvolutionBot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FlowiseSetting FlowiseSetting_flowiseIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowiseSetting"
    ADD CONSTRAINT "FlowiseSetting_flowiseIdFallback_fkey" FOREIGN KEY ("flowiseIdFallback") REFERENCES public."Flowise"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FlowiseSetting FlowiseSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowiseSetting"
    ADD CONSTRAINT "FlowiseSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Flowise Flowise_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Flowise"
    ADD CONSTRAINT "Flowise_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IntegrationSession IntegrationSession_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IntegrationSession"
    ADD CONSTRAINT "IntegrationSession_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kafka Kafka_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kafka"
    ADD CONSTRAINT "Kafka_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Label Label_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Label"
    ADD CONSTRAINT "Label_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Media Media_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Media"
    ADD CONSTRAINT "Media_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Media Media_messageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Media"
    ADD CONSTRAINT "Media_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES public."Message"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MessageUpdate MessageUpdate_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MessageUpdate"
    ADD CONSTRAINT "MessageUpdate_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MessageUpdate MessageUpdate_messageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MessageUpdate"
    ADD CONSTRAINT "MessageUpdate_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES public."Message"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."IntegrationSession"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: N8nSetting N8nSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."N8nSetting"
    ADD CONSTRAINT "N8nSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: N8nSetting N8nSetting_n8nIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."N8nSetting"
    ADD CONSTRAINT "N8nSetting_n8nIdFallback_fkey" FOREIGN KEY ("n8nIdFallback") REFERENCES public."N8n"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: N8n N8n_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."N8n"
    ADD CONSTRAINT "N8n_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Nats Nats_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nats"
    ADD CONSTRAINT "Nats_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiBot OpenaiBot_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiBot"
    ADD CONSTRAINT "OpenaiBot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiBot OpenaiBot_openaiCredsId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiBot"
    ADD CONSTRAINT "OpenaiBot_openaiCredsId_fkey" FOREIGN KEY ("openaiCredsId") REFERENCES public."OpenaiCreds"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiCreds OpenaiCreds_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiCreds"
    ADD CONSTRAINT "OpenaiCreds_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiSetting OpenaiSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiSetting OpenaiSetting_openaiCredsId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_openaiCredsId_fkey" FOREIGN KEY ("openaiCredsId") REFERENCES public."OpenaiCreds"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OpenaiSetting OpenaiSetting_openaiIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_openaiIdFallback_fkey" FOREIGN KEY ("openaiIdFallback") REFERENCES public."OpenaiBot"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Proxy Proxy_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Proxy"
    ADD CONSTRAINT "Proxy_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Pusher Pusher_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pusher"
    ADD CONSTRAINT "Pusher_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rabbitmq Rabbitmq_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rabbitmq"
    ADD CONSTRAINT "Rabbitmq_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Session Session_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Setting Setting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Setting"
    ADD CONSTRAINT "Setting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Sqs Sqs_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sqs"
    ADD CONSTRAINT "Sqs_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Template Template_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Template"
    ADD CONSTRAINT "Template_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TypebotSetting TypebotSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TypebotSetting"
    ADD CONSTRAINT "TypebotSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TypebotSetting TypebotSetting_typebotIdFallback_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TypebotSetting"
    ADD CONSTRAINT "TypebotSetting_typebotIdFallback_fkey" FOREIGN KEY ("typebotIdFallback") REFERENCES public."Typebot"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Typebot Typebot_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Typebot"
    ADD CONSTRAINT "Typebot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Webhook Webhook_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Webhook"
    ADD CONSTRAINT "Webhook_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Websocket Websocket_instanceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Websocket"
    ADD CONSTRAINT "Websocket_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES public."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict AfnUCq3nQq0uTdqz4EkaHI8QopO2o4tfseUXh9XduDO96fYYWJvN48Jh40ApLQh

