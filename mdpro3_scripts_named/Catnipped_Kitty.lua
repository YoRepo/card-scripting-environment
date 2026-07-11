--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Catnipped Kitty  (ID: 96501677)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 2
-- ATK 0 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be attacked if there is another Beast-Type monster on your side of the field.
-- Once per turn, you can make the DEF of 1 monster on your opponent's side of the field 0 until the
-- end of this turn.
--[[ __CARD_HEADER_END__ ]]

--またたびキャット
function c96501677.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c96501677.ccon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--defdown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96501677,0))
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c96501677.deftg)
	e2:SetOperation(c96501677.defop)
	c:RegisterEffect(e2)
end
function c96501677.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c96501677.ccon(e)
	return Duel.IsExistingMatchingCard(c96501677.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c96501677.deftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return aux.nzdef(chkc) and chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.nzdef,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,aux.nzdef,tp,0,LOCATION_MZONE,1,1,nil)
end
function c96501677.defop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(0)
		tc:RegisterEffect(e1)
	end
end
