--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: White Steed of the Floral Knights  (ID: 11426487)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast
-- Level: 6
-- ATK 2400 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a Level 2 or lower monster, you can Special Summon this card (from your hand) in
-- Defense Position.
-- You can only Special Summon "White Steed of the Floral Knights" once per turn this way.
-- When an opponent's monster declares an attack: You can banish this card from your GY, then target 1
-- card you control; negate the attack, and if you do, destroy that targeted card.
-- You can only use this effect of "White Steed of the Floral Knights" once per turn.
--[[ __CARD_HEADER_END__ ]]

--花騎士団の白馬
function c11426487.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetCountLimit(1,11426487+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c11426487.spcon)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11426487,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,11426487)
	e2:SetCondition(c11426487.negcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c11426487.negtg)
	e2:SetOperation(c11426487.negop)
	c:RegisterEffect(e2)
end
function c11426487.spfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(2)
end
function c11426487.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c11426487.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c11426487.negcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp)
end
function c11426487.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c11426487.negop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.NegateAttack() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
