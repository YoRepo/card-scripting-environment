--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Elemental HERO Poison Rose  (ID: 51085303)
-- Type: Monster / Effect / Special Summon
-- Attribute: EARTH
-- Race: Plant
-- Level: 6
-- ATK 1900 | DEF 2000
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned or Set.
-- Must be Special Summoned with "Rose Bud" and cannot be Special Summoned by other ways.
-- Each time this card inflicts Battle Damage to your opponent: It gains 200 ATK and loses 200 DEF.
-- Your opponent can only target "Elemental HERO Poison Rose" for attacks.
--[[ __CARD_HEADER_END__ ]]

--E・HERO ブルーメ
function c51085303.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51085303,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c51085303.adcon)
	e2:SetOperation(c51085303.adop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c51085303.atlimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e4)
end
function c51085303.adcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c51085303.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:GetDefense()>=200 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(-200)
		c:RegisterEffect(e2)
	end
end
function c51085303.atlimit(e,c)
	return c:IsFacedown() or not c:IsCode(51085303)
end
