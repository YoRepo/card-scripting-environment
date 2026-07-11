--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Maximum Six  (ID: 30707994)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 1900 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Tribute Summoned: Roll a six-sided die, and this card gains ATK equal to the
-- result x 200.
--[[ __CARD_HEADER_END__ ]]

--マキシマム・シックス
function c30707994.initial_effect(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30707994,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c30707994.condition)
	e1:SetTarget(c30707994.target)
	e1:SetOperation(c30707994.operation)
	c:RegisterEffect(e1)
end
function c30707994.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c30707994.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c30707994.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local dice=Duel.TossDice(tp,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(dice*200)
		c:RegisterEffect(e1)
	end
end
