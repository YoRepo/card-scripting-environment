--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Chronomaly Colossal Head  (ID: 52158283)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 800 | DEF 1600
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can banish this card from your Graveyard to target 1 Level 3 or higher Attack Position monster
-- on the field; change it to face-up or face-down Defense Position.
-- The effect of "Chronomaly Colossal Head" can only be used once per turn.
--[[ __CARD_HEADER_END__ ]]

--先史遺産コロッサル・ヘッド
function c52158283.initial_effect(c)
	--adchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52158283,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,52158283)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c52158283.target)
	e1:SetOperation(c52158283.operation)
	c:RegisterEffect(e1)
end
function c52158283.filter(c)
	return c:IsAttackPos() and c:IsLevelAbove(3)
end
function c52158283.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c52158283.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c52158283.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c52158283.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c52158283.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:IsAttackPos() then
			local pos=0
			if tc:IsCanTurnSet() then
				pos=Duel.SelectPosition(tp,tc,POS_DEFENSE)
			else
				pos=Duel.SelectPosition(tp,tc,POS_FACEUP_DEFENSE)
			end
			Duel.ChangePosition(tc,pos)
		else
			Duel.ChangePosition(tc,0,0,POS_FACEDOWN_DEFENSE,POS_FACEUP_DEFENSE)
		end
	end
end
