--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Ice Princess Zereort  (ID: 13183454)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Winged Beast
-- Rank: 5
-- ATK 2500 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 5 Winged Beast-Type monsters
-- You can detach 1 Xyz Material from this card, then target 1 face-up monster your opponent controls;
-- its ATK becomes 0.
--[[ __CARD_HEADER_END__ ]]

--零鳥姫リオート・ハルピュイア
function c13183454.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),5,2)
	c:EnableReviveLimit()
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13183454,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c13183454.cost)
	e1:SetTarget(c13183454.target)
	e1:SetOperation(c13183454.operation)
	c:RegisterEffect(e1)
end
function c13183454.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c13183454.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c13183454.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c13183454.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13183454.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c13183454.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c13183454.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetAttack()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
