--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Garlandolf, King of Destruction  (ID: 30646525)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK 2500 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be Ritual Summoned with the Ritual Spell Card, "Ritual of Destruction".
-- When this card is Ritual Summoned, destroy all other face-up monsters on the field with DEF less
-- than or equal to this card's ATK.
-- This card gains 100 ATK for each monster destroyed by this effect.
--[[ __CARD_HEADER_END__ ]]

--破滅の魔王ガーランドルフ
function c30646525.initial_effect(c)
	aux.AddCodeList(c,52913738)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetDescription(aux.Stringid(30646525,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c30646525.condition)
	e1:SetTarget(c30646525.target)
	e1:SetOperation(c30646525.operation)
	c:RegisterEffect(e1)
end
function c30646525.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c30646525.filter(c,atk)
	return c:IsFaceup() and c:IsDefenseBelow(atk)
end
function c30646525.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c30646525.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c30646525.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c30646525.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
