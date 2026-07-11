--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Overlay Booster  (ID: 75214390)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 5
-- ATK 2000 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a monster with 2000 or more ATK, you can Special Summon this card (from your hand) in
-- Defense Position.
-- You can only Special Summon "Overlay Booster" once per turn this way.
-- If this card is in your GY, except the turn it was sent there: You can banish it, then target 1
-- face-up Xyz Monster you control that has material; it gains 500 ATK for each material attached to
-- it.
--[[ __CARD_HEADER_END__ ]]

--オーバーレイ・ブースター
function c75214390.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,75214390+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c75214390.spcon)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75214390,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c75214390.atktg)
	e2:SetOperation(c75214390.atkop)
	c:RegisterEffect(e2)
end
function c75214390.cfilter(c)
	return c:IsFaceup() and c:IsAttackAbove(2000)
end
function c75214390.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75214390.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c75214390.filter(c)
	return c:IsFaceup() and c:GetOverlayCount()>0
end
function c75214390.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75214390.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75214390.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c75214390.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75214390.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(tc:GetOverlayCount()*500)
		tc:RegisterEffect(e1)
	end
end
