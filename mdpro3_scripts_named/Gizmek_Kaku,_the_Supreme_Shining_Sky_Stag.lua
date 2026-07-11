--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gizmek Kaku, the Supreme Shining Sky Stag  (ID: 63633694)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level: 9
-- ATK 2750 | DEF 2750
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a monster is in the Extra Monster Zone: You can Special Summon this card from your hand.
-- You can target 1 face-up monster in the Extra Monster Zone; equip that face-up monster to this card
-- (max. 1).
-- When this card destroys an opponent's monster by battle: You can Special Summon 1 of your Monster
-- Cards equipped to this card.
-- You can only use each effect of "Gizmek Kaku, the Supreme Shining Sky Stag" once per turn.
--[[ __CARD_HEADER_END__ ]]

--機巧蹄－天迦久御雷
function c63633694.initial_effect(c)
	--spsummon1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63633694,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,63633694)
	e1:SetCondition(c63633694.spcon1)
	e1:SetTarget(c63633694.sptg1)
	e1:SetOperation(c63633694.spop1)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63633694,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,63633695)
	e2:SetCondition(c63633694.eqcon)
	e2:SetTarget(c63633694.eqtg)
	e2:SetOperation(c63633694.eqop)
	c:RegisterEffect(e2)
	--spsummon2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(63633694,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCountLimit(1,63633696)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c63633694.sptg2)
	e3:SetOperation(c63633694.spop2)
	c:RegisterEffect(e3)
end
function c63633694.cfilter(c)
	return c:GetSequence()>4
end
function c63633694.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c63633694.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)>0
end
function c63633694.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c63633694.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c63633694.eqfilter(c,tp)
	return c:IsFaceup() and c:GetSequence()>4 and (c:IsControler(tp) or c:IsAbleToChangeControler())
end
function c63633694.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetLabelObject()
	return ec==nil or ec:GetFlagEffect(63633694)==0
end
function c63633694.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c63633694.eqfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c63633694.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c63633694.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
end
function c63633694.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if not Duel.Equip(tp,tc,c,false) then return end
		tc:RegisterFlagEffect(63633694,RESET_EVENT+RESETS_STANDARD,0,0)
		e:SetLabelObject(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c63633694.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c63633694.eqlimit(e,c)
	return e:GetOwner()==c
end
function c63633694.spfilter(c,e,tp)
	return c:GetEquipTarget()==e:GetHandler() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c63633694.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c63633694.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE)
end
function c63633694.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c63633694.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
