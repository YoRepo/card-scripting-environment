--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Canon the Melodious Diva  (ID: 16021142)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1400 | DEF 2000
-- Setcode: 0x9b
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Melodious" monster, you can Special Summon this card (from your hand).
-- You can only Special Summon "Canon the Melodious Diva" once per turn this way.
-- Once per turn: You can target 1 "Melodious" monster you control; change its battle position.
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女カノン
function c16021142.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,16021142+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c16021142.spcon)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16021142,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c16021142.postg)
	e2:SetOperation(c16021142.posop)
	c:RegisterEffect(e2)
end
function c16021142.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9b)
end
function c16021142.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c16021142.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c16021142.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9b) and c:IsCanChangePosition()
end
function c16021142.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c16021142.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16021142.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c16021142.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c16021142.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
