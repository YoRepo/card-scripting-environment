--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gash the Dust Lord  (ID: 19012345)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1000 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card inflicts battle damage to your opponent: Increase the Level of this card by 1 (max.
-- 12).
--[[ __CARD_HEADER_END__ ]]

--灰塵王 アッシュ・ガッシュ
function c19012345.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19012345,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c19012345.condition)
	e1:SetOperation(c19012345.operation)
	c:RegisterEffect(e1)
end
function c19012345.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():IsLevelBelow(11)
end
function c19012345.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
