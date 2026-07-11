--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Giganticastle  (ID: 63422098)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Rock
-- Level: 9
-- ATK 2900 | DEF 2800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1 or more non-Tuner monsters
-- This card gains 200 ATK and DEF for each non-Tuner Synchro Material Monster used to Synchro Summon
-- this card.
--[[ __CARD_HEADER_END__ ]]

--鬼岩城
function c63422098.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c63422098.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c63422098.regop)
	c:RegisterEffect(e3)
end
function c63422098.val(e,c)
	local ct=e:GetHandler():GetFlagEffectLabel(63422098)
	if not ct then return 0 end
	return ct
end
function c63422098.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsSummonType(SUMMON_TYPE_SYNCHRO) then
		local ct=c:GetMaterialCount()-1
		c:RegisterFlagEffect(63422098,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0,ct*200)
	end
end
