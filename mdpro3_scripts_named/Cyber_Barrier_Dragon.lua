--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Cyber Barrier Dragon  (ID: 68774379)
-- Type: Monster / Effect / Special Summon
-- Attribute: LIGHT
-- Race: Machine
-- Level: 6
-- ATK 800 | DEF 2800
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Normal Summoned or Set.
-- This card cannot be Special Summoned except with "Attack Reflector Unit".
-- Once per turn, while this card is in Attack Position, your opponent's next attack is negated.
--[[ __CARD_HEADER_END__ ]]

--サイバー・バリア・ドラゴン
function c68774379.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c68774379.discon)
	e2:SetOperation(c68774379.disop)
	c:RegisterEffect(e2)
end
function c68774379.discon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK) and eg:GetFirst():IsControler(1-tp)
end
function c68774379.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
