--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Jabbing Panda  (ID: 36539330)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast-Warrior
-- Level: 3
-- ATK 1500 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If 2 or more Beast-Warrior monsters are on the field, you can Special Summon this card (from your
-- hand).
-- You can only Special Summon "Jabbing Panda" once per turn this way.
-- If this card is sent from the field to your GY: You can target 1 face-up monster you control; it
-- gains 500 ATK.
-- You can only use this effect of "Jabbing Panda" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ジャブィアント・パンダ
function c36539330.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,36539330+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c36539330.spcon)
	c:RegisterEffect(e1)
	--add atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,36539331)
	e2:SetCondition(c36539330.tgcon)
	e2:SetTarget(c36539330.tgtg)
	e2:SetOperation(c36539330.tgop)
	c:RegisterEffect(e2)
end
function c36539330.spfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEASTWARRIOR)
end
function c36539330.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c36539330.spfilter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil)
end
function c36539330.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c36539330.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,tp,500)
end
function c36539330.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
