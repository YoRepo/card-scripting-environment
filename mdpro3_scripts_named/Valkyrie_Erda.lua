--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Valkyrie Erda  (ID: 83705073)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 8
-- ATK 2000 | DEF 2200
-- Setcode: 0x122
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Valkyrie Erda".
-- While you control this card, Special Summoned by the effect of a "Valkyrie" card, all face-up
-- monsters your opponent controls lose 1000 ATK.
-- Any card destroyed by battle or card effect that would be sent to your opponent's GY is banished
-- instead.
--[[ __CARD_HEADER_END__ ]]

--ワルキューレ・エルダ
function c83705073.initial_effect(c)
	c:SetUniqueOnField(1,0,83705073)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c83705073.atkcon)
	e1:SetOperation(c83705073.atkop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(LOCATION_REMOVED)
	e2:SetTarget(c83705073.rmtg)
	c:RegisterEffect(e2)
end
function c83705073.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x122)
end
function c83705073.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetDescription(aux.Stringid(83705073,0))
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-1000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c83705073.rmtg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer() and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
