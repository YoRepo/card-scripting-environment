--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 古怪少年  (ID: 16825874)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Spellcaster
-- Level 3
-- ATK 800 | DEF 200
--
-- Effect Text:
-- 把这张卡作为同调素材的场合，其他的同调素材怪兽必须是手卡1只怪兽。这张卡为同调素材的同调怪兽效果不能发动并无效化，从场上离开的场合从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--エキセントリック・ボーイ
function c16825874.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(1,1)
	e1:SetValue(LOCATION_HAND)
	c:RegisterEffect(e1)
	--be material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_EVENT_PLAYER)
	e2:SetCondition(c16825874.ccon)
	e2:SetOperation(c16825874.cop)
	c:RegisterEffect(e2)
end
function c16825874.ccon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c16825874.cop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	--leave redirect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e1:SetValue(LOCATION_REMOVED)
	e1:SetReset(RESET_EVENT+0x7e0000)
	rc:RegisterEffect(e1,true)
	--cannot trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e2,true)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e3,true)
end
