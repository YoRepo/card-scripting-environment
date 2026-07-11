--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Edge Imp Frightfuloid  (ID: 34566435)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1300 | DEF 1300
-- Setcode: 0xc3, 0xad
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as a "Frightfur" card.)
-- You can target 1 "Frightfur" Fusion Monster you control or in your Graveyard; this card's ATK and
-- DEF each become equal to the original ATK and DEF of that monster, until the end of this turn.
-- You can only use this effect of "Edge Imp Frightfuloid" once per turn.
--[[ __CARD_HEADER_END__ ]]

--エッジインプ・DTモドキ
function c34566435.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34566435,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,34566435)
	e1:SetTarget(c34566435.target)
	e1:SetOperation(c34566435.operation)
	c:RegisterEffect(e1)
end
function c34566435.filter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsType(TYPE_FUSION) and c:IsSetCard(0xad)
end
function c34566435.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and c34566435.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c34566435.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c34566435.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
end
function c34566435.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and (tc:IsLocation(LOCATION_GRAVE) or tc:IsFaceup()) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(tc:GetBaseDefense())
		c:RegisterEffect(e2)
	end
end
