--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Liberator Eto  (ID: 24643913)
-- Type: Monster / Effect / Special Summon
-- Attribute: DARK
-- Race: Reptile
-- Level: 8
-- ATK 4000 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned/Set.
-- Must be Special Summoned (from your hand or GY) by paying half your LP, while your opponent has a
-- Monster Card in their field or GY with an effect that activates in the hand or Monster Zone in
-- response to a card or effect activation.
-- You can only Special Summon "Liberator Eto" once per turn this way.
-- This card's Special Summon cannot be negated.
-- This face-up card cannot be used as material for a Fusion, Synchro, Xyz, or Link Summon, also during
-- your turn only, it is unaffected by monster effects activated on your opponent's field.
--[[ __CARD_HEADER_END__ ]]

--叛逆者エト
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(s.spcon)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--cannot be material
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e6)
	local e7=e4:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e7:SetValue(s.fuslimit)
	c:RegisterEffect(e7)
	--immune
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(s.efilter)
	c:RegisterEffect(e8)
end
function s.quick_filter(e)
	return (e:GetCode()==EVENT_CHAINING or e:GetCode()==EVENT_BECOME_TARGET) and e:IsHasType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_QUICK_F) and e:IsHasRange(LOCATION_HAND+LOCATION_MZONE)
end
function s.cfilter(c)
	return c:IsOriginalEffectProperty(s.quick_filter) and c:GetOriginalType()&TYPE_MONSTER==TYPE_MONSTER and c:IsFaceupEx()
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.cfilter,c:GetControler(),0,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function s.fuslimit(e,c,sumtype)
	return sumtype==SUMMON_TYPE_FUSION
end
function s.efilter(e,re)
	if Duel.GetTurnPlayer()==e:GetHandlerPlayer() and e:GetHandlerPlayer()~=re:GetOwnerPlayer()
		and re:IsActivated() and re:IsActiveType(TYPE_MONSTER) then
		local loc=Duel.GetChainInfo(0,CHAININFO_TRIGGERING_LOCATION) or 0
		return LOCATION_ONFIELD&loc~=0
	end
	return false
end
