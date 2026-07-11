--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Iron Chain Coil  (ID: 53152590)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level: 3
-- ATK 1100 | DEF 1600
-- Setcode: 0x25
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can select 1 "Iron Chain" monster you control to have it gain 300 ATK and DEF as
-- long as this card is face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--C・コイル
function c53152590.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53152590,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c53152590.atktg)
	e1:SetOperation(c53152590.atkop)
	c:RegisterEffect(e1)
end
function c53152590.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x25)
end
function c53152590.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c53152590.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c53152590.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c53152590.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c53152590.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
