--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Winged Minion  (ID: 89258225)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 2
-- ATK 700 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute this card, then target 1 Fiend monster on the field; it gains 700 ATK/DEF while face-up in
-- the Monster Zone.
--[[ __CARD_HEADER_END__ ]]

--ハ・デスの使い魔
function c89258225.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89258225,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c89258225.cost)
	e1:SetTarget(c89258225.target)
	e1:SetOperation(c89258225.operation)
	c:RegisterEffect(e1)
end
function c89258225.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c89258225.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c89258225.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c89258225.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89258225.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c89258225.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c89258225.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and c89258225.filter(tc) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(700)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
